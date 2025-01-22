/* Prerequisitos: Descomposición LRU, triangular inferior y superior */

function x = tringularSuperior(A, b)
    // Description of tringularSuperior(A, b)
    //  A: matriz triangular superior
    //  b: vector de términos independientes

    // Fila | Columna
    [nA,mA] = size(A) 
    [nb,mb] = size(b)

    if nA<>mA then
        error('triangularSuperior - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('triangularSuperior - dimensiones incompatibles entre A y b');
        abort;
    end;

    // Ab = [A b]; // Matriz aumentada

    // Resolución del sistema
    x(nA) = b(nA) / A(nA,nA);

    for i = nA-1:-1:1 
        // x_i = (b_i - sum_{k=i+1}^{Na} A_{ik} x_k) / a_{ii}
        sum_k = A(i, i+1:nA) * x(i+1:nA); // Hacer la suma es lo mismo que hacer el producto interno
        x(i)  = (b(i) - sum_k) / A(i,i);
    end;
endfunction

function x = tringularInferior(A, b)
    // Description of tringularInferior(A, b)
    //  A: matriz triangular inferior
    //  b: vector de términos independientes

    // Fila | Columna
    [nA,mA] = size(A) 
    [nb,mb] = size(b)

    if nA<>mA then
        error('triangularSuperior - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('triangularSuperior - dimensiones incompatibles entre A y b');
        abort;
    end;

    Ab = [A b]; // Matriz aumentada

    // Resolución del sistema

    x(1) = Ab(1,nA+1)/A(1,1);
    for i = 2:nA
        // x_i = (b_i - sum_{k=1}^{i-1} a_{ik} x_k) / a_{ii}
        sum_k = A(i,1:i-1) * x(1:i-1); // Hacer la suma es lo mismo que hacer el producto interno
        x(i) = (b(i) - sum_k) / A(i,i);
    end;
endfunction

function [P, L, U] = gausselimPLU(A)
    // Description of gausselimPLU(A)

    [nA,mA] = size(A) 

    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    end;

    U = A;

    // Defino a L como la identidad con la misma dimensión que A
    L = eye(A);

    // Defino a P como la identidad con la misma dimensión que A
    P = eye(A);

    // Eliminación progresiva (con pivoteo parcial)

    for k = 1:nA-1

        // Busco el máximo de la columna k a partir de la fila k
        // Los anteriores ya fueron eliminados
        kpivot = k; amax = abs(U(k,k));  //pivoteo

        for i=k+1:nA
            if abs(U(i,k))>amax then
                kpivot = i; amax = U(i,k);
            end;
        end;

        // Intercambio de filas para el pivoteo

        // Intercambio de filas en U
        temp = U(kpivot,k:nA); U(kpivot,k:nA) = U(k,k:nA); U(k,k:nA) = temp;
        // Intercambio de filas en L
        temp = L(kpivot,1:k-1); L(kpivot,1:k-1) = L(k,1:k-1); L(k,1:k-1) = temp;
        // Intercambio de filas en P
        temp = P(kpivot,:); P(kpivot,:) = P(k,:);P(k,:) = temp;

        // Eliminación de la columna k para todas las filas i>k
        L(k+1:nA,k) = U(k+1:nA,k)/U(k,k)
        U(k+1:nA,k:nA) = U(k+1:nA,k:nA) - L(k+1:nA,k)*U(k, k:nA)
    end

endfunction

/* Método  */

function x = resolverPLU(P, L, U, b)
    // Description of resolverPLU(P, L, U, b)
    //  P: matriz de permutación
    //  L: matriz triangular inferior
    //  U: matriz triangular superior
    //  b: vector de términos independientes

    y = tringularInferior(L, P * b);
    x = tringularSuperior(U, y);
endfunction


function [U,ind] = cholesky(A)
    // Factorización de Cholesky.
    // Trabaja únicamente con la parte triangular superior.
    //
    // ind = 1  si se obtuvo la factorización de Cholesky.
    //     = 0  si A no es definida positiva
    //
    //******************
    eps = 1.0e-8
    //******************

    n = size(A,1)
    U = zeros(n,n)

    t = A(1,1)
    if t <= eps then
        printf('Matriz no definida positiva.\n')
        ind = 0
        return
    end
    U(1,1) = sqrt(t)
    for j = 2:n
        U(1,j) = A(1,j)/U(1,1)
    end
        
    for k = 2:n
        t = A(k,k) - U(1:k-1,k)'*U(1:k-1,k)
        if t <= eps then
            printf('Matriz no definida positiva.\n')
            ind = 0
            return
        end
        U(k,k) = sqrt(t)
        for j = k+1:n
            U(k,j) = ( A(k,j) - U(1:k-1,k)'*U(1:k-1,j) )/U(k,k)
        end
    end
    ind = 1

endfunction

function [Q, R] = qr(A)
    // Description of qr(A)
    //  A: matriz con columnas linealmente independientes
    //  Q: matriz ortogonal
    //  R: matriz triangular superior

    [m, n] = size(A);

    if n > m then
        disp('La matriz A debe tener más filas que columnas');
        Q = %nan;
        R = %nan;
        return;
    end

    Q = zeros(m, n);
    R = zeros(m, m);

    a_1 = norm(A(:, 1));

    Q(:,1) = A(:, 1) ./ a_1;
    R(1,1) = a_1

    for k = 2:m
        // Sumatoria de los productos internos
        a_k = zeros(m, 1);
        for i = 1:k-1
            a_k = a_k + (A(:, k)' * Q(:, i)) * Q(:, i);
        end
        a_k = A(:, k) - a_k;
        
        //Norma de la columna k
        a_kn = norm(a_k); 

        R(k, k) = a_kn;
        Q(:,k) = a_k ./ a_kn;
    end

    for i = 1:m-1      // Fila
        for j = i+1:n  // Columna
                       // La diagonal ya está calculada
            R(i, j) = A(:,j)' * Q(:, i);
        end
    end
endfunction

A = [16 -12 8 ; -12 18 -6 ; 8 -6 8];
B = [76 -66 46]';

[R,ind] = cholesky(A);

if ind == 1 then
    printf("cholesky) x = \n");
    x = resolverPLU(eye(A), R', R, B)
    disp(x);
end

printf("qr) x = \n");
[Q, R] = qr(A);
x = tringularSuperior(R, Q' * B);

disp(x);

function A = A_c(c)
    A = zeros(5, 5)
    d = 1 + 2 * c
    for i = 1:4
        A(i,i) = d
        A(i, i+1) = -c
        A(i+1, i) = -c
    end
    A(5,5) = d
endfunction

[l,u,p]=lu(A_c(1))

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

x0 = [10, 12, 12, 12, 10]'

printf("x0")
disp(x0)
printf("x1")
x1 = resolverPLU(p, l, u, x0)
disp(x1)
printf("x2")
x2 = resolverPLU(p, l, u, x1)
disp(x2)
printf("x3")
x3 = resolverPLU(p, l, u, x2)
disp(x3)
printf("x4")
x4 = resolverPLU(p, l, u, x3)
disp(x4)

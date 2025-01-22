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

function [L, U] = doolittle(A)
    // Description of doolittle(A)
    //  A: matriz cuadrada
    //  L: matriz triangular inferior
    //  U: matriz triangular superior

    [m, n] = size(A);
    if m <> n then
        disp('La matriz no es cuadrada');
        return;
    end

    L = eye(A);
    U = zeros(m, n);

    U(1, :) = A(1, :); // 1 = i <= j \forall j \in [1, n]
                       // Puedo completar la primera fila de U

    for i = 2:m        // i > 2 > j = 1 \forall i \in [2, n]
                       // Puedo completar la primera columna de L
        L(i, 1) = A(i, 1) / U(1, 1); // 1 = j < i
    end

    for i = 2:m
        for j = 2:n
            if i <= j then
                U(i, j) = A(i, j) - L(i, 1:i-1) * U(1:i-1, j);
            else
                L(i, j) = (A(i, j) - L(i, 1:j-1) * U(1:j-1, j)) / U(j, j);
            end
        end
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

A = [ 1 2 3 4 ; 1 4 9 16 ; 1 8 27 64 ; 1 16 81 256 ]

b1 = [ 2 10 44 190]'

[L, U] = doolittle(A)

x1 = resolverPLU(eye(A), L, U, b1)

printf('x1 = \n'); disp(x1)
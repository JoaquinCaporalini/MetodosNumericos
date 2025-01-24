A1 = [0 2 4 ; 1 -1 -1 ; 1 -1 2];
b1 = [0 ; 0.375 ; 0];

A2 = [1 -1 0 ; -1 2 -1 ; 0 -1 1.1];
b2 = [0 ; 1 ; 0];

// a) Para asegurar la convergencia  del método iterativo de Jacobi, se debe
// cumplir que el radio espectral de la matriz de Jacobi sea menor que 1.

function r = r_Jacobi(A)
    D_inv = diag(diag(1 ./ A))
 
    T = eye(A) - (D_inv)
    r = max(abs(spec(T)))
endfunction

// rho_A1 = r_Jacobi(A1);
rho_A1 = %inf;
rho_A2 = r_Jacobi(A2);

printf('Radio espectral de la matriz A1: %f\n', rho_A1);

if rho_A1 < 1
    disp('La matriz A1 cumple con el criterio de convergencia de Jacobi');
else
    disp('La matriz A1 no cumple con el criterio de convergencia de Jacobi');
end

printf('Radio espectral de la matriz A2: %f\n', rho_A2);

if rho_A2 < 1
    disp('La matriz A2 cumple con el criterio de convergencia de Jacobi');
else
    disp('La matriz A2 no cumple con el criterio de convergencia de Jacobi');
end

// b) Para asegurar la convergencia del método iterativo de Gauss-Seidel, se debe
// cumplir que el radio espectral de la matriz de Gauss-Seidel sea menor que 1.

function r = r_GaussSeidel(A)
    n = size(A, 1)
    D = diag(diag(A))
    L = A - D
 
    for i=1:n
        for j=1:n
            if i > j
                L(i, j) = 0
            end
        end
    end
 
    N = L + D
    T = eye(A) - inv(N)*A
    r = max(abs(spec(T)))
endfunction

rho_A1 = %inf;
rho_A2 = r_GaussSeidel(A2);

printf('Radio espectral de la matriz A1: %f\n', rho_A1);

if rho_A1 < 1
    disp('La matriz A1 cumple con el criterio de convergencia de Gauss-Seidel');
else
    disp('La matriz A1 no cumple con el criterio de convergencia de Gauss-Seidel');
end

printf('Radio espectral de la matriz A2: %f\n', rho_A2);

if rho_A2 < 1
    disp('La matriz A2 cumple con el criterio de convergencia de Gauss-Seidel');
else
    disp('La matriz A2 no cumple con el criterio de convergencia de Gauss-Seidel');
end

// Solo para el segundo sistema se pueden aplicar los métodos iterativos de Jacobi y Gauss-Seidel

function [xk, iter] = jacobi(A, b, x0, tol, maxiter)
    // Description of jacobi(A, b, x0, tol, maxiter)
    //  A: matriz de coeficientes (no singular y sin 0's en la diagonal)
    //  b: vector de términos independientes
    //  x0: vector inicial
    //  tol: tolerancia
    //  maxiter: número máximo de iteraciones

    // OBS: método converge si A es diagonal dominante

    n = size(A, 1);
    xk = x0;

    iter = 0;
    while iter < maxiter

        xk(1) = (1 / A(1, 1)) * (b(1) - A(1, 2:n) * x0(2:n));
        for i = 2:n-1
            // x_i^(k+1) = (1 / a_ii) * (b_i - \sum_{j=1}^{i-1} a_ij x_j^(k) - \sum_{j=i+1}^{n} a_ij x_j^(k))
            // Lo separo en 2 para evitar el elemento de la diagonal
            xk(i) = (1 / A(i, i)) * (b(i) - A(i, 1:i-1) * x0(1:i-1) - A(i, i+1:n) * x0(i+1:n));
        end
        xk(n) = (1 / A(n, n)) * (b(n) - A(n, 1:n-1) * x0(1:n-1));

        iter = iter + 1;
        
        if norm(xk - x0) < tol
            return;
        end
        x0 = xk;

    end
endfunction

function [xk, iter] = gaussSeidel(A, b, x0, tol, maxIter)
    // Description of jacobi(A, b, x0, tol, maxiter)
    //  A: matriz de coeficientes (no singular y sin 0's en la diagonal)
    //  b: vector de términos independientes
    //  x0: vector inicial
    //  tol: tolerancia
    //  maxiter: número máximo de iteraciones

    // OBS: método converge si A es diagonal dominante

    n = size(A, 1);
    xk = x0;

    iter = 0;
    while iter < maxIter

        xk(1) = (1 / A(1, 1)) * (b(1) - A(1, 2:n) * x0(2:n));
        for i = 2:n-1
            // x_i^(k+1) = (1 / a_ii) * (b_i - \sum_{j=1}^{i-1} a_ij x_j^(k+1) - \sum_{j=i+1}^{n} a_ij x_j^(k))
            // Lo separo en 2 para evitar el elemento de la diagonal
            xk(i) = (1 / A(i, i)) * (b(i) - A(i, 1:i-1) * xk(1:i-1) - A(i, i+1:n) * x0(i+1:n));
        end
        xk(n) = (1 / A(n, n)) * (b(n) - A(n, 1:n-1) * xk(1:n-1));

        iter = iter + 1;
        
        if norm(xk - x0) < tol
            return;
        end
        x0 = xk;
    end
endfunction

x0 = [0 ; 0 ; 0];
tol = 1e-2;
lim = 500;

[xk1, iter] = jacobi(A2, b2, x0, tol, lim);

printf("Se aproximó a la solución en %d iteraciones con el metodo de Jacobi\n", iter);
disp(xk1);

[xk2, iter] = gaussSeidel(A2, b2, x0, tol, lim);

printf("Se aproximó a la solución en %d iteraciones con el metodo de Gauss-Seidel\n", iter);
disp(xk2);


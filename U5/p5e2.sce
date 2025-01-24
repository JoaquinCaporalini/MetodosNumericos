A = [10 1 2 3 4 ; 1 9 -1 2 -3 ; 2 -1 7 3 -5 ; 3 2 3 12 -1 ; 4 -3 -5 -1 15]
b = [ 12 ; -27 ; 14 ; -17 ; 12]
x0 = [ 0 ; 0 ; 0 ; 0 ; 0 ];
tol = 1e-6;
maxiter = 10000;


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

[sol_j, iter_j] = jacobi(A, b, x0, tol, maxiter)
[sol_gs, iter_gs] = gaussSeidel(A, b, x0, tol, maxiter)

printf("Solución por Jacobi en %d iteraciones:\n", iter_j); disp(sol_j);
printf("Solución por Gauss-Seidel en %d iteraciones:\n", iter_gs); disp(sol_gs);
A = [10 -1 2 0 ; -1 11 -1 3 ; 2 -1 10 -4 ; 0 3 -1 8]
b = [6 ; 25 ; -11 ; 15]

// Basta notar que la matriz A es diagonal dominante pues 
//      |a_ii| > \sum_{j=0;j != i}^{n} |a_ij| \forall i \in 1 .. n
// Por teorema al ser diagonal dominate ambos métodos convergen \forall x0

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

x0 = [0;0;0;0]
[gs1, i1] = gaussSeidel(A, b, x0, 1e-5, 1000)
[j2, i2] = jacobi(A, b, x0, 1e-5, 1000)

printf("Solución Gauss-Seidel en %d iteraciones", i1)
disp(gs1)

printf("Solución Jacobi en %d iteraciones", i2)
disp(j2)
function [xk, iter] = sor(A, b, x0, w, tol, maxIter)
    // Description of sor(A, b, w, x0, tol, maxiter)
    //  A: matriz de coeficientes (no singular y sin 0's en la diagonal)
    //  b: vector de términos independientes
    //  x0: vector inicial
    //  w: factor de relajación
    //  tol: tolerancia
    //  maxiter: número máximo de iteraciones

    // OBS: método converge si A es diagonal dominante

    n = size(A, 1);
    xk = x0;

    iter = 0;
    while iter < maxIter

        xk(1) = (1 - w) * xk(1) +  (w / A(1, 1)) * (b(1) - A(1, 2:n) * x0(2:n));
       
        for i = 2:n-1
            // x_i^(k+1) = (1 / a_ii) * (b_i - \sum_{j=1}^{i-1} a_ij x_j^(k+1) - \sum_{j=i+1}^{n} a_ij x_j^(k))
            // Lo separo en 2 para evitar el elemento de la diagonal
            xk(i) = (1 - w) * xk(i) + (w / A(i, i)) * (b(i) - A(i, 1:i-1) * xk(1:i-1) - A(i, i+1:n) * x0(i+1:n));
        end
        
        xk(n) = (1 - w) * xk(n) + (w / A(n, n)) * (b(n) - A(n, 1:n-1) * xk(1:n-1));

        iter = iter + 1;
        
        if norm(xk - x0) < tol
            return;
        end
        x0 = xk;
    end
endfunction


// Ejemplo
A = [ 9 1 1 ; 2 10 3 ; 3 4 11 ];
b = [ 10 ; 19 ; 0 ];

x0 = [ 0 ; 0 ; 0 ];
tol = 1e-6;
maxiter = 100;

esp = [ 1 ; 2 ; -1 ];

[xk, iter] = gaussSeidel(A, b, x0, tol, maxiter);

printf('Matriz: A = \n'); disp(A);
printf('Vector: b = \n'); disp(b);
printf('aprox en %d iteraciones:\n', iter); disp(xk);
printf('sol:\n'); disp(esp);

A = [ 4 3 0 ; 3 4 -1 ; 0 -1 4];
b = [ 24 ; 30 ; -24 ];


function r = matrizDefinidaPositiva(A)
    // Description of matrizDefinidaPositiva(A)
    //  A: matriz cuadrada
    //  r: 1 si es definida positiva, 0 en otro caso
    r = %F;
    
    autovalor = spec(A);
    
    ma = max(autovalor);
    mi = min(autovalor);
    
    if 0 < mi
        r = %T;
        printf('La matriz es definida positiva\n');
    else 
        if 0 <= mi
            printf('La matriz es semidefinida positiva\n');
        
        else 
            if ma < 0
                printf('La matriz es definida negativa\n');
            else 
                if ma <= 0
                    printf('La matriz es semidefinida negativa\n');
                else
                    printf('La matriz no es definida positiva ni definida negativa\n');
                end
            end
        end
    end

endfunction

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

function w = omegaOpt(A)
    // Description of omegaOpt(A)
    // Esta función calcula el valor de omega que minimiza el número de iteraciones

    // A debe ser una matriz positiva (autovalores positivos) y tridiagonal

    I = eye(A);

    // Inversa de la matriz diagonal de A
    invD = diag(1 ./ diag(A));

    // Matriz de Jacobi
    Tj = I - invD * A;

    autovalores = spec(Tj);

    // Radio espectral de la matriz de Jacobi 
    //(máximo en valor absoluto de los autovalores)
    rho = max(abs(autovalores));

    w = 2 / (1 + sqrt(1 - rho^2));
endfunction

matrizDefinidaPositiva(A);

tol = 1e-7;
x0 = [0; 0; 0]; 
lim = 100;

w = omegaOpt(A)

sol = [ 3 ; 4 ; -5 ];

printf('Solución exacta:\n'); disp(sol);

[xk, iter] = sor(A, b, x0, w, 1e-2, lim);
printf('SOR (b)\n');
printf('aprox en %d iteraciones:\n', iter); disp(xk);

[xk, iter] = gaussSeidel(A, b, x0, tol, lim);
printf('Gauss-Seidel (a)\n');
printf('aprox en %d iteraciones:\n', iter); disp(xk);
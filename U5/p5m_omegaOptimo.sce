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

// Ejemplo
A = [0.5 0.1  0.2 ; 0.1 0.4 0.2 ; 0.2 0.2 0.3 ]
w = omegaOpt(A);

printf('Matriz: A = \n'); disp(A);
printf('Omega optimo = \n'); disp(w);


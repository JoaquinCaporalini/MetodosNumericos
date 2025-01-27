function [lam, zk, iter] = potencia(A, z0, tol, maxIter)
    // Description of potencia(A, z0, tol, maxIter)
    //  A: matriz de coeficientes (no singular y sin 0's en la diagonal)
    //  z0: vector inicial
    //  tol: tolerancia
    //  maxiter: número máximo de iteraciones

    // lam: Autovalor dominante
    // zk: Autovector asociado al autovalor dominante
    // iter: número de iteraciones

    iter = 0;
    zk = z0;
    while iter < maxIter
        iter = iter + 1;

        w = A * z0;
        zk = w / norm(w, %inf); // Uso la norma infinito

        [_, j] = max(abs(w)); // Posición de la mayor componente
                              // en valor absoluto de w
        lam = w(j) / z0(j);

        if norm(zk - z0, %inf) < tol
            return;
        end
        z0 = zk;
    end

endfunction

// Ejemplo
A = [0.5 0.1  0.2 ; 0.1 0.4 0.2 ; 0.2 0.2 0.3 ];
z0 = [1; 1; 1];
tol = 0;
maxIter = 100;

[lam, zk, iter] = potencia(A, z0, tol, maxIter);
printf('Matriz: A = \n'); disp(A);
printf('Autovalor dominante = \n'); disp(lam);
printf('Autovector asociado = \n'); disp(zk);
printf('Iteraciones = \n'); disp(iter);

// Resultado esperado

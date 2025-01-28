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

function valor = maxAutovalor(A)
    valores = eigs(A)
    [m, i] = max(abs(valores))
    valor = valores(i)
endfunction


printf("\n\n---------Ej 5---------\n");
A = [6 4 4 1;
     4 6 1 4;
     4 1 6 4;
     1 4 4 6]
printf("A = \n")
disp(A)
[valor, z, iters] = potencia(A, [1 1 0 0]', 10^(-8), %inf)
printf("Autovalor dominante = %f\n", valor)
printf("Autovector asociado = \n")
disp(z)
printf("Calculado en %d iteraciones\n", iters)
valor = maxAutovalor(A)
printf("Autovalor dominante según scilab = %f\n", valor)
printf("\n\n")

A = [12 1  3  4; 
     1 -3  1  5; 
     3  1  6 -2; 
     4  5 -2 -1]
printf("A = \n")
disp(A)
[valor, z, iters] = potencia(A, [1 1 0 0]', 10^(-8), %inf)
printf("Autovalor dominante = %f\n", valor)
printf("Autovector asociado = \n")
disp(z)
printf("Calculado en %d iteraciones\n", iters)
valor = maxAutovalor(A)
printf("Autovalor dominante según scilab = %f\n", valor)
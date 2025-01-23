function kappa = nroCondMatriz(A)
    // Description of nreoCondMatriz(A)
    //  A: matriz no singular
    kappa = norm(A) * norm(inv(A));
endfunction

// El espectro de un matriz A lo obtenemos como spec(A)
// Los autovectores los obtenemos como [V, _] = spec(A)

function rho = radioEspectral(A)
    // Description of radioEspectral(A)

    espectro = spec(A);

    // Radio espectral de la matriz de Jacobi 
    //(máximo en valor absoluto de los espectro)
    rho = max(abs(espectro));
endfunction
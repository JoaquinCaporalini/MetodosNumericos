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
    else if 0 <= mi
        printf('La matriz es semidefinida positiva\n');
    else if ma < 0
        printf('La matriz es definida negativa\n');
    else if ma <= 0
        printf('La matriz es semidefinida negativa\n');
    else
        printf('La matriz no es definida positiva ni definida negativa\n');
    end

endfunction
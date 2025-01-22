function [P, L, U] = gausselimPLU(A)
    // Description of gausselimPLU(A)

    [nA,mA] = size(A) 

    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    end;

    U = A;

    // Defino a L como la identidad con la misma dimensión que A
    L = eye(A);

    // Defino a P como la identidad con la misma dimensión que A
    P = eye(A);

    // Eliminación progresiva (con pivoteo parcial)

    for k = 1:nA-1

        // Busco el máximo de la columna k a partir de la fila k
        // Los anteriores ya fueron eliminados
        kpivot = k; amax = abs(U(k,k));  //pivoteo

        for i=k+1:nA
            if abs(U(i,k))>amax then
                kpivot = i; amax = U(i,k);
            end;
        end;

        // Intercambio de filas para el pivoteo

        // Intercambio de filas en U
        temp = U(kpivot,k:nA); U(kpivot,k:nA) = U(k,k:nA); U(k,k:nA) = temp;
        // Intercambio de filas en L
        temp = L(kpivot,1:k-1); L(kpivot,1:k-1) = L(k,1:k-1); L(k,1:k-1) = temp;
        // Intercambio de filas en P
        temp = P(kpivot,:); P(kpivot,:) = P(k,:);P(k,:) = temp;

        // Eliminación de la columna k para todas las filas i>k
        L(k+1:nA,k) = U(k+1:nA,k)/U(k,k)
        U(k+1:nA,k:nA) = U(k+1:nA,k:nA) - L(k+1:nA,k)*U(k, k:nA)
    end

endfunction


A = [1.012 -2.123 3.104 ; -2.132 4.096 -7.013 ; 3.104 -7.013 0.014];
[PA, LA, UA] = gausselimPLU(A)
printf('A = \n'); disp(A); printf('L = \n'); disp(LA); printf('U = \n'); disp(UA); printf('LU\n'); disp(LA*UA);

[LA, UA, PA] = lu(A)
printf('A scilab = \n'); disp(A); printf('L = \n'); disp(LA); printf('U = \n'); disp(UA); printf('LU\n'); disp(LA*UA);


B = [2.1756 4.0231 -2.1732 5.1967 ; -4.0231 6.0000 0 1.1973 ; -1.0000 5.2107 1.1111 0 ; 6.0235 7.000 0 4.1561]
[PB, LB, UB] = gausselimPLU(B)
printf('B = \n'); disp(B); printf('L = \n'); disp(LB); printf('U = \n'); disp(UB); printf('LU\n'); disp(LB*UB);
[LB, UB, PB] = lu(B)
printf('B = scilab\n'); disp(B); printf('L = \n'); disp(LB); printf('U = \n'); disp(UB); printf('LU\n'); disp(LB*UB);

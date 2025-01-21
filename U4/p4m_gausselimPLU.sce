clc // limpia la consola
clear // borra el contenido de la memoria

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

// Ejemplos de aplicación
A = [3 -2 -1; 6 -2 2; -9 7 1]
[P, L, U] = gausselimPLU(A)
disp('A = '); disp(P); disp(L); disp(U)

B = [5 7 9 ; 5 8 25 ; 5 10 10]
[P, L, U] = gausselimPLU(B)
disp('B = '); disp(P); disp(L); disp(U)
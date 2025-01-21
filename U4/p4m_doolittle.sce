clc // limpia la consola
clear // borra el contenido de la memoria

function [L, U] = doolittle(A)
    // Description of doolittle(A)
    //  A: matriz cuadrada
    //  L: matriz triangular inferior
    //  U: matriz triangular superior

    [m, n] = size(A);
    if m <> n then
        disp('La matriz no es cuadrada');
        return;
    end

    L = eye(A);
    U = zeros(m, n);

    U(1, :) = A(1, :); // 1 = i <= j \forall j \in [1, n]
                       // Puedo completar la primera fila de U

    for i = 2:m        // i > 2 > j = 1 \forall i \in [2, n]
                       // Puedo completar la primera columna de L
        L(i, 1) = A(i, 1) / U(1, 1); // 1 = j < i
    end

    for i = 2:m
        for j = 2:n
            if i <= j then
                U(i, j) = A(i, j) - L(i, 1:i-1) * U(1:i-1, j);
            else
                L(i, j) = (A(i, j) - L(i, 1:j-1) * U(1:j-1, j)) / U(j, j);
            end
        end
    end
endfunction

// Ejemplo de uso

A = [2 1 1; 4 3 3; 8 7 9];
[L, U] = doolittle(A);
disp('Matriz A:');
disp(A);
disp('Matriz L:');
disp(L);
disp('Matriz U:');
disp(U);

disp("Verificación")
disp(L * U)
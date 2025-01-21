clc // limpia la consola
clear // borra el contenido de la memoria

function [L,U] = crout(A)
    n = size(A, 1)
    L = eye(n,n)
    U = eye(n,n)
    L(:, 1) = A(:, 1)

    for j=2:n
        U(1, j) = A(1,j)/L(1,1)
    end

    for i=2:n
        for j=2:n
            if i >= j
                L(i, j) = (A(i, j) - L(i, 1:j-1)*U(1:j-1, j))
            else
                U(i, j) = (A(i, j) - (L(i, 1:i-1)*U(1:i-1, j)))/L(i, i)
            end
        end
    end
endfunction

// Ejemplo de uso

A = [2 1 1; 4 3 3; 8 7 9];
[L, U] = crout(A);
disp('Matriz A:');
disp(A);
disp('Matriz L:');
disp(L);
disp('Matriz U:');
disp(U);

disp("Verificación")
disp(L * U)
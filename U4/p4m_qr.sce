// clc // limpia la consola
clear // borra el contenido de la memoria

function [Q, R] = qr(A)
    // Description of qr(A)
    //  A: matriz con columnas linealmente independientes
    //  Q: matriz ortogonal
    //  R: matriz triangular superior

    [m, n] = size(A);

    if n > m then
        disp('La matriz A debe tener más filas que columnas');
        Q = %nan;
        R = %nan;
        return;
    end

    Q = zeros(m, n);
    R = zeros(m, m);

    a_1 = norm(A(:, 1));

    Q(:,1) = A(:, 1) ./ a_1;
    R(1,1) = a_1

    for k = 2:m
        // Sumatoria de los productos internos
        a_k = zeros(m, 1);
        for i = 1:k-1
            a_k = a_k + (A(:, k)' * Q(:, i)) * Q(:, i);
        end
        a_k = A(:, k) - a_k;
        
        //Norma de la columna k
        a_kn = norm(a_k); 

        R(k, k) = a_kn;
        Q(:,k) = a_k ./ a_kn;
    end

    for i = 1:m-1      // Fila
        for j = i+1:n  // Columna
                       // La diagonal ya está calculada
            R(i, j) = A(:,j)' * Q(:, i);
        end
    end
endfunction


// Ejemplo de uso

A = [12 -51 4 ; 6 167 -68 ; -4 24 -41];

[Q, R] = qr(A);

disp('Matriz A');
disp(A);
disp('Matriz Q');
disp(Q);
disp('Matriz R');
disp(R);

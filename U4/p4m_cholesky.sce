clc
clear

/* Versión 1 */

function [U, ind] = Cholesky_old(A)
    eps = 1.0e-8
    n = size(A,1)
    U = zeros(n,n)
    for k = 1:n
        if k==1 then
                t = A(k,k)
        else 
                t = A(k,k) - U(1:k-1,k)'*U(1:k-1,k)
        end
    
        if t <= eps
            printf("Matriz no definida positiva.\n")
            ind = 0
            return
        end
        U(k,k)= sqrt(t)
        for j = k+1:n
            if k==1 then 
                        U(k,j) = A(k,j)/U(k,k)
            else 
                        U(k,j) = ( A(k,j) - U(1:k-1,k)' * U(1:k-1,j) )/U(k,k)
            end
        end
    end
    ind = 1
endfunction
    
A = [4 1 1; 1 2 2; 1 2 3]
disp("A")
[U,ind] = Cholesky_old(A)
disp(U)
disp(ind)


/* Versión 2 */

function [U,ind] = cholesky(A)
    // Factorización de Cholesky.
    // Trabaja únicamente con la parte triangular superior.
    //
    // ind = 1  si se obtuvo la factorización de Cholesky.
    //     = 0  si A no es definida positiva
    //
    //******************
    eps = 1.0e-8
    //******************

    n = size(A,1)
    U = zeros(n,n)

    t = A(1,1)
    if t <= eps then
        printf('Matriz no definida positiva.\n')
        ind = 0
        return
    end
    U(1,1) = sqrt(t)
    for j = 2:n
        U(1,j) = A(1,j)/U(1,1)
    end
        
    for k = 2:n
        t = A(k,k) - U(1:k-1,k)'*U(1:k-1,k)
        if t <= eps then
            printf('Matriz no definida positiva.\n')
            ind = 0
            return
        end
        U(k,k) = sqrt(t)
        for j = k+1:n
            U(k,j) = ( A(k,j) - U(1:k-1,k)'*U(1:k-1,j) )/U(k,k)
        end
    end
    ind = 1

endfunction

A = [4 1 1; 8 2 2; 1 2 3]

[U,ind] = cholesky(A)
disp(U)
disp(ind)

disp("B")
B = [5 2 1 0; 2 5 2 0; 1 2 5 2; 0 0 2 5]
disp(B)
[U,ind] = cholesky(B)
disp(U)
disp(ind)

disp("C")
C = [5 2 1 0; 2 -4 2 0; 1 2 2 2; 0 0 2 5]
disp(C)
[U,ind] = cholesky(C)


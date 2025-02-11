// Funciones para obtener el radio espectral de las matrices de los métodos
// de Jacobi, Gauss-Seidel y SOR para verificar su convergencia (Teorema 1)
function r = r_Jacobi(A)
    D_inv = diag(diag(1 ./ A))
 
    T = eye(A) - (D_inv) * A
    r = max(abs(spec(T)))
endfunction
 

function r = r_GaussSeidel(A)
    n = size(A, 1)
    D = diag(diag(A))
    L = A - D
 
    for i=1:n
        for j=1:n
            if i > j
                L(i, j) = 0
            end
        end
    end
 
    N = L + D
    T = eye(A) - inv(N)*A
    r = max(abs(spec(T)))
endfunction
 
 // El radio depende del omega utilizado
 // Converge sii rho(Tw) < 1
 function r = r_SOR(A, w)
    n = size(A, 1)
    D = diag(diag(A))
    L = A - D
    U = A - D
 
    for i=1:n
        for j=1:n
            if i > j
                L(i, j) = 0
            end
            if i < j
                U(i, j) = 0
            end
        end
    end
 
    Tw = inv((D + w*L)) * (((1-w) * D) - (w*U))
    r = max(abs(spec(Tw)))
endfunction

function ret = diagonalmenteDominante(A)
    // Description of diagonalmenteDominante(A)
    //  A: matriz de coeficientes
    //  ret: true si A es diagonal dominante, false en otro caso
    n = size(A, 1)
    for i=1:n
        sum = 0
        for j=1:n
            if i != j
                sum = sum + abs(A(i, j))
            end
        end
        if abs(A(i, i)) < sum
            ret = %F
            return
        end
    end
    ret = %T
endfunction


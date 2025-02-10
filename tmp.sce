[nA, mA] = size(A)

    v(1) = norm(A(:,1))
    Q(:,1) = A(:, 1)/v(1)
    n = nA

    for k=2:n
        for j=1:k-1
            aux2(:,j) = A(:,k)'*Q(:,j)*Q(:,j)
        end
        aux = A(:,k) - sum(aux2, 2)
        v(k) = norm(aux)
        Q(:,k) =  aux / v(k)
    end

    for i=1:n
        R(i,i) = v(i)
        for j=i+1:n
            R(i,j) = A(:, j)' * Q(:, i)
        end
    end
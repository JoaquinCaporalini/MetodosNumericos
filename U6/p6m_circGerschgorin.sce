function [centros, radios] = circGershgoring(A)
    // Sea A \in C^nxn y \lam un auto valor de A.
    // Entonces, \lam pertenece a al menos un círculo de Gershgoring
    // con centro en a_{ii} y radio r_i = \sum_{j=1, j<>i}^{n} |a_{ij}|

    n = size(A, 1);

    centros = zeros(n, 1);
    radios = zeros(n, 1);

    for i = 1:n
        centros(i) = A(i, i);
        radios(i)  = sum(abs(A(i, :))) - abs(A(i, i));
    end
endfunction

// Ejemplo
A = [ 4 1 0 ; 1 0 -1 ; 0 -1 -4 ];
[centros, radios] = circGershgoring(A);
printf("C1 : |z - %f| <= %f\n", centros(1), radios(1));
printf("C2 : |z - %f| <= %f\n", centros(2), radios(2));
printf("C3 : |z - %f| <= %f\n", centros(3), radios(3));
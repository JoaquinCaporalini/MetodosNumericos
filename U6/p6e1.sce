A = [ 1 0 0 ; -1 0 1 ; -1 -1 2 ]
B = [ 1 0 0 ; -0.1 0 0.1 ; -0.1 -0.1 2 ]
C = [ 1 0 0 ; -0.25 0 0.25 ; -0.25 -0.25 2 ]
D = [ 4 -1 0 ; -1 4 -1 ; -1 -1 4 ]
E = [ 3 2 1 ; 2 3 0 ;1 0 3 ]
F = [ 4.75 2.25 -0.25 ; 2.25 4.75 1.25 ; -0.25 1.25 4.75 ]

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

/* Apartado B */
function autovalores = sov(M, name)

    autovalores = spec(M)
    [centros, radios] = circGershgoring(M)
    printf('Matriz: %s = \n', name); disp(M);
    printf('Circulos de Gershgoring = \n');
    for i=1:size(M, 1)
        printf("C%d : |z - %f| <= %f\n", i, centros(i), radios(i));
    end

    [v, p] = max(centros);

    printf("Cota: +/- %f\n", v + radios(p));
    printf('Autovalores = \n'); disp(autovalores);

endfunction

sov(A, 'A')
sov(B, 'B')
sov(C, 'C')
sov(D, 'D')
sov(E, 'E')
sov(F, 'F')

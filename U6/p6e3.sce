function A = generarA(eps)
    // Description of generarA(eps)
    A = [ 1 -1 0 ; -2 4 -2 ; 0 -1 (1+eps) ];
endfunction

for k = 0:10
    eps = 0.1 * k;
    printf("eps = %f\n", eps);
    A = generarA(eps);
    printf("A = \n");
    disp(A);
    printf("Polinomio característico = \n");
    pol = poly(A, "x");
    disp(pol);
    printf("Raices del pol = \n");
    r = roots(pol);
    disp(r);
    printf("Autovalores = \n");
    disp(spec(A));
    printf("\n\n");
end
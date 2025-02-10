//clc // limpia la consola
clear // borra el contenido de la memoria

function [b0, d] = horner(p, x0)
    // Método de Horner para evaluar un polinomio en un punto
    // p: Polinomio
    // x0: Punto donde se evalúa el polinomio
    // b0: Valor del polinomio en x0

    n  = degree(p);
    b0 = coeff(p,n);
    d = b0;

    for i = n-1:-1:0
        b0 = b0 * x0 + coeff(p,i);

        if i > 0 then
            d = d * x0 + coeff(p,i);
        end
    end
endfunction

if %T then
    printf("\n\n---------Ej 3---------\n");
    pol = poly([2 6 3 7 4],"x","coeff");
    printf("Polinomio de prueba:\n");
    disp(pol);
    x = 42;
    [b, d] = horner(pol, x);
    printf("Resultado de evaluar en x = %f,  p(x) = %f\n", x, b);
    printf("Derivada segun horner = %f\n", d);
    printf("Polinomio derivada de p:\n");
    pol = poly([6 6 21 16],"x","coeff");
    disp(pol);
    
    [b, d] = horner(pol, x);
    printf("Resultado de evaluar polinomio derivada = %f", b);
end
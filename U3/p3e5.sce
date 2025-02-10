// clc // limpia la consola
clear // borra el contenido de la memoria

function [y, i] = ptoFijo(f, x0, tol, nmax)
    // Description of ptoFijo(f, x0, tol, nmax)
    //  f: función
    //  x0: valor inicial
    //  tol: tolerancia
    //  nmax: número máximo de iteraciones

    i = 0;

    while i < nmax then
        y = f(x0);
        if abs(y - x0) < tol then
            return;
        end
        x0 = y;
        i = i + 1;
    end

    if i >= nmax then
        disp('No se encontró el punto fijo en el número máximo de iteraciones');
        y = %nan;
    end
endfunction

C = 1/4;

function y = g(x)
    y = x + C .* (x.^2 - 5);
endfunction

printf("\n\n---------Ej 5---------\n");
[y, i] = ptoFijo(g, 2, 10^(-6), 100);
printf("funcion g(x) = x + 1/4 (x^2+5)[C = 1/4]\nValor esperado: %f\nValor obtenido %f\ncant iteraciones: %d", -sqrt(5), y, i);

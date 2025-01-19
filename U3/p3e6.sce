clc // limpia la consola
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

function y = g1(x)
    y = %e.^(x) / 3
endfunction

function y = g2(x)
    y = (%e.^(x) - x) / 2
endfunction

function y = g3(x)
    y = log(3.*x)
endfunction

function y = g4(x)
    y = %e.^(x) - 2.*x
endfunction

printf("\n\n---------Ej 5---------\n");

printf("eq: e^x = 3x\n    sol 1: 1.51\n    sol 2: 0.61\n")

[y, i] = ptoFijo(g1, 1/2, 10^(-6), 100);
printf("funcion g1(x)\nValor obtenido %f\ncant iteraciones: %d\n\n", y, i);

[y, i] = ptoFijo(g2, 1/2, 10^(-6), 100);
printf("funcion g2(x)\nValor obtenido %f\ncant iteraciones: %d\n\n", y, i);

[y, i] = ptoFijo(g3, 1/2, 10^(-6), 100);
printf("funcion g3(x)\nValor obtenido %f\ncant iteraciones: %d\n\n", y, i);

[y, i] = ptoFijo(g4, 1/2, 10^(-6), 100);
printf("funcion g4(x)\nValor obtenido %f\ncant iteraciones: %d\n\n", y, i);

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
clc // limpia la consola
clear // borra el contenido de la memoria

function [c, i] = secante(f, a, b, tol, max_iter)
    // Description of secante(f, a, b, tol, max_iter)
    //  f: función
    //  a: límite inferior del intervalo
    //  b: límite superior del intervalo
    //  tol: tolerancia
    //  max_iter: número máximo de iteraciones

    i = 0;

    fa = f(a);
    fb = f(b);

    if fa == 0 then
        c = a;
        return;
    end

    if fb == 0 then
        c = b;
        return;
    end

    while abs(fb - fa) > tol && i < max_iter then
        c = b - fb * (b - a) / (fb - fa);
        a = b;
        fa = fb;
        b = c;
        fb = f(c);
        i = i + 1;
    end
    if i >= max_iter then
        disp('No se encontró la raíz en el número máximo de iteraciones');
        c = %nan;
    end

endfunction
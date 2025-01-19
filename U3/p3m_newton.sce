clc // limpia la consola
clear // borra el contenido de la memoria

function [x1, i] = newton(f, x0, tot, max_iter, h)
    // Description of newton(f, x0, tot, max_iter, h)
    //  f: función
    //  x0: valor inicial
    //  tot: tolerancia
    //  max_iter: número máximo de iteraciones
    //  h: paso para calcular la derivada

    i = 0;

    while i < max_iter then
        fx0 = f(x0);
        dfx0 = (f(x0 + h) - fx0) / h;

        x1 = x0 - fx0 / dfx0;

        if abs(x1 - x0) < tot then
            return;
        end

        x0 = x1;
        i = i + 1;
    end

    if i >= max_iter then
        disp('No se encontró la raíz en el número máximo de iteraciones');
        x1 = %nan;
    end
endfunction
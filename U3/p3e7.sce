clc // limpia la consola
clear // borra el contenido de la memoria

function [x1, i] = newtonMultiVar(f, x0, tol, max_iter)
    // Description of newtonMultiVar(f, x0, tol, max_iter)
    //  f: función
    //  x0: vector de valores iniciales
    //  tol: tolerancia
    //  max_iter: número máximo de iteraciones

    i = 0;

    x0 = x0'; // Traspongo el vector de valores iniciales

    while i < max_iter then
        J = numderivative(f, x0);
        fx0 = f(x0);
        x1 = x0 - inv(J) * fx0;
        if norm(x1 - x0) < tol then
            return;
        end
        x0 = x1;
        i = i + 1;
    end

    if i >= max_iter then
        disp('No se encontró la raíz en el número máximo de iteraciones');
        // x1 = %nan;
    end
endfunction

// Ej 7
printf("\n\n---------Ej 7---------\n");
function y = f(x)
    y1 = 1 + x(1)^2 - x(2)^2 + exp(x(1)) * cos(x(2))
    y2 = 2 * x(1) * x(2) + exp(x(1)) * sin(x(2))
    y = [y1 ; y2]
endfunction

[y, i] = newtonMultiVar(f, [-1 4], 10^(-12), 5)

printf("y = [%f %f], i = %d", y(1), y(2), i)
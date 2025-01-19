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
        J = jacobian(f, x0);
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
        x1 = %nan;
    end
endfunction
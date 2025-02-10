// clc // limpia la consola
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
printf("\n---------Ej 8---------\n");
function y = f(x)
    y1 = x(1).^2 + x(1) .* (x(2).^3) - 9
    y2 = 3 .* (x(1) .^2) * x(2) - 4 - x(2).^3
    y = [y1 ; y2]
endfunction

lim = 20

a = [1.2 2.5];
b = [-2 2.5];
c = [-1.2 -2.5]
d = [2 -2.5]

printf("\n---------a---------\n");
[y, i] = newtonMultiVar(f, a, 10^(-12), lim)
printf("x0 = [%f %f]\ny = [%f %f]\ni = %d\n", a(1), a(2), y(1), y(2), i)

printf("\n---------b---------\n");
[y, i] = newtonMultiVar(f, b, 10^(-12), lim)
printf("x0 = [%f %f]\ny = [%f %f]\ni = %d\n", b(1), b(2), y(1), y(2), i)

printf("\n---------c---------\n");
[y, i] = newtonMultiVar(f, c, 10^(-12), lim)
printf("x0 = [%f %f]\ny = [%f %f]\ni = %d\n", c(1), c(2), y(1), y(2), i)

printf("\n---------d---------\n");
[y, i] = newtonMultiVar(f, d, 10^(-12), lim)
printf("x0 = [%f %f]\ny = [%f %f]\ni = %d\n", d(1), d(2), y(1), y(2), i)
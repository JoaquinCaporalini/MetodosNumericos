clc // limpia la consola
clear // borra el contenido de la memoria

// function [x1, i] = newton(f, x0, tot, max_iter, h)
//     // Description of newton(f, x0, tot, max_iter, h)
//     //  f: función
//     //  x0: valor inicial
//     //  tot: tolerancia
//     //  max_iter: número máximo de iteraciones
//     //  h: paso para calcular la derivada

//     i = 0;

//     while i < max_iter then
//         fx0 = f(x0);
//         dfx0 = (f(x0 + h) - fx0) / h;

//         x1 = x0 - fx0 / dfx0;

//         if abs(x1 - x0) < tot then
//             return;
//         end

//         x0 = x1;
//         i = i + 1;
//     end

//     if i >= max_iter then
//         disp('No se encontró la raíz en el número máximo de iteraciones');
//         x1 = %nan;
//     end
// endfunction

function [x1, i] = newton(f, x0, tol, iter, h)
    i = 0;
    delta = %inf;

    while delta > tol && i < iter
        fx0 = f(x0);
        dfx0 = f(x0+h) - fx0;
        x1 = x0 - fx0 * h / dfx0;

        delta = abs(x1 - x0);
        x0 = x1;
        i = i + 1;
    end

    if (delta > tol) then x1 = %nan; disp('Se alcanzó el máximo de iteraciones')
    end
endfunction

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

// Ej 10
printf("\n\n---------Ej 10---------\n");
printf("Punto fijo empezando desde x0 = 28\n")
// Acá busco una f(x) tal que f(x) = x
// f = "9.8 * 25 / (2 * %pi) * tanh(8 * %pi / x)"

function y = f(x)
    y = 9.8 * 25 / (2 * %pi) * tanh(8 * %pi / x)
endfunction

[y, i] = ptoFijo(f, 28, 10^(-1), 10);
printf("y = %f, i = %d\n", y, i)

printf("Con el método de newton, con x0 = %f obtenido del cálculo anterior\n", y)
// // Busco g(x) tal que g(x) = 0, entonces g(x) = f(x) - x
function y = g(x)
    y = f(x) - x
endfunction

[y, i] = newton(g, y, 10^(-6), 10, 10^(-6))
// printf("y = %f, i = %d\n", y, i)
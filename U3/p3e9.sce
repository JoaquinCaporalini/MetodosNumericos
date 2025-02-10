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

// Ej 9
printf("\n---------Ej 9---------\n");

function y = f_aux(k1, k2, k3, r)
    y = k1 .* (%e .^ (k2 .* r)) + k3 .* r;
endfunction

function y = f_xyz(x)
    y1 = -10 + f_aux(x(1), x(2), x(3), 1)
    y2 = -12 + f_aux(x(1), x(2), x(3), 2)
    y3 = -15 + f_aux(x(1), x(2), x(3), 3)
    y = [y1 ; y2; y3]
endfunction

lim = 100

x0 = [9 0.1 0.8];

[r, i] = newtonMultiVar(f_xyz, x0, 10^(-8), lim)
printf("[k1 k2 k3] = [%f %f %f]\nb) [k1 k2 k3] = [%f %f %f]\ni = %d\n", x0(1), x0(2), x0(3), r(1), r(2), r(3), i)


function output = carga(radio)
    // Description of carga(r)
    output = (500 ./ (%pi .* radio.^2)) - f_aux(r(1), r(2), r(3), radio)
endfunction

ran = -5:0.01:5

gcf().children.grid = color("grey70")*[1 1]; // grids
plot(ran, carga(ran));
// plot(ran, 0);

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

[radio, i] = secante(carga, 3, 3.5, 10^(-6), 1000)


printf("b) radio = %f\ni = %d\n", radio, i)
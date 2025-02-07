function [x1, i] = newtonModificado(f, x0, tot, max_iter, h, m)
    // Description of newton(f, x0, tot, max_iter, h, m)
    //  f: función
    //  x0: valor inicial
    //  tot: tolerancia
    //  max_iter: número máximo de iteraciones
    //  h: paso para calcular la derivada
    //  m: Multiplicidad de una raíz

    i = 0;

    while i < max_iter then
        fx0 = f(x0);
        dfx0 = (f(x0 + h) - fx0) / h;

        x1 = x0 - m * fx0 / dfx0;

        if abs(x1 - x0) < tot then
            return;
        end

        x0 = x1;
        i = i + 1;
    end

    if i >= max_iter then
        disp('No se encontró la raíz en el número máximo de iteraciones');
    end
endfunction

fs = poly([2.25 -0.75 -2 1], "x", "coeff");
f  = deff("y=f(x)","y=horner(fs,x)");

[x1, i1] = newtonModificado(f, 1.51, 1e-10, 1000, 1e-6, 1);
[x2, i2] = newtonModificado(f, 1.51, 1e-10, 1000, 1e-6, 2);

printf("Usando el método normal:\n");
printf("\taprox: %f\n", x1);
printf("\titer:  %f\n", i1);

printf("Usando el método Mejorado:\n");
printf("\taprox: %f\n", x2);
printf("\titer:  %f\n", i2);
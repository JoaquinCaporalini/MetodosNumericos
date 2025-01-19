function [c, i] = regulaFalsi(f, a, b, tol, max_iter)
    // Description of regulaFalsi(f, a, b, tol, max_iter)
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

    c = b - fb * (b - a) / (fb - fa);
    fc = f(c);

    while abs(fc - fa) > tol && i < max_iter then
        if fc * fa < 0 then
            // a = a
            b = c;
            fb = fc;
        else
            // b = b
            a = c;
            fa = fc;
        end
        c = b - fb * (b - a) / (fb - fa);
        fc = f(c);

        i = i + 1;
    end
    if i >= max_iter then
        disp(c);
        disp('No se encontró la raíz en el número máximo de iteraciones');
        c = %nan;
    end

endfunction
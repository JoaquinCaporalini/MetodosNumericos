clc // limpia la consola
clear // borra el contenido de la memoria

function [c, i] = biseccion(f, a, b, tol, max_iter)
    // Description of biseccion(f, a, b, tol, max_iter)
    //  f: función
    //  a: límite inferior del intervalo
    //  b: límite superior del intervalo
    //  tol: tolerancia
    //  max_iter: número máximo de iteraciones
    
    i = 1;
    
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

    c = (a + b) / 2;
    fc = f(c);

    while (b - c) > tol && abs(fc) > tol && i < max_iter then
        if fa * fc < 0 then
            b = c;
            fb = fc;
        end
        
        if fb * fc < 0 then
            a = c;
            fa = fc;
        end
    
        c = (a + b) / 2;
        fc = f(c);
        
        i = i + 1;
    end

    if i >= max_iter then
        disp('No se encontró la raíz en el número máximo de iteraciones');
        c = %nan;
    end
endfunction

function [c, i] = biseccionEps(f, a, b, eps)
    // Description of biseccion(f, a, b, tol, max_iter)
    //  f: función
    //  a: límite inferior del intervalo
    //  b: límite superior del intervalo
    //  tol: tolerancia
    //  max_iter: número máximo de iteraciones
    
    i = 1;

    max_iter = ceil(log2((b-a)/eps))
    
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

    c = (a + b) / 2;
    fc = f(c);

    while  i < max_iter then
        if fa * fc < 0 then
            b = c;
            fb = fc;
        end
        
        if fb * fc < 0 then
            a = c;
            fa = fc;
        end
    
        c = (a + b) / 2;
        fc = f(c);
        
        i = i + 1;
    end
endfunction

function k = calclulo_iterBiseccion(a, b, eps)
    // Cantidad mínimas de iteraciones a realizar para tener el error que buscamos
    k = ceil(log2((b-a)/eps))
endfunction

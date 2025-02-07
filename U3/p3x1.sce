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

// Apartado A

function y = f(x)
    y = x.^5 - 3*x.^4 + 10 .*x - 8;
endfunction

a = 2;
b = 5;
tol = 1e-6;
max_iter = 1000;

[c, i] = regulaFalsi(f, a, b, tol, max_iter);
printf('Aproximación c = %f iteraciones = %i\n', c, i);

// b

function y = f1(x)
    y = cos(x) .* cosh(x) + 1; // cosh(x) = (e^x + e^-x)/2
endfunction

function y = f2(x)
    y = 2 .* sin(x) - x .^2;
endfunction

function y = f3(x)
    y = %e.^(-x) - x .^4;
endfunction

function y = f4(x)
    y = log10(x) - x + 1;
endfunction

function y = f5(x)
    y = x .^2 ./ 4 - sin(x);
endfunction

function c = sol(f_, name, a_, b_, iter_)
    // Description of sol(f, a, b, iter)
    tol_ = 1e-6;
    [c, i] = regulaFalsi(f_, a_, b_, tol_, iter_);
    printf('Item: %s\n\tAproximación c = %f\n\titeraciones = %i\n', name, c, i);
endfunction

sol(f1, "f1", 1.9, 2.1, 1000);
sol(f2, "f2", 0.8, 1.2, 1000);
sol(f3, "f3", 1.7, 1, 1000);
sol(f4, "f4", 0.95, 1.05, 1000);
sol(f4, "f5", 1.8, 2.2, 1000);
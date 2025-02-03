function I = trapecio(f, a, b)
    h = b - a
 
    I = (h/2) * (f(a) + f(b))
endfunction

function I = simpson(f, a, b)
    h = (b - a) / 2
 
    I = (h/3) * (f(a) + 4*f(a + h) + f(b))
endfunction

function y = fa(x)
    y = log(x);
endfunction

function y = fb(x)
    y = x .^(1/3);
endfunction

function y = fc(x)
    y = sin(x).^2;
endfunction

function err = errorSimpson(a, b, n, val)
    // Description of errorSimpson(a, b, val)
    // a: Valor inicio del intervalo
    // b: Valor final del intervalo
    // val: Valor ya sea de f^(4)(c_n) con c_n en [a, b] 
    //      o el valor exacto de la integral
    // OBS: Si se usa c_n como el máximo obtenemos cota
    h = (b - a) / n;
    err = - ((h^4 * (b - a)) / 180) * val;
endfunction


function err = errorTrapecio(a, b, n, val)
    // Description of errorTrapecio(a, b, val)
    // a: Valor inicio del intervalo
    // b: Valor final del intervalo
    // val: Valor ya sea de f^(2)(c_n) con c_n en [a, b] 
    //      o el valor exacto de la integral
    // OBS: Si se usa c_n como el máximo obtenemos cota
    h = (b - a) / n;
    err = - ((h^4 * (b - a)) / 180) * val;
endfunction

at  = trapecio(fa, 1, 2);
as  = simpson(fa, 1, 2);
ase = errorSimpson(1, 2, 2, -6);
ate = errorTrapecio(1, 2, 1, -1);
a   = 0.38629; // Use mi casio, pero podría usar integrate(fun_string, "var", a, b)

bt  = trapecio(fb, 0, 0.1);
bs  = simpson(fb, 0, 0.1);
bse = %inf;
bte = %inf;
b   = 0.03481;

ct  = trapecio(fc, 0, %pi/3);
cs  = simpson(fc, 0, %pi/3);
cte = errorTrapecio(0, %pi/3, 1, -2);
cse = errorSimpson(0, %pi/3, 2, -8);
c   = 0.3070924

function output = show(fun, t, et, s, es, v)
    printf('Para la función %s\n', fun);
    if et == %inf then
        printf('\tTrapecio: %.5f error: NO ES DERIVABLE EN EL CERRADO\n', t);
    else
        printf('\tTrapecio: %.5f error: %.5f\n', t, et);
    end
    if es == %inf then
        printf('\tSimpson:  %.5f error: NO ES DERIVABLE EN EL CERRADO\n', s);
    else
        printf('\tSimpson:  %.5f error: %.5f\n', s, es);
    end

    printf('\tValor:    %f.5\n', v);
    output = 0;
endfunction

show('ln(x)', at, ate, as, ase, a);
show('x^(1/3)', bt, bte, bs, bse, b);
show('sin(x)^2', ct, cte, cs, cse, c);



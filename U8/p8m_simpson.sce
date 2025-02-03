function I = simpson(f, a, b)
    h = (b - a) / 2
 
    I = (h/3) * (f(a) + 4*f(a + h) + f(b))
endfunction

function I = simpson_def(fun, a, b)
    deff("y=f(x)", "y="+fun);
    h = (b - a) / 2 
    I = (h/3) * (f(a) + 4*f(a + h) + f(b))
endfunction


//ejemplo de uso
function y = g(x)
    y = x.^2 + 2;
endfunction

a = 0;
b = 2;

I1 = simpson(g, a, b)

I2 = simpson_def("x^2 + 2", a, b)

printf('Valores aproximados\n\t%f\n\t%f\nValor esperado:%f', I1, I2, 20/3);
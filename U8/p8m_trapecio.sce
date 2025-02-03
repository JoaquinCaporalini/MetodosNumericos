function I = trapecio(f, a, b)
    h = b - a
 
    I = (h/2) * (f(a) + f(b))
endfunction

function I = trapecio_def(fun, a, b)
    deff("y=f(x)", "y="+fun);
    h = b - a
 
    I = (h/2) * (f(a) + f(b))
endfunction


//ejemplo de uso
function y = g(x)
    y = x.^2 + 2;
endfunction

a = 0;
b = 2;

I1 = trapecio(g, a, b)

I2 = trapecio_def("x^2 + 2", a, b)

printf('Valores aproximados\n\t%f\n\t%f\nValor esperado: %f', I1, I2, 8)
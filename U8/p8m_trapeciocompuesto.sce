function I = trapecioComp(f, a, b, n)
    h = (b - a) / n;
    
    I = (f(a) + f(b)) / 2;

    for i = 1:n-1
        I = I + f(a + i*h);
    end

    I = I * h;
endfunction

function I = trapecioComp_def(fun, a, b, n)
    deff("y=f(x)", "y="+fun);
    h = (b - a) / n;
    
    I = (f(a) + f(b)) / 2;

    for i = 1:n-1
        I = I + f(a + i*h);
    end

    I = I * h;
endfunction


//ejemplo de uso
function y = g(x)
    y = x.^2 + 2;
endfunction

a = 0;
b = 2;

I1 = trapecioComp(g, a, b, 1)

I2 = trapecioComp_def("x^2 + 2", a, b, 1)

printf('Valores aproximados con n=1 \n\t%f\n\t%f\nValor esperado: %f\n', I1, I2, 8)

I1 = trapecioComp(g, a, b, 4)

I2 = trapecioComp_def("x^2 + 2", a, b, 4)

printf('Valores aproximados con n=4\n\t%f\n\t%f\nValor esperado: %f\n', I1, I2, 20/3)
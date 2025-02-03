function I = simpsonCompuesto(f, a, b, n)
    h = (b - a) / n

    I = f(a) + f(b)
    // puntos intermedios
    for i = 1:(n-1)
        xi = a + i*h
        I = I + (f(xi) * (modulo(i, 2)*2 + 2))
    end
    I = (h/3) * I
endfunction

function I = simpsonCompuesto_def(fun, a, b, n)
    deff("y=f(x)", "y="+fun);
    h = (b - a) / n

    I = f(a) + f(b)
    // puntos intermedios
    for i = 1:(n-1)
        xi = a + i*h
        I = I + (f(xi) * (modulo(i, 2)*2 + 2))
    end
    I = (h/3) * I
endfunction

I1 = simpsonCompuesto(g, a, b, 2)

I2 = simpsonCompuesto("x^2 + 2", a, b, 2)

printf('Valores aproximados para n = 2\n\t%f\n\t%f\nValor esperado:%f', I1, I2, 20/3);

I1 = simpsonCompuesto(g, a, b, 4)

I2 = simpsonCompuesto("x^2 + 2", a, b, 4)

printf('Valores aproximados para n = 2\n\t%f\n\t%f\nValor esperado:%f', I1, I2, 20/3);
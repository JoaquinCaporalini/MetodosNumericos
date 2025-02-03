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

function output = ejer3(fun, a, b, n)
    aprox     = simpsonCompuesto_def(fun, a, b, n);
    verdadero = integrate(fun,"x", a, b);
    err       = abs(verdadero - aprox);

    output = err
    printf("Funcion: %s en [%f, %f]\n", fun, a, b);
    printf("\tAproximación: %f\n", aprox);
    printf("\tReal:         %f\n", verdadero);
    printf("\terror:        %f\n", err);
endfunction

ejer3("1/x", 1, 3, 4);
ejer3("x^3", 0, 2, 4);
ejer3("x * (1 + x^2)^(1/2)", 0, 3, 6);
ejer3("sin(%pi * x)", 0, 1, 8);
ejer3("x * sin(x)", 0, 2*%pi, 8);
ejer3("x^2 * exp(x)", 0, 1, 8);

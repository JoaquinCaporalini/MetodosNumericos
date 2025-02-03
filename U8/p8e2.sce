function I = trapecioComp_def(fun, a, b, n)
    deff("y=f(x)", "y="+fun);
    h = (b - a) / n;
    
    I = (f(a) + f(b)) / 2;

    for i = 1:n-1
        I = I + f(a + i*h);
    end

    I = I * h;
endfunction

function output = ejer2(fun, a, b, n)
    aprox     = trapecioComp_def(fun, a, b, n);
    verdadero = integrate(fun,"x", a, b);
    err       = abs(verdadero - aprox);

    output = err
    printf("Funcion: %s en [%f, %f]\n", fun, a, b);
    printf("\tAproximación: %f\n", aprox);
    printf("\tReal:         %f\n", verdadero);
    printf("\terror:        %f\n", err);
endfunction

ejer2("1/x", 1, 3, 4);
ejer2("x^3", 0, 2, 4);
ejer2("x * (1 + x^2)^(1/2)", 0, 3, 6);
ejer2("sin(%pi * x)", 0, 1, 8);
ejer2("x * sin(x)", 0, 2*%pi, 8);
ejer2("x^2 * exp(x)", 0, 1, 8);

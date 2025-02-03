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

function I = trapecioComp(f, a, b, n)
    h = (b - a) / n;
    
    I = (f(a) + f(b)) / 2;

    for i = 1:n-1
        I = I + f(a + i*h);
    end

    I = I * h;
endfunction

function y = f(x)
    y = (x + 1)^(-1);
endfunction

a = 0;
b = 1.5;
n = 10;

s = simpsonCompuesto(f, a, b, n);
t = trapecioComp(f, a, b, n);
r = 0.9262907;

printf("Valor real y aproximado con n = %d en [%f, %f]\n", n, a, b);
printf("Real:     %f\n", r);
printf("Simpson:  %f\n", s);
printf("\tError: %f\n", abs(r - s));
printf("Trapecio: %f\n", t);
printf("\tError: %f\n", abs(r - t));
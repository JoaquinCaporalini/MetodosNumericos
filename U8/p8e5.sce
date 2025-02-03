// Igual al trapecio compuesto pero en este caso particular f
// es una función ya definida que recibe dos argumentos y el primero
// será siempre x
function I = tcb_aux(f, x, a, b, n)
    h = (b - a) / n

    I = (f(x, a) + f(x, b)) / 2
    for i = 1:(n-1)
        xi = a + i*h
        I = I + f(x, xi)
    end
    I = h * I
endfunction

function I = trapecioCompuestoBidim(fun, a, b, cfun, dfun, n, m)
    // f es la función a integrar
    // a y b son los límites de integración en x
    // c(x) y d(x) son los límites de integración en y dados por dos funciones
    // n es el número de subintervalos en x


    deff("z=f(x, y)", "z="+fun);
    deff("y=c(x)", "y="+cfun);
    deff("y=d(x)", "y="+dfun);
    h = (b - a) / n

    I = (tcb_aux(f, a, c(a), d(a), m) + tcb_aux(f, b, c(b), d(b), m)) / 2
    for i = 1:(n-1)
        xi = a + i*h
        I = I + tcb_aux(f, xi, c(xi), d(xi), m)
    end
    I = h * I
endfunction

f = "sin(x + y)"
a = 0
b = 2
c = "0" // Función constante
d = "1" // Función constante
printf("f(x, y) = %s\n", f)
printf("a = %f , b = %f\n", a, b)
printf("c(x) = %s\n", c)
printf("d(x) = %s\n", d)
printf("Trapecio compuesto bidimensional 2 intervalos sobre cada eje:\n")
I = trapecioCompuestoBidim(f, a, b, c, d, 2, 2)
disp(I)
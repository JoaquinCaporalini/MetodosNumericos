/* Funciones auxiliares */
// Son para hacer la integración en G(x_i)

// Igual a simpson compuesto pero en este caso particular f
// es una función ya definida que recibe dos argumentos y el primero
// será siempre x
function I = scb_aux(f, x, a, b, n)
    h = (b - a) / n

    I = f(x, a) + f(x, b)
    for i = 1:(n-1)
        xi = a + i*h
        I = I + (f(x, xi) * (modulo(i, 2)*2 + 2))
    end
    I = (h/3) * I
endfunction

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

function I = trapecioCompuestoBidim_def(fun, a, b, cfun, dfun, n, m)
    // f es la función a integrar
    // a y b son los límites de integración en x
    // c(x) y d(x) son los límites de integración en y dados por dos funciones
    // n es el número de subintervalos en y
    // m es el número de subintervalos en x
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

function I = simpsonCompuestoBidim_def(fun, a, b, cfun, dfun, n, m)
    // f es la función a integrar
    // a y b son los límites de integración en x
    // c(x) y d(x) son los límites de integración en y dados por dos funciones
    // n es el número de subintervalos en y
    // m es el número de subintervalos en x
    deff("z=f(x, y)", "z="+fun);
    deff("y=c(x)", "y="+cfun);
    deff("y=d(x)", "y="+dfun);
    h = (b - a) / n

    I = scb_aux(f, a, c(a), d(a), m) + scb_aux(f, b, c(b), d(b), m)
    for i = 1:(n-1)
        xi = a + i*h
        I = I + (scb_aux(f, xi, c(xi), d(xi), m) * (modulo(i, 2)*2 + 2))
    end
    I = (h/3) * I
endfunction
/* La idea */
//
f = "1"
a = 0; b = 2;
c = "-sqrt(2*x-x^2)"
d = "sqrt(2*x-x^2)"
printf("f(x, y) = %s\n", f)
printf("a = %f , b = %f\n", a, b)
printf("c(x) = %s\n", c)
printf("d(x) = %s\n", d)
printf("Trapecio compuesto bidimensional 1000 intervalos sobre cada eje:")
I = trapecioCompuestoBidim_def(f, a, b, c, d, 1000, 1000)
disp(I)
printf("Simpson  compuesto bidimensional 1000 intervalos sobre cada eje:")
I = simpsonCompuestoBidim_def(f, a, b, c, d, 1000, 1000)
disp(I)
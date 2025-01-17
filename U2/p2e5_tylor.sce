clc // limpia la consola
clear // borra el contenido de la memoria

function r = derivarNumderivative(f, v, n, h)
    // Description  derivarNumderivative(f, n, v)
    // ASUME ORDEN 4
    //  f: función a derivar
    //  v: valor en el que se evalúa la derivada
    //  n: número de derivadas
    //  h: el paso utilizado en las aproximaciones de diferencias finitas
    //  r: valor de la derivada n-ésima de f en v

    deff("y=DF0(x)","y="+f);

    if n==0 then 
        r = DF0(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)", "y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
        end

        deff("y=DFn(x)", "y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        
        r = DFn(v);
    end
endfunction

function y = tylor(f, a, n, h, x)
    // Description of tylor(f, a, n, h, x)
    //  f: función a aproximar
    //  a: punto de aproximación
    //  n: grado del polinomio de tylor
    //  h: paso utilizado en las aproximaciones de diferencias finitas
    //  x: punto donde se evalúa el polinomio de tylor

    //tylor(f, a)(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!} (x-a)^n

    fact = 1;
    xma  = x - a;
    resta = 1;

    deff("y=fun(x)","y="+f);

    y = fun(a);

    for i = 1:n
        fact = fact * i;     // Factorial del termino
        resta = resta * xma; // (x-a)^n
        y = y + (resta / fact) * derivarNumderivative(f, a, i, h); // 1/n! * f^(n)(a) * (x-a)^n
    end
endfunction

function y = tylor0(f, n, h, x)
    // Description of tylor0(f, n, h, x)
    //  f: función a aproximar
    //  n: grado del polinomio de tylor
    //  h: paso utilizado en las aproximaciones de diferencias finitas
    //  x: punto donde se evalúa el polinomio de tylor

    //tylor(f, 0)(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!} (x-0)^n
    //tylor(f, 0)(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!} (x)^n

    fact = 1;
    resta = 1;
    
    deff("y=fun(x)","y="+f);

    y = fun(a);

    for i = 1:n
        fact = fact * i;     // Factorial del termino
        resta = resta * x; // (x-a)^n
        y = y + (resta / fact) * derivarNumderivative(f, 0, i, h); // 1/n! * f^(n)(a) * (x-a)^n
    end
endfunction


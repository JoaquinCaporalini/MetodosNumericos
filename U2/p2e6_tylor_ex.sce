clc // limpia la consola
clear // borra el contenido de la memoria


function y = tylor_ex(a, n, x)
    // Description of tylor(f, a, n, h, x)
    //  a: punto de aproximación
    //  n: grado del polinomio de tylor
    //  x: punto donde se evalúa el polinomio de tylor

    //tylor(e^x, a)(x) = \sum_{n=0}^{\infty} \frac{e^a}{n!} (x-a)^n

    fact  = 1;
    xma   = x - a;
    resta = 1;

    ea = %e^a;

    y = ea;

    for i = 1:n
        fact = fact * i;     // Factorial del termino
        resta = resta * xma; // (x-a)^n
        y = y + (resta / fact) * ea; // 1/n! * e(a) * (x-a)^n
    end
endfunction

function y = tylor_ex0(n, x)
    // Description of tylor_ex0(n, x)
    //  n: grado del polinomio de tylor
    //  x: punto donde se evalúa el polinomio de tylor

    //tylor(e^x, 0)(x) = \sum_{n=0}^{\infty} \frac{e^x}(0)}{n!} (x-0)^n
    //tylor(f, 0)(x) = \sum_{n=0}^{\infty} \frac{1}{n!} (x)^n

    fact = 1;
    xn   = 1;
    
    y    = 1;

    for i = 1:n
        fact = fact * i;      // Factorial del termino
        xn = xn * x;          // x^n
        y = y + xn * (1 / fact) ; // 1/n! * 1 * (x)^n
    end
endfunction

if %T then
    printf("Valor real de e^(-2):\n");
    disp(%e^(-2));
    y = tylor_ex0(10, -2);
    // Esta es la mejor opción para calcular e^(-2).
    printf("Calculando a partir de e^(-2):\n");
    disp(y);
    y = 1 / tylor_ex0(10, 2);
    printf("Calculando a partir de 1/e^2:\n");
    disp(y);
end


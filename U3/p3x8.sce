// voy a usar 
//      f(x) = sin(x) + x

// Veamos que
//      f'(x) = cos(x) + 1
// Notar que 
//      2 <= x <= 4 -1 <= cos(x) < 0 por lo que
// Por lo que: 0 <= cos(x) < 1

// Sabiendo que f y f'continua en el intervalo y menor estricto a 1
// podemos garantizar que converja.

// puedo obtener sup(|f'|) < \lambda = 0.35
// con esto despejo
//      \frac{\lambda^n}{1-\lambda} < \eps => \frac{\frac{\eps (1 - \lambda)}{|x_1 - x_0|}}{log(\lambda)}

function y = f(x)
    y = sin(x) + x;
endfunction

eps = 1e-6
lam = 0.35
x0 = 2
x1 = 4
n = ceil((log(eps * (1 - lam) / abs(x0 - x1))) / log(lam))

function [x1, i] = newton(f, x0, tot, max_iter, h)
    // Description of newton(f, x0, tot, max_iter, h)
    //  f: función
    //  x0: valor inicial
    //  tot: tolerancia
    //  max_iter: número máximo de iteraciones
    //  h: paso para calcular la derivada

    i = 0;

    while i < max_iter then
        fx0 = f(x0);
        dfx0 = (f(x0 + h) - fx0) / h;

        x1 = x0 - fx0 / dfx0;

        x0 = x1;
        i = i + 1;
    end
endfunction

[pi, _] = newton(f, 2, %inf, n, 1e-6)

printf("Aprox pi: %1.11f con %d iteraciones\n", pi, n);
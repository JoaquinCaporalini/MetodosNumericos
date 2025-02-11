// Recoremos que el error de interpolación es:
//  |f(x) - p(x)| <= max_{x\in[a,b]} |f(x) - p(x)| <= 1 / (n+1)! * max_{x\in[a,b]} |f^(n+1)(x)| * max_{x\in[a,b]}|(x-x_0)(x-x_1)...(x-x_n)| 
function val = cotaerror(msg, aprox, grado, maxint, rho_n)
    //rho_n = 0.001 para n = 3
    //roh_n = 0.01 para  n = 1
    fact = factorial(grado+1)
    max_deriv = %e^(maxint) 
    val = abs((%e^(1/3)) - aprox) <= ((rho_n / fact) * max_deriv) 
    printf("La cota de error para %s es: %f\n", msg, (rho_n / fact) * max_deriv)
    if (val)
        printf("\tOK: La cota de error es correcta\n")
    else
        printf("\tERROR: La cota de error no es correcta\n")
        disp(abs((%e^(1/3)) - aprox))
    end
endfunction

cotaerror("Lagrange Lineal", y0_Lagr_lin, 1, 0.4, 0.01)
cotaerror("Lagrange cubico", y0_Lagr_cub, 3, 0.6, 0.001)
cotaerror("Newton   Lineal", y0_Newt_lin, 1, 0.4, 0.01)
cotaerror("Newton   cubico", y0_Newt_cub, 3, 0.6, 0.001)


// Funcion utilizada para acotar más rápidamente el error de una interpolación
// tener en cuenta que estoy multiplicando por el máximo teórico de la derivada
// calculado en papel, pero sirve para graficar el polinomio y ver el máximo
// para encontrar la cota
function p = polErrorInterpol(x, max_deriv)
    n = size(x, 2)

    x_pol = poly(0, "x")
    p = 1

    for i=1:n
        p = p * (x_pol - x(i))
    end
    p = p * (max_deriv / factorial(n))
endfunction

function output = polErrorInterpolEval(x0, x , max_deriv)
    // Description of polErrorInterpolEval(x0, x , max_deriv))
    //  x0: punto a evaluar
    //  x: vector de nodos
    //  max_deriv: valor máximo de la derivada
    output = horner(polErrorInterpol(x, max_deriv), x0)
endfunction

function y = plotPol(polinomi, inicial, final, step)
    // Description of plotPol(polinomi, inicial, final, step)
    rg = inicial:step:final
    y = horner(polinomi, rg)
    plot2d(rg, y)
endfunction

// Error de interpolación
function w = err(p,x,cot)
    // Entrada: p = valor real, x = nodos de interpolación, cot = cota de |f^(n))|
    // Salida: w = error de interpolación en x = p
    n = length(x)
    w = cot/(factorial(n))
    for i=1:n do
        w = w*abs(p - x(i))
    end
endfunction

// linspace(desde, hasta, cant_puntos)       
x2 = linspace(-5, 5, 2); // 2 puntos
x4 = linspace(-5, 5, 4); // 4 puntos
x6 = linspace(-5, 5, 6); // 6 puntos
x10 = linspace(-5, 5, 10); // 10 puntos
x14 = linspace(-5, 5, 14); // 14 puntos

function a = extend(x, s)
    [f,c] = size(x)
    if c <> 1
        disp("Mas de una columna")
    end
    a = zeros(f+s,1)
    a(s+1:f+s,1) = x
endfunction
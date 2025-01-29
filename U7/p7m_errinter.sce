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
x = [ 0 0.2 0.4 0.6 ]
y = [ 1.0 1.2214 1.4918 1.8221 ]

x0 = 1/3

function y = Lk(x,k)
    // Description of Lk(x,k)
    //  x: vector de nodos
    //  k: índice del nodo

    n = length(x);
    r = [x(1:k-1) x(k+1:n)]; // nodos sin x(k)
    p = poly(r,"x","roots"); // Numerador de Lk
    pk = horner(p,x(k));     // Denominador de Lk
    y = p / pk;
endfunction

function pol = lagrange(x, y)
    // Description of lagrange(x, y))
    //  x: vector de nodos
    //  y: vector de valores en los nodos

    n = length(x);
    pol = 0;
    for k = 1:n
        L = Lk(x,k);
        pol = pol + (y(k) * L);
    end
endfunction

// Diferencias dividas
function w=DD(x,y)
    n = length(x);
    if n==1 then
        // Caso Base
        w = y(1)
    else
        // Caso Recursivo
        //      Todos menos primero
        w = (DD(x(2:n),y(2:n))-DD(x(1:n-1),y(1:n-1)))/(x(n)-x(1))
        //                     Todos menos último     
        //                                  Distancia entre primer y último
    end;
endfunction

// Polinomio interpolante (con Newton)
function p = interpolNewton(x,y)
    r = poly(0,"x");
    p = 0;
    n= length(x);
    for i=n:(-1):2
        p = (p+DD(x(1:i),y(1:i)))*(r-x(i-1))
    end;
    p = p + y(1);
endfunction
// x(2) < 1/ < x(3)
polLagr_lin = lagrange(x(1,2:3), y(1,2:3))
polNewt_lin = interpolNewton(x(1,2:3), y(1,2:3))

printf('Polinomio de Lagrange de grado 1 = \n'); disp(polLagr_lin);
printf('Polinomio de Newton de grado 1 = \n'); disp(polNewt_lin);

polLagr_cub = lagrange(x, y)
polNewt_cub = interpolNewton(x, y)

printf('Polinomio de Lagrange de grado 3 = \n'); disp(polLagr_cub);
printf('Polinomio de Newton de grado 3 = \n'); disp(polNewt_cub);

y0_Lagr_lin = horner(polLagr_lin, x0)
y0_Newt_lin = horner(polNewt_lin, x0)
y0_Lagr_cub = horner(polLagr_cub, x0)
y0_Newt_cub = horner(polNewt_cub, x0)

printf("Valor esperado: %f\nLagr Lineal:    %f\nNewt Lineal:    %f\nLagr Cubico:    %f\nNewt Cubico:    %f\n", (%e^(1/3)), y0_Lagr_lin, y0_Newt_lin, y0_Lagr_cub, y0_Newt_cub);

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
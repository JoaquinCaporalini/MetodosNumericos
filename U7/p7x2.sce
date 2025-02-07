deff("y=f(x)", "y = %e.^x");

x = [-1 -(1/3) (1/3) 1]
y = f(x)

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

pl = lagrange(x, y)

// A
printf("Con el x dado\n")
printf("pl(-0.9) = %f\n", horner(pl, -0.9))
printf("pl(0.01) = %f\n", horner(pl, 0.01))

// B 

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

perror = polErrorInterpol(x, %e)
// plotPol(perror, -1, 1, 0.001)

cota_error = 0.0225

r = -1:0.001:1

deff("y=pl_eval(x)", "y = horner(pl, x)")
deff("y=pl_cotsup(x)", "y=horner(pl,x) + horner(perror,x)")
deff("y=pl_cotinf(x)", "y=horner(pl,x) - horner(perror,x)")


subplot(1,2,1)
plot(r, pl_eval(r), "r", r, pl_cotinf(r), "b", r, pl_cotsup(r), "b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

function w = rootsCheby_ab(n,a,b)
    // n: grado del polinomio de Chebyshev (cant raíces)
    // a: extremo izquierdo del intervalo
    // b: extremo derecho del intervalo

    //Buscar las raíces forma tradicional
    for i=0:(n-1) do
        w(i+1)=cos((2*i+1)*%pi/(2*n)) // eq (6)
    end
    //Transformar las raíces al intervalo [-1, 1] -> [a,b]
    w = ((b+a) + w*(b-a))/2
    w = w'
endfunction

x = rootsCheby_ab(4, -1, 1)
y = f(x)

pl = lagrange(x, y)

printf("Con raices de Chaby\n")
printf("pl(-0.9) = %f\n", horner(pl, -0.9))
printf("pl(0.01) = %f\n", horner(pl, 0.01))

perror = polErrorInterpol(x, %e)
// plotPol(perror, -1, 1, 0.001)

r = -1:0.001:1

deff("y=pl_eval(x)", "y = horner(pl, x)")
deff("y=pl_cotsup(x)", "y=horner(pl,x) + horner(perror,x)")
deff("y=pl_cotinf(x)", "y=horner(pl,x) - horner(perror,x)")

subplot(1,2,2)
plot(r, pl_eval(r), "r", r, pl_cotinf(r), "b", r, pl_cotsup(r), "b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
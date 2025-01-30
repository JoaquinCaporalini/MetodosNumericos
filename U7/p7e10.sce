function y = f(x)
    y = %e.^x;
endfunction

function w = rootsCheby(n)
    // Entrada: n = grado del polinomio de Chebyshev
    // Salida: w = vector con las raices del polinomio de Chebyshev
    for i=0:(n-1) do
        w(i+1)=cos((2*i+1)*%pi/(2*n)) // eq (6)
    end
    w = w'
endfunction

x = rootsCheby(4);
y = f(x);

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

p = lagrange(x, y)

r = -1:0.001:1;
err = f(r) - horner(p,r);

plot(r,err);
xtitle("Error (f(x) - p_3(x))","x","y");

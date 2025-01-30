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

x = rootsCheby_ab(4, 0, %pi/2);
y = cos(x);

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

r = 0:0.001:%pi/2;
err = cos(r) - horner(p,r);

plot(r,err);
xtitle("Error (f(x) - p_3(x))","x","y");

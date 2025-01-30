// 1) Como p_1,2,3(x) es un polinomio lo puedo obtener por 3 puntos (ejer 2)
x = [1 2 2.5]
y = [3 3 3]

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

p_123 = lagrange(x,y);

y_3 = horner(p_123, 3);

x = [ 0 1 2 3 ];
y = [ 1 3 3 y_3 ];

p_0123 = lagrange(x, y);
y_0 = horner(p_0123, 2.5);
printf("p_0123(x)=");disp(p_0123);
printf("El valor de p_0123(2.5) = %f\n", y_0);

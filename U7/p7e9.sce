function y = f(x)
    y = 1 ./ (1 + x.^2);
endfunction

x2 = linspace(-5, 5, 2); // 2 puntos
x4 = linspace(-5, 5, 4); // 4 puntos
x6 = linspace(-5, 5, 6); // 6 puntos
x10 = linspace(-5, 5, 10); // 10 puntos
x14 = linspace(-5, 5, 14); // 14 puntos

y2 = f(x2);
y4 = f(x4);
y6 = f(x6);
y10 = f(x10);
y14 = f(x14);

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

p2 = lagrange(x2, y2);
p4 = lagrange(x4, y4);
p6 = lagrange(x6, y6);
p10 = lagrange(x10, y10);
p14 = lagrange(x14, y14);

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

r = -5:0.001:5;
fx = f(r);

err2 = fx - horner(p2, r);
err4 = fx - horner(p4, r);
err6 = fx - horner(p6, r);
err10 = fx - horner(p10, r);
err14 = fx - horner(p14, r);

plot(r,err2,"b",r,err4,"g",r,err6,"m", r,err10,"c", r,err14,"y");
xtitle("Error (f(x) - p_n(x))","x","y");
legend(["err2","err4","err6","err10","err14"]);
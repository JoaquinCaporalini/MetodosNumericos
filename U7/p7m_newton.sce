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

// Ejemplo
x = [ 0 1 2]
y = [ -1 -1 7 ]

p = interpolNewton(x, y)
disp(p)
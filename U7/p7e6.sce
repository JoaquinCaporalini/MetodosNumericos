// Números obtenidos a partir de 
// f [x0] = f(x0)
// f [x0,x1] = \frac{f(x1) - f(x0)}{x1-x0}
// f[x0, ... ,xn] = \frac{f[x1, ... ,xn] - f[x0, ... ,xn-1]}{xn - x0}

x = [-1 1 2 4];
y = [2 4 -1 59];

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

p3 = interpolNewton(x,y)
printf("Polinomio de grado 3 para f:"); disp(p3);
y0 = horner(p3, 0)
printf("p3(0) = %f\n", y0)

cota_derivada = 33.6
phi_3_0 = horner(poly(x, "x", "roots"), 0) // \phi_3(0)
err = abs(phi_3_0) * cota_derivada  / factorial(4);
printf("Con un error máxima de %f\n", err); 
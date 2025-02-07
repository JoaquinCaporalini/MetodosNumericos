function [c, i] = biseccionEps(f, a, b, eps)
    // Description of biseccion(f, a, b, tol, max_iter)
    //  f: función
    //  a: límite inferior del intervalo
    //  b: límite superior del intervalo
    //  tol: tolerancia
    //  max_iter: número máximo de iteraciones
    
    i = 1;

    max_iter = ceil(log2((b-a)/eps))
    
    fa = f(a);
    fb = f(b);

    if fa == 0 then
        c = a;
        return;
    end

    if fb == 0 then
        c = b;
        return;
    end

    c = (a + b) / 2;
    fc = f(c);

    while  i < max_iter then
        if fa * fc < 0 then
            b = c;
            fb = fc;
        end
        
        if fb * fc < 0 then
            a = c;
            fa = fc;
        end
    
        c = (a + b) / 2;
        fc = f(c);
        
        i = i + 1;
    end
endfunction

function rs = factorizar_(p, i, f, eps)
    // Función para factorizar polinomios conociendo las raíces.
    // [i, f] intervalo donde se encuentran todas las raíces

    ci = coeff(p);
    cb = ci;

    grado = degree(p)

    rs = zeros(1, grado)

    for n = grado:(-1):2
        // Busco mi raíz
        deff("y = p_fun(x)", "y=horner(p,x)")
        disp(n, rs, ci)
        rs(n) = biseccionEps(p_fun, a, b, eps)

        // Me armo los nuevos coeficientes
        // posición dentro del arreglo de coeficientes es uno más
        // a_n esta en ci(n+1) en definitiva n es ya menos 1
        cb(n) = ci(n+1)

        for j = n-1:-1:1
            cb(j) = ci(j+1) + rs(n) * cb(j+1)
        end
        disp(cb(1:n))
        p = poly(cb(1:n), "x", "coeff")
        ci = coeff(p);
        disp(" ")
    end 

    rs(1) = - ci(1) / ci(2);

endfunction



function rs = factorizar(p, i, f, eps)
    // Función para factorizar polinomios conociendo las raíces.
    // [i, f] intervalo donde se encuentran todas las raíces

    a = coeff(p);
    b = a;

    grado = degree(p)

    rs = zeros(1, grado)

    for n = grado:(-1):2
        deff("y = p_fun(x)", "y=horner(p,x)")
        rs(n) = biseccionEps(p_fun, i, f, eps);

        b(n) = a(n+1)
        
        for j = n-1:-1:1
            b(j) = a(j+1) + rs(n) * b(j+1);
        end

        p = poly(b(1:n), "x", "coeff");
        a = coeff(p);
    end 

    rs(1) = - a(1) / a(2);

endfunction

// Prueba
p = poly([0 -2 -1 1], "x", "coeff")
disp(factorizar(p, -2, 3, 1e-10))

// Ejercicio
p = poly([(7392/625) -(3356/125) (552/25) -(93/5) 1], "x", "coeff");
disp(factorizar(p, 1, 3, 1e-6))

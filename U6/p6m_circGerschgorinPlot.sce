function [centros, radios] = circGershgoring(A)
    // Sea A \in C^nxn y \lam un auto valor de A.
    // Entonces, \lam pertenece a al menos un círculo de Gershgoring
    // con centro en a_{ii} y radio r_i = \sum_{j=1, j<>i}^{n} |a_{ij}|

    n = size(A, 1);

    centros = zeros(n, 1);
    radios = zeros(n, 1);

    for i = 1:n
        centros(i) = A(i, i);
        radios(i)  = sum(abs(A(i, :))) - abs(A(i, i));
    end
endfunction

function dibujarCirculosGers(A)
    [centros, radios] = circGershgoring(A)
    n = size(A, 1)
    max_y = ceil(max(radios))
    aux1 = centros + radios
    aux2 = centros - radios
    max_x = ceil(max(max(abs(aux1)), max(abs(aux2))))
    bordes = [-max_x -max_y/2 max_x max_y/2]
    plot2d(0, 0, 0, "031", " ", bordes, frameflag=3, axesflag=5)
    a=gca(); // Handle on axes entity
    a.x_location = "origin";
    a.y_location = "origin";

    for i=1:n
        // (x, y) representa la esquina sup. izq. del rectangulo que contiene al circ
        r = radios(i)
        c = centros(i)
        x = c - r
        y = r
        xarc(x, y, r*2, r*2, 0, 360*64)
    end
endfunction

function dibujarCirculosGersValor(A)
    dibujarCirculosGers(A)
    valores = spec(A)
    xpoly(real(valores), imag(valores), "marks")
    e=gce()
    set(e,"mark_style",3)
endfunction

function dibujarCirculosTrans(A)
    [centros, radios] = circGershgoring(A)
    n = size(A, 1)
    max_y = ceil(max(radios))
    aux1 = centros + radios
    aux2 = centros - radios
    max_x = ceil(max(max(abs(aux1)), max(abs(aux2))))
    bordes = [-max_x -max_y/2 max_x max_y/2]
    plot2d(0, 0, 0, "031", " ", bordes, frameflag=3, axesflag=5)
    a=gca(); // Handle on axes entity
    a.x_location = "origin";
    a.y_location = "origin";

    for i=1:n
        // (x, y) representa la esquina sup. izq. del rectangulo que contiene al circ
        r = radios(i)
        c = centros(i)
        x = c - r
        y = r
        xarc(x, y, r*2, r*2, 0, 360*64)
    end

    [centros, radios] = circGershgoring(A')

    
    for i=1:n
        // (x, y) representa la esquina sup. izq. del rectangulo que contiene al circ
        r = radios(i)
        c = centros(i)
        x = c - r
        y = r
        xarc(x, y, r*2, r*2, 0, 360*64)
    end
    gca().children((n+1):(2*n)).foreground = color("green");

endfunction

A = [ 4 1 0 ; 1 0 -1 ; 0 -1 -4 ];
dibujarCirculosGersValor(A)
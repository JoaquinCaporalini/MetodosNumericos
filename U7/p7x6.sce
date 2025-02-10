x = [ 0 0 1 2 2 2 ]
v = [ 0 1 0 0 1 2 ]
y = [ 1.42 1.85 0.78 0.18 0.60 1.05 ]

function [x,a] = gausselimPP(A,b)
    // Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
    // dada la matriz de coeficientes A y el vector b.
    // La función implementa el método de Eliminación Gaussiana con pivoteo parcial.
    
    [nA,mA] = size(A) 
    [nb,mb] = size(b)
    
    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('gausselim - dimensiones incompatibles entre A y b');
        abort;
    end;
    
    a = [A b]; // Matriz aumentada
    n = nA;    // Tamaño de la matriz
    
    // Eliminación progresiva con pivoteo parcial
    for k=1:n-1           // Columna que voy a eliminar
        kpivot = k; amax = abs(a(k,k));  //pivoteo
        for i=k+1:n
            if abs(a(i,k))>amax then
                kpivot = i; amax = a(i,k);
            end;
        end;

        // Swap entre la fila k y la fila kpivot
        temp = a(kpivot,:); a(kpivot,:) = a(k,:); a(k,:) = temp;

        //Método de eliminación Gaussiana
        for i=k+1:n       // Fila que uso para eliminar (pivoteada)     
            for j=k+1:n+1 // Calculo los que no son cero
                a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
            end;
            // Piso en 0 los eliminados (0 garantizado)
            for j=1:k        // no hace falta para calcular la solución x
                a(i,j) = 0;  // no hace falta para calcular la solución x
            end              // no hace falta para calcular la solución x
        end;
    end;
    
    // Sustitución regresiva (Triangular superior)
    x(n) = a(n,n+1)/a(n,n);
    for i = n-1:-1:1
        sumk = 0
        for k=i+1:n
            sumk = sumk + a(i,k)*x(k);
        end;
        x(i) = (a(i,n+1)-sumk)/a(i,i);
    end;
endfunction


function cff = minCuadPol(A,b)
    // Aproximación polinomial de mínimos cuadrados
    // Teorema2.a: Conj sol del sistema A'A x = A'b
    //             (único si A tiene rango n)
    // A : matriz de aplicar las \phi a los puntos
    //     recordar A_ij = \phi_j(x_i)
    // b : valor en y del punto y_i
    [cff,A_amp] = gausselimPP((A')*A,(A')*(b'))
endfunction


// Matriz del método de mínimo cuadrados polinomial
function A = matrizMinCuadPol(x, v, grado)
    // x: posición de los puntos en x
    // grado: grado del polinomio (la matriz obtenida es de grado+1)
                                  //(termino independiente)
    m = length(x)
    A = ones(m,1)
    for j=1:grado
        A = [A,(x').^j (v').^j]
    end
endfunction

function y = eval(cff, x, v)
    cff = cff'
    n = (length(cff) - 1) / 2;
    y = cff(1)
    for i = 1:n
        y = y + cff(2*i) * (x^i) + cff(2*i+1) * (v^i) 
    end
endfunction

A = matrizMinCuadPol(x, v, 1)

p = minCuadPol(A,y)

// y = eval(p, 0, 0)

rx = 0:0.1:2
rv = 0:0.1:2

rz = zeros(length(rx), length(rv))

for i = 1:length(rx)
    for j = 1:length(rv)
        rz(i,j) = eval(p, rx(i), rv(j))
    end
end

set(gca(), "auto_clear", "off")
scatter3d(x, v, y, , "red", "fill")
plot3d(rx, rv, rz, "b")
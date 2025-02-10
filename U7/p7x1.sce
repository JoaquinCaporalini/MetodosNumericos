x = [ -2.0 -1.6 -1.2 -0.8 -0.4 0 0.4 0.8 1.2 1.6 2.0 ]
y = [ 1.50 0.99 0.61 0.27 0.02 -0.0096 0.065 0.38 0.63 0.98 1.50 ]

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

function a = extend(x, s)
    [f,c] = size(x)
    if c <> 1
        disp("Mas de una columna")
    end
    a = zeros(f+s,1)
    a(s+1:f+s,1) = x
endfunction


function [p,err] = minCuadPol(A,b)
    // Aproximación polinomial de mínimos cuadrados
    // Teorema2.a: Conj sol del sistema A'A x = A'b
    //             (único si A tiene rango n)
    // A : matriz de aplicar las \phi a los puntos
    //     recordar A_ij = \phi_j(x_i)
    // b : valor en y del punto y_i
    [a,A_amp] = gausselimPP((A')*A,(A')*(b'))
    a = extend(a,2)
    disp(a)
    p = poly(a,"x","coeff")
    // err = norm(A*a-(b'))
    err = %nan
endfunction

// Matriz del método de mínimo cuadrados polinomial
function A = matrizMinCuadPol(x,grado)
    // x: posición de los puntos en x
    // grado: grado del polinomio (la matriz obtenida es de grado+1)
                                  //(termino independiente)
    m = length(x)
    A = []
    for j=2:grado
        A = [A,(x').^j]
    end
endfunction

A = matrizMinCuadPol(x, 4)

p = minCuadPol(A, y)

printf("Polinomio")
disp(p)
printf("p(0)")
disp(horner(p, 0))
printf("p(1)(0)")
disp(0)


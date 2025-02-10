x   = [ 1 2 3 4 5 6 7 8 9 10 11 12]
y21 = [ 145.61 151.12 157.27 164.72 172.29 182.91 185.12 188.62 190.09 197.99 204.32 207.97 ]
y22 = [ 209.92 225.82 265.71 295.24 301.62 311.80 327.39 343.10 366.54 385.20 407.77 428.42 ]



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


function [p,err] = minCuadPol(A,b)
    // Aproximación polinomial de mínimos cuadrados
    // Teorema2.a: Conj sol del sistema A'A x = A'b
    //             (único si A tiene rango n)
    // A : matriz de aplicar las \phi a los puntos
    //     recordar A_ij = \phi_j(x_i)
    // b : valor en y del punto y_i
    [a,A_amp] = gausselimPP((A')*A,(A')*(b'))
    p = poly(a,"x","coeff")
    err = norm(A*a-(b'))
endfunction

// Matriz del método de mínimo cuadrados polinomial
function A = matrizMinCuadPol(x,grado)
    // x: posición de los puntos en x
    // grado: grado del polinomio (la matriz obtenida es de grado+1)
                                  //(termino independiente)
    m = length(x)
    A = ones(m,1)
    for j=1:grado
        A = [A,(x').^j]
    end
endfunction

function s = sum_mincuad(p, x, y)
    s = 0
    n = size(x, 1)
    for i = 1:n
        s = s + (horner(p,x(i)) - y(i))^2
    end
endfunction

A1 = matrizMinCuadPol(x, 1)
A2 = matrizMinCuadPol(x, 2)
A3 = matrizMinCuadPol(x, 3)

p1_21 = minCuadPol(A1, y21)
p2_21 = minCuadPol(A2, y21)
p3_21 = minCuadPol(A3, y21)

p2_22 = minCuadPol(A2, y22)
p1_22 = minCuadPol(A1, y22)
p3_22 = minCuadPol(A3, y22)

printf("p1_21\n")
disp(p1_21)
disp(sum_mincuad(p1_21, x, y21))

printf("p2_21 (Elegido)\n")
disp(p2_21)
disp(sum_mincuad(p2_21, x, y21))

printf("p3_21\n")
disp(p3_21)
disp(sum_mincuad(p3_21, x, y21))

printf("p1_22\n")
disp(p1_22)
disp(sum_mincuad(p1_22, x, y22))

printf("p2_22\n")
disp(p2_22)
disp(sum_mincuad(p2_22, x, y22))

printf("p3_22 (Elegido)\n")
disp(p3_22)
disp(sum_mincuad(p3_22, x, y22))

// El precio crecerá hasta los 465 pesos
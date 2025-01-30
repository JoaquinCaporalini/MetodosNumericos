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

function [p,err] = minCuadPolInv(A,b)
    // Aproximación polinomial de mínimos cuadrados
    // Teorema2.b: Conj sol del sistema  x = (A'A)^{-1} A'b
    //             (único si A tiene rango n)
    // A : matriz de aplicar las \phi a los puntos
    //     recordar A_ij = \phi_j(x_i)
    // b : valor en y del punto y_i

    a = inv(A'* A) * A' * b'
    p = poly(a,"x","coeff")
    err = norm(A*a-(b'))
endfunction

function [p,err] = minCuadPolQR(A,b)
    // Aproximación polinomial de mínimos cuadrados
    // Si Rang(A) = n y A = QR (Q Q' = I y R R' = I) => R x = Q' b
    [Q, R] = qr(A, ["e"])
    a = inv(R) * Q' * b'
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

// Ejemplo de uso

x = [1 2 3 4 5];
y = [2 3 5 4 6];

A = matrizMinCuadPol(x,1);

p1 = minCuadPol(A,y);
p2 = minCuadPolInv(A,y);
p3 = minCuadPolQR(A,y);

disp(p1);
disp(p2);
disp(p3);

// Gráfica
r = 0:0.01:6;
plot(x,y,"*r",r,horner(p1,r),"b",r,horner(p2,r),"g",r,horner(p3,r),"m");
xtitle("Aproximación polinomial de mínimos cuadrados","x","y");
legend(["Puntos","Gauss","Inversa","QR"]);
A = matrizMinCuadPol(x,2);


p1 = minCuadPol(A,y);
p2 = minCuadPolInv(A,y);
p3 = minCuadPolQR(A,y);

disp(p1);
disp(p2);
disp(p3);

// Gráfica
r = 0:0.01:6;
plot(x,y,"*r",r,horner(p1,r),"b",r,horner(p2,r),"g",r,horner(p3,r),"m");
xtitle("Aproximación polinomial de mínimos cuadrados","x","y");
legend(["Puntos","Gauss","Inversa","QR"]);
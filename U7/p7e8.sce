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

x = [ 4 4.2 4.5 4.7 5.1 5.5 5.9 6.3 6.8 7.1 ]
y = [ 102.56 113.18 130.11 142.05 167.53 195.14 224.87 256.73 299.5 326.72 ]

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

A1 = matrizMinCuadPol(x,1)
A2 = matrizMinCuadPol(x,2)
A3 = matrizMinCuadPol(x,3)

[p1,err1] = minCuadPol(A1,y)
[p2,err2] = minCuadPol(A2,y)
[p3,err3] = minCuadPol(A3,y)

printf('Polinomio de grado 1\n');disp(p1); printf('Error: %f\n\n',err1);
printf('Polinomio de grado 2\n');disp(p2); printf('Error: %f\n\n',err2);
printf('Polinomio de grado 3\n');disp(p3); printf('Error: %f\n\n',err3);

// Gráfica
r = 4:0.001:7;
plot(x,y,"*r",r,horner(p1,r),"b",r,horner(p2,r),"g",r,horner(p3,r),"m");
xtitle("Aproximación polinomial de mínimos cuadrados","x","y");
legend(["Puntos","p_1(x)","p_2(x)","p_3(x)"]);

[m, p] = min([err1, err2, err3])

printf('El polinomio de grado %d es el que mejor se ajusta a los datos\n', p);
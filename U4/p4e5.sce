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

A2 = [1 -1 2 -1 ; 2 -2 3 -3 ; 1 1 1 0 ; 1 -1 4 3];
b2 = [-8 -20 -2 4]';

printf("Ejercicio 2B con pivoteo parcial\n");
// No encuentra solución
[x2,a2] = gausselimPP(A2,b2);
disp(A2)
disp(x2);
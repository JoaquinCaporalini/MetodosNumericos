function [x,a] = gausselim(A,b)
    // Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
    // dada la matriz de coeficientes A y el vector b.
    // La función implementa el método de Eliminación Gaussiana sin pivoteo.  
    
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
    
    // Eliminación progresiva
    n = nA;
    for k=1:n-1            // Columna que voy a eliminar
        for i=k+1:n        // Fila que uso para eliminar
            for j=k+1:n+1  // Calculo los que no son cero
                a(i,j) = a(i,j) - a(k,j) * a(i,k) / a(k,k);
                         //               {     m_ik      }
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


A1 = [1 1 0 3 ; 2 1 -1 1 ; 3 -1 -1 2 ; -1 2 3 -1];
b1 = [4 1 -3 4]';

A2 = [1 -1 2 -1 ; 2 -2 3 -3 ; 1 1 1 0 ; 1 -1 4 3];
b2 = [-8 -20 -2 4]';

A3 = [1 1 0 4 ; 2 1 -1 1 ; 4 -1 -2 2 ; 3 -1 -1 2];
b3 = [2 1 0 -3]';

printf("---------Ej 1---------\n");
printf("--------- Bi ---------\n");
[x1,a1] = gausselim(A1,b1);
disp(A1)
disp(x1);
printf("--------- Bii---------\n");
// No encuentra solución
[x2,a2] = gausselim(A2,b2);
disp(A2)
disp(x2);
printf("--------- Biii--------\n");
[x3,a3] = gausselim(A3,b3);
disp(A3)
disp(x3);


function [x,a, contador] = gausselim_mod(A,b)
    // Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
    // dada la matriz de coeficientes A y el vector b.
    // La función implementa el método de Eliminación Gaussiana sin pivoteo.  
    
    contador = 0;

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
    
    // Eliminación progresiva
    n = nA;
    for k=1:n-1            // Columna que voy a eliminar
        for i=k+1:n        // Fila que uso para eliminar
            a(i, k+1:n+1) = a(i, k+1:n+1) - a(k, k+1:n+1)*a(i,k)/a(k,k);
            contador = contador + 3*(n-k+1);
            a(i, 1:k) = 0; // no hace falta para calcular la solución x
        end;
    end;
    
    // Sustitución regresiva (Triangular superior)
    x(n) = a(n,n+1)/a(n,n);
    for i = n-1:-1:1
        sumk = sum(a(i, i+1:n) * x(i+1:n));
        x(i) = (a(i,n+1)-sumk)/a(i,i);
        contador = contador + 2*(n-i) + 2;
    end;
endfunction 

printf("---------Ej 1---------\n");
printf("--------- Ci ---------\n");
[x1,a1,n1] = gausselim_mod(A1,b1);
disp(A1)
disp(x1);
disp(n1);
printf("--------- Cii---------\n");
// No encuentra solución
[x2,a2,n2] = gausselim_mod(A2,b2);
disp(A2)
disp(x2);
disp(n2);
printf("--------- Ciii--------\n");
[x3,a3,n3] = gausselim_mod(A3,b3);
disp(A3)
disp(x3);
disp(n3);

// Todas muestran 78 pues son de la misma dimensión
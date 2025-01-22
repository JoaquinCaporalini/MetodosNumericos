function [x,a, c] = gausselim(A,b)
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
    
    c = 0;
    // Eliminación progresiva
    n = nA;
    for k=1:n-1            // Columna que voy a eliminar
        m_ik = a(k+1,k) / a(k,k)
        a(k+1,k+1) = a(k+1,k+1) - m_ik * a(k,k+1); 
        a(k+1,n+1) = a(k+1,n+1) - m_ik * a(k,n+1); 

        c = c + 5;

        // Piso en 0 los eliminados (0 garantizado)
        a(k+1,k) = 0;  // no hace falta para calcular la solución x
    end;
    
    // Sustitución regresiva (Triangular superior)
    x(n) = a(n,n+1)/a(n,n);
    for i = n-1:-1:1
        x(i) = (a(i,n+1) - x(i+1) * a(i,i+1)) / a(i,i);
        c = c + 3;
    end;
endfunction

// Ejemplos de aplicación
A = [1 2 0 0 ; 1 3 4 0 ; 0 1 5 7 ; 0 0 2 21];
b = [1 1 3 1]';

[x,a, c] = gausselim(A,b)
printf('Obtenido\n');
disp(x)
printf('Operaciones\n');
disp(c)
printf('Esperado\n');
disp([65 -32 8 -0.7142857]')

function [x,a] = gausselim(A,B)
    // Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
    // dada la matriz de coeficientes A y el vector b.
    // La función implementa el método de Eliminación Gaussiana sin pivoteo.  
    
    [nA,mA] = size(A) 
    [nb,mb] = size(B)
    
    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('gausselim - dimensiones incompatibles entre A y b');
        abort;
    end;
    
    a = [A B]; // Matriz aumentada
    
    // Eliminación progresiva
    n = nA;
    for k=1:n-1            // Columna que voy a eliminar
        for i=k+1:n        // Fila que uso para eliminar
            m_ij = a(i,k) / a(k,k);
            a(i, k+1:n+mb) = a(i, k+1:n+mb) - a(k, k+1:n+mb) .* m_ij;        
            // Piso en 0 los eliminados (0 garantizado)
            a(i,k) = 0;
        end;
    end;
    
    // Sustitución regresiva (Triangular superior)
    x(n,1:mb) = a(n,n+1:n+mb) ./ a(n,n);
    for i = n-1:-1:1
        
        sumk = a(i,(i+1):n) * x((i+1):n,1:mb);
        
        x(i, 1:mb) = (a(i,n+1)-sumk)./a(i,i);
    end;
endfunction

// Ejemplos de aplicación
A = [ 1 1 ; 2 3]
B = [1 3 3 ; 1 3 7]
[x,a] = gausselim(A,B)
disp(x)
disp(a)
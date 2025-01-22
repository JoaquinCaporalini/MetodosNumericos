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
    x(nA,1:mb) = a(nA,(nA+1):(nA+mb))./a(nA,nA)

    for i = (nA-1):-1:1 do
        x(i,1:mb) = (a(i,(mA+1):(mA+mb)) - a(i,(i+1):mA)*x((i+1):mA,1:mb))./a(i,i)
    end
endfunction

printf("\n---------Ej 3---------\n");
A =  [ 1 2 3 ; 3 -2 1 ;4 2 -1];
B = [ 14 9 -2 ; 2 -5 2 ; 5 19 12];

[X, a] = gausselim(A, B);
printf("Apartado B:\n");
printf("Solución al primer sistema:\n");
disp(X(:,1));
printf("Solución al segundo sistema:\n");
disp(X(:,2));
printf("Solución al tercero sistema:\n");
disp(X(:,3));

printf("Apartado c:\n");
printf("Inversa de A:\n");
[Inv, a] = gausselim(A, eye(3,3));
// Inv = a(:,4:6);
disp(Inv);
disp(Inv * A) // No es exactamente la identidad porque hay errores acumulados ='(


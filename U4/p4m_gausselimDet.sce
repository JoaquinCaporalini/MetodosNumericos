clc // limpia la consola
clear // borra el contenido de la memoria

function detA = gaussElimDet(A)
    // Esta función obtiene el determinante de A, 
    
    [nA,mA] = size(A) 
    
    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    end;
    
    // Eliminación progresiva
    n = nA;
    for k=1:n-1            // Columna que voy a eliminar
        for i=k+1:n        // Fila que uso para eliminar
            // Calculo los que no son cero
            m_ik = A(i,k) / A(k,k);
            A(i,k+1:n) = A(i,k+1:n) - A(k,k+1:n) * m_ik;
            
            // Piso en 0 los eliminados (0 garantizado)
            // A(i,k) = 0;  // no hace falta para calcular la solución x
        end;
    end;
    
    // Calculo del determinante
    detA = prod(diag(A));
endfunction


// Ejemplos de aplicación
A = [3 -2 -1; 6 -2 2; -9 7 1]
B = [5 7 ; 10 14]

disp('Determinante de A')
detA = gaussElimDet(A)
disp(detA)
disp(det(A))

disp('Determinante de B')
detB = gaussElimDet(B)
disp(detB)
disp(det(B))
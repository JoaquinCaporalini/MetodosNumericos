clc // limpia la consola
clear // borra el contenido de la memoria

function x = tringularInferior(A, b)
    // Description of tringularInferior(A, b)
    //  A: matriz triangular inferior
    //  b: vector de términos independientes

    // Fila | Columna
    [nA,mA] = size(A) 
    [nb,mb] = size(b)

    if nA<>mA then
        error('triangularSuperior - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('triangularSuperior - dimensiones incompatibles entre A y b');
        abort;
    end;

    Ab = [A b]; // Matriz aumentada

    // Resolución del sistema

    x(1) = Ab(1,nA+1)/A(1,1);
    for i = 2:nA
        // x_i = (b_i - sum_{k=1}^{i-1} a_{ik} x_k) / a_{ii}
        sum_k = A(i,1:i-1) * x(1:i-1); // Hacer la suma es lo mismo que hacer el producto interno
        x(i) = (b(i) - sum_k) / A(i,i);
    end;
endfunction
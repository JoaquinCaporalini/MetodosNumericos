clc // limpia la consola
clear // borra el contenido de la memoria

function x = tringularSuperior(A, b)
    // Description of tringularSuperior(A, b)
    //  A: matriz triangular superior
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

    // Ab = [A b]; // Matriz aumentada

    // Resolución del sistema
    x(nA) = b(nA) / A(nA,nA);

    for i = nA-1:-1:1 
        // x_i = (b_i - sum_{k=i+1}^{Na} A_{ik} x_k) / a_{ii}
        sum_k = A(i, i+1:nA) * x(i+1:nA); // Hacer la suma es lo mismo que hacer el producto interno
        x(i)  = (b(i) - sum_k) / A(i,i);
    end;
endfunction

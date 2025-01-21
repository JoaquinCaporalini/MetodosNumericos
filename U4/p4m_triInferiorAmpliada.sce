clc // limpia la consola
clear // borra el contenido de la memoria

function X = tringularInferiorAmpliada(A, B)
    // Description of tringularSuperior(A, b)
    //  A: matriz triangular superior
    //  b: vector de términos independientes

    // Fila | Columna
    [nA,mA] = size(A) 
    [nB,mB] = size(B)

    if nA<>mA then
        error('triangularSuperior - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nB then
        error('triangularSuperior - dimensiones incompatibles entre A y b');
        abort;
    end;

    // Matriz aumentada
    A_aum = [A,B];

    // Sustitución progresiva
    X(1,1:mB) = A_aum(1,(nA+1):(nA+mB))./A_aum(1,1)

    for i = 2:nA do
        X(i,1:mB) = (A_aum(i,(mA+1):(mA+mB)) - A_aum(i,1:(i-1))*X(1:(i-1),1:mB))./A_aum(i,i)
    end
endfunction



A = [1 0 0 ; 2 3 0 ; 4 5 6]
B1 = [0 ; 0 ; 0]
B2 = [1 ; 2 ; 3]
B3 = [-1 ; -1 ; -1]
B4 = [1 ; 1 ; 1]
B  = [B1 B2 B3 B4]

X1 = tringularInferiorAmpliada(A, B)

disp(X1)

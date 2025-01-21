clc // limpia la consola
clear // borra el contenido de la memoria

function X = tringularSuperiorAmpliada(A, B)
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

    // Sustitución regresiva
    X(nA,1:mB) = A_aum(nA,(nA+1):(nA+mB))./A_aum(nA,nA)

   for i = (nA-1):-1:1 do
      X(i,1:mB) = (A_aum(i,(mA+1):(mA+mB)) - A_aum(i,(i+1):mA)*X((i+1):mA,1:mB))./A_aum(i,i)
   end
endfunction

// Ejemplo

A = [1 2 3; 0 4 5; 0 0 6]
B1 = [0 ; 0 ; 0]
B2 = [1 ; 2 ; 3]
B3 = [-1 ; -1 ; -1]
B4 = [1 ; 1 ; 1]
B  = [B1 B2 B3 B4]

X1 = tringularSuperiorAmpliada(A, B)
disp(X1)
// Raíces del polinomio de Chebyshev
function w = rootsCheby(n)
    // Entrada: n = grado del polinomio de Chebyshev
    // Salida: w = vector con las raices del polinomio de Chebyshev
    for i=0:(n-1) do
        w(i+1)=cos((2*i+1)*%pi/(2*n)) // eq (6)
    end
    w = w'
endfunction

// Raíces del polinomio de Chebyshev
function w = rootsCheby_ab(n,a,b)
    // n: grado del polinomio de Chebyshev (cant raíces)
    // a: extremo izquierdo del intervalo
    // b: extremo derecho del intervalo

    //Buscar las raíces forma tradicional
    for i=0:(n-1) do
        w(i+1)=cos((2*i+1)*%pi/(2*n)) // eq (6)
    end
    //Transformar las raíces al intervalo [-1, 1] -> [a,b]
    w = ((b+a) + w*(b-a))/2
    w = w'
endfunction

// Polinomio de Chebyshev
function w = polCheby(x,n)
    // Entrada: n = número natural; x = número real
    // Salida: Polinomio de Chebyshev de grado n evaluado en x

    // Esto con la forma polinómica de la eq (3)
    if n==0 then
        w = 1
    elseif n==1 then
        w = x
    elseif n==2 then
        w = 2*x.^2-1
    else
        w = 2*x.*polCheby(x,n-1)-polCheby(x,n-2)
    end
endfunction

function w = polinomioMonicoChebyshv(x,n)
    // Description of polinomioMonicoChebyshv(x,n)
    //  x: Punto de evaluación
    //  n: Grado del polinomio de Chebyshev
    //  output: Valor del polinomio mónico de Chebyshev de grado n en x

    w = 1 / (2^(n-1)) * polCheby(x,n);
endfunction
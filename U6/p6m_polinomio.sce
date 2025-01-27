function [c, r] = cotasPolinomio(p)
    // Description of cotasPolinomio(p)
    // A partir de los coeficientes del polinomio característico
    // dar la cota no trivial
    // p: coeficientes del polinomio característico
    // c: cota no trivial

    co = coeff(p);

    n = length(co);

    c = - co(n-1);
    r = sum(abs(co(1:n-2)));
endfunction

function [c, r] = cotasPolinomioTras(p)
    // Description of cotasPolinomio(p)
    // A partir de los coeficientes del polinomio característico
    // dar la cota no trivial
    // p: coeficientes del polinomio característico
    // c: cota no trivial

    
    co = coeff(p);
    
    n = length(co);
    
    c = zeros(n-1, 1)
    r = zeros(n-1, 1)

    c(n-1) = co(n-1);
    r = abs(co(1:n-1)) + 1
    
endfunction
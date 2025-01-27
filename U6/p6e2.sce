function [c, r] = cotasPolinomio(p)
    // Description of cotasPolinomio(p)
    // A partir de los coeficientes del polinomio característico
    // dar la cota no trivial
    // p: coeficientes del polinomio característico
    // c: cota no trivial

    co = coeff(p);

    n = size(co,2);

    c = - co(n-1);
    r = sum(abs(co(1:n-2)));
endfunction

function [s, e] = intersección(c1, r1, c2, r2)
    // Description of intersección(input)
    s1 = c1 - r1;
    e1 = c1 + r1;

    s2 = c2 - r2;
    e2 = c2 + r2;

    l1 = size(s1, 2);
    l2 = size(s2, 2);

    i = 1;
    s = [];
    e = [];
    disp(l1, l2, "\n");

    while i <= l1 
        j = 1;
        while j <= l2
            lo = max(s1(i), s2(j));
            hi = min(e1(i), e2(j));

            if lo <= hi
                s = [s, lo];
                e = [e, hi];
            end
            j = j + 1;
        end
        i = i + 1;
    end
endfunction

function [c, r] = cotasPolinomioTras(p)
    // Description of cotasPolinomio(p)
    // A partir de los coeficientes del polinomio característico
    // dar la cota no trivial
    // p: coeficientes del polinomio característico
    // c: cota no trivial

    
    co = coeff(p);
    
    n = length(co);
    
    c = zeros(1, n-1)
    r = zeros(1, n-1)

    c(n-1) = co(n-1);
    r = abs(co(1:n-1)) + 1
    
endfunction

p1 = poly([1 0 0 0 0 0 0 0 8 1], "x", "coeff");
p2 = poly([1 -1 1 -1 1 -4 1], "x", "coeff");

[c1, r1] = cotasPolinomio(p1);
printf("Cota no trivial para p1: Centro: %f Radio: %f\n", c1, r1);
[c1, r1] = cotasPolinomioTras(p1);
printf("Cota del traspuesto para p1\n");disp(c1);disp(r1);
[c2, r2] = cotasPolinomio(p2);
printf("Cota no trivial para p2: Centro: %f Radio: %f\n", c2, r2);
[c2, r2] = cotasPolinomioTras(p2);
printf("Cota del traspuesto para p2\n");disp(c2);disp(r2);

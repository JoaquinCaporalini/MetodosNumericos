//clc // limpia la consola
clear // borra el contenido de la memoria

function r = raices(p)
    c = coeff(p,0);
    b = coeff(p,1);
    a = coeff(p,2);
    if b < 0 then
        r(2) = (2 * c)/(-b + sqrt(b^2-4*a*c));  // eq 14
        r(1) = (-b + sqrt(b^2-4*a*c))/(2*a); // eq 7
    end
    if b > 0 then
        r(1) = (2*c)/(-b - sqrt(b^2-4*a*c));  // eq 15
        r(2) = (-b - sqrt(b^2-4*a*c))/(2*a); // eq 6
    end
    if b == 0
        r(1) = sqrt(- c / a)
        r(2) = - sqrt(- c / a)
    end
endfunction

// eps = 0.0001;
p = poly([-0.0001 10000.0 0.0001],"x","coeff");

e1 = 1e-8;
roots1 = raices(p);
roots2 = roots(p);
r1 = roots1(1);
r2 = roots2(2);
error1 = abs(r1-e1)/e1;
error2 = abs(r2-e1)/e1;
printf("Esperado : %e\n", e1);
printf("misraices (nuestro) : %e (error= %e)\n", r1, error1);
printf("roots (Scilab) : %e (error= %e)\n", r2, error2);

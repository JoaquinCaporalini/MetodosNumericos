clc // limpia la consola
clear // borra el contenido de la memoria

function y = f1(x)
    y = cos(x) .* cosh(x) + 1; // cosh(x) = (e^x + e^-x)/2
endfunction

function y = f2(x)
    y = 2 .* sin(x) - x .^2;
endfunction

function y = f3(x)
    y = %e.^(-x) - x .^4;
endfunction

function y = f4(x)
    y = log10(x) - x + 1;
endfunction

function y = f5(x)
    y = x .^2 ./ 4 - sin(x);
endfunction

ih1 = (-5:0.01:5)';
ih2 = (-5:0.01:5)';
ih3 = (-2:0.01:2)';
ih4 = (0.1:0.01:2)';
ih5 = (-1:0.01:3)';

subplot(2,3,1)
gcf().children.grid = color("grey70")*[1 1]; // grids
gda.x_location="middle"; // grids
plot(ih1,f1(ih1))
title('f1(x) = cos(x) * cosh(x)')
xlabel('x')
ylabel('f1(x) = y')

subplot(2,3,2)
gcf().children.grid = color("grey70")*[1 1]; // grids
gda.x_location="middle";
plot(ih2,f2(ih2))
title('f2(x) = 2 * sin(x) - x^2')
xlabel('x')
ylabel('f2(x) = y')

subplot(2,3,3)
gcf().children.grid = color("grey70")*[1 1]; // grids
gda.x_location="middle";
plot(ih3,f3(ih3))
title('f3(x) = e^-x - x^4')
xlabel('x')
ylabel('f3(x) = y')

subplot(2,3,4)
gcf().children.grid = color("grey70")*[1 1]; // grids
gda.x_location="middle";
plot(ih4,f4(ih4))
title('f4(x) = log(x) - x + 1')
xlabel('x')
ylabel('f4(x) = y')

subplot(2,3,5)
gcf().children.grid = color("grey70")*[1 1]; // grids
gda.x_location="middle";
plot(ih5,f5(ih5))
title('f5(x) = x ^2  / 4 - sin(x)')
xlabel('x')
ylabel('f5(x) = y')

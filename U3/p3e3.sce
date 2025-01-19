clc // limpia la consola
clear // borra el contenido de la memoria
clf // limpia la ventana de gráficos

function y = cos_suc(x, n)
    if n > 0 then
        c = cos(x)
        y = [c, cos_suc(c, n-1)];
    else
        y = [cos(x)];
    end
endfunction

lim = 20

disp(cos_suc(%pi, lim)(lim));
disp(cos_suc(%pi/2, lim)(lim));
disp(cos_suc(%pi/4, lim)(lim));
disp(cos_suc(0, lim)(lim));

gcf().children.grid = color("grey70")*[1 1]; // grids
plot(0:lim, cos_suc(%pi/2, lim));
title('Convergencia del coseno');
xlabel('n');
ylabel('a_n = cos(a_{n-1})');


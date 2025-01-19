function y = f(x, n)
    r = 2^(x - 1);
    if n > 0 then
        y = [r, f(r, n-1)];
    else
        y = [r];
    end
endfunction

lim = 20

disp(f(1.4, lim)(lim));
disp(f(1.2, lim)(lim));
disp(f(0.5, lim)(lim));
disp(f(0, lim)(lim));

gcf().children.grid = color("grey70")*[1 1]; // grids
plot(0:lim, f(-1, lim));
title('Convergencia del coseno');
xlabel('n');
ylabel('a_n = cos(a_{n-1})');
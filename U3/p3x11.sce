function y = c1(x)
    y = sqrt(3 - x.^2);
endfunction

function y = c2(x)
    y = -c1(x);
endfunction

function y = f(x)
    y = 1 ./ x;
endfunction

r = -3:0.001:3
plot(r, f(r), "r", r, c1(r), "b", r, c2(r), "b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
a.data_bounds = [-3, -3; 3, 3];
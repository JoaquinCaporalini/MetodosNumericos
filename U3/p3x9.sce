
r = 1:0.01:2

function d = dx(f, r)
    d = r
    for i = 1:size(r, 2)
        d(i) = numderivative(f,r(i),[],order=1)
    end
endfunction

function y = g1(x)
    y = x - x.^3- 4 .* x.^2 + 10
endfunction

gd1 = dx(g1,r)

function y = g2(x)
    y = sqrt(10./x - 4 .* x)
endfunction

gd2 = dx(g2,r)

function y = g3(x)
    y = sqrt(10 - 4 .* x.^3) ./ 2
endfunction

gd3 = dx(g3,r)

function y = g4(x)
    y = sqrt(10./(4 + x))
endfunction

gd4 = dx(g4,r)

function y = g5(x)
    y = x - (x.^3 + 4.* x.^2 - 10)./(3.*x.^2 + 8.*x)
endfunction

gd5 = dx(g5,r)

subplot(1,5,1)
plot(r,r,"g", r, g1(r), "r", r, gd1,"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

subplot(1,5,2)
plot(r,r,"g", r, g2(r), "r", r, gd2,"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

subplot(1,5,3)
plot(r,r,"g", r, g3(r), "r", r, gd3,"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

subplot(1,5,4)
plot(r,r,"g", r,g4(r),"r", r, gd4,"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

subplot(1,5,5)
plot(r,r,"g", r,g5(r),"r", r, gd5,"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids

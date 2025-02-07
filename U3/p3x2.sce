function y = f11(x)
    y = x;
endfunction

function y = f12(x)
    y = tan(x);
endfunction

function y = f21(x)
    y = x.^3;
endfunction

function y = f22(x)
    y = log(1 + 2 .*x);
endfunction

function y = f31(x)
    y = x;
endfunction

function y = f32(x)
    y = 1.6 + 0.99 .* cos(x);
endfunction

//Ploteando las funciones
r = -5:0.001:5;
subplot(1,3,1)
plot(r,f11(r),"r",r,f12(r),"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
a.data_bounds = [-5, -5; 5, 5];

subplot(1,3,2)
plot(r,f21(r),"r",r,f22(r),"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
a.data_bounds = [-5, -5; 5, 5];

subplot(1,3,3)
plot(r,f31(r),"r",r,f32(r),"b");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
a.data_bounds = [-5, -5; 5, 5];

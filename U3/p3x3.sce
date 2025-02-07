function y = F(x)
    y =sin(x) - 0.5 .* sqrt(x)
endfunction

r = 0:0.001:2;

function y = g(x)
    y = x - F(x)
endfunction

function y = gd(x)
    y = 1 - cos(x) + 1./(4 .* sqrt(x))
endfunction
plot(r,r,"g-",r,F(r),"r", r, g(r), "b", r, gd(r), "y");
a = gca();
gcf().children.grid = color("grey70")*[1 1]; // grids
a.data_bounds = [-1, 0.5; 3, 0.5];

/*
De la gráfica puedo acotar más donde se encuentra la raíz. 
puedo decir que la raíz se encuentra entre [0.2 ; 0.3].

Por otro lado la 
     g'(x) = 1 - cos(x) + 1/4 1/sqrt(x) < 1 

y g'(x) < 1 x \in [0.2; 0.3] (por inspección)

notar que g es continua en (0, \inf)

por corolario podemos garantizar convergencia.
*/
clc // limpia la consola
clear // borra el contenido de la memoria

function r = derivarNumderivative(f, v, n, h)
    // Description  derivarNumderivative(f, n, v)
    // ASUME ORDEN 4
    //  f: función a derivar
    //  v: valor en el que se evalúa la derivada
    //  n: número de derivadas
    //  h: el paso utilizado en las aproximaciones de diferencias finitas
    //  r: valor de la derivada n-ésima de f en v

    deff("y=DF0(x)","y="+f);

    if n==0 then 
        r = DF0(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)", "y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
        end

        deff("y=DFn(x)", "y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        
        r = DFn(v);
    end
endfunction

function r = derivada(f,v,n,h)
    // Description  derivada(f,v,n,h)
    //  f: función a derivar
    //  v: valor en el que se evalúa la derivada
    //  n: número de derivadas
    //  h: el paso utilizado en las aproximaciones de diferencias finitas
    //  r: valor de la derivada n-ésima de f en v
    deff("y=DF0(x)","y="+f);

    if n==0 then 
        r = DF0(v);
    else
        for i=1:(n-1)
            deff("y=DF"+string(i)+"(x)","y=(DF"+string(i-1)+"(x+"+string(h)+")-DF"+string(i-1)+"(x))/"+string(h));
        end

        deff("y=DFn(x)","y=(DF"+string(n-1)+"(x+"+string(h)+")-DF"+string(n-1)+"(x))/"+string(h));
        r = DFn(v);
    end
endfunction
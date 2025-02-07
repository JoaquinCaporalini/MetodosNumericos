function [xn, i] = inversos(c, x0, tol, maxiter)
    i = 0;
    
    while i < maxiter then
        xn = x0 * (2 - c * x0);
        i = i + 1;
        if abs(xn - x0) < tol
            return;
        end
        x0 = xn;
    end
    if i >= maxiter 
        printf("[PELIGRO] El método termino por iteraciones\n");
    end
endfunction

printf("inv 2   = %.5f Esp= %f\n", inversos(2, 0.45 ,1e-6, 1000), 1/2);   // 0.4 - 0.6
printf("inv 9   = %.5f Esp= %f\n", inversos(9, 0.1,1e-6, 1000), 1/9);        // 0.06 - 0.15
printf("inv 45  = %.5f Esp= %f\n", inversos(45, 0.02,1e-6, 1000), 1/45);
printf("inv 678 = %.5f Esp= %f\n", inversos(678, 0.0015,1e-6, 1000), 1/678);
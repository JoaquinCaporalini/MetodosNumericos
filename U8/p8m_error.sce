// Error para los métodos

function err = errorSimpson(a, b, n, val)
    // Description of errorSimpson(a, b, val)
    // a: Valor inicio del intervalo
    // b: Valor final del intervalo
    // val: Valor ya sea de f^(4)(c_n) con c_n en [a, b] 
    //      o el valor exacto de la integral
    // OBS: Si se usa c_n como el máximo obtenemos cota
    h = (b - a) / n;
    err = - ((h^4 * (b - a)) / 180) * val;
endfunction


function err = errorTrapecio(a, b, n, val)
    // Description of errorTrapecio(a, b, val)
    // a: Valor inicio del intervalo
    // b: Valor final del intervalo
    // val: Valor ya sea de f^(2)(c_n) con c_n en [a, b] 
    //      o el valor exacto de la integral
    // OBS: Si se usa c_n como el máximo obtenemos cota
    h = (b - a) / n;
    err = - ((h^4 * (b - a)) / 180) * val;
endfunction
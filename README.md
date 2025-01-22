# MetodosNumericos
Este repositorio va dirigido a la implementación de los métodos y ejercicios de la materia métodos numéricos

El material de teoría y práctica puede encontrarse [aquí](https://github.com/JoaquinCaporalini/MetodosNumericos/tree/main/Material)

## Unidad I: Sucesiones y Series Numéricas

Los ejercicios fueron realizados en el cuadernillo 😊

## Unidad 2: Errores Numéricos
hay veces que lo interesante para un problema es tener una aproximación a la respuesta porque está puede ser complicada de encontrar o directamente imposible. También es interesante ver por cuanto le estamos pifiando de ahi surge la necesidad de entender el error cometido.

### Ejemplos

- Como el presentamos un polinomio escrito de distintas formas puede hacer variar el error ([aquí](U2/p2ej1_Polinomios.sce))
- Error del calculo en las raíces de polinomios de grado 2 ([aquí](U2/p2ej2_Cuadraticos.sce))
- Error del calculo en las derivadas y sus errores ([aquí](U2/p2ej3_Derivadas.sce))

### Ejercicios
- Raíces de polinomios cuadráticos ([aquí](U2/p2e1_raicesPolCuaratico.sce))
- Método de Horner ([aquí](U2/p2e3_horner.sce))
- Cálculo de la n-esima derivadas por cociente incremental y scilab ([aquí](U2/p2e4_derivadas.sce))
- Tylor para una función cualquiera([aquí](U2/p2e5_tylor.sce))
- Tylor para $e^x$ ([aquí](U2/p2e6_tylor_ex.sce))

## Unidad 3: Resolución de Ecuaciones No Lineales

### Métodos
- Método de la bisección ([aquí](U3/p3m_biseccion.sce))
- Método de secante ([aquí](U3/p3m_secante.sce))
- Método de la falsa posición ([aquí](U3/p3m_regulaFalsi.sce))
- Método para punto fijo ([aquí](U3/p3m_ptoFijo.sce))
- Método de Newton ([aquí](U3/p3m_newton.sce))
- Método de Newton multivariable ([aquí](U3/p3m_newtonMultivariado.sce))

### Ejercicios
- Determinar valor de funciones de forma gráfica ([aquí](U3/p3e1.sce))
- Búsqueda de las raíces a traves de métodos ([aquí](U3/p3e2.sce))
- Aplicar reiteradas veces coseno ([aquí](U3/p3e3.sce)) y continua en el cuadernillo 😭
- Vamos con $x_{k+1}=2^{x_k - 1}$ ([aquí](U3/p3e4.sce)) y continua en el cuadernillo 👀
- Encontrar un **C** tal que $x = x + C(x^2+5)$ tiene garantizada la convergencia ([aquí](U3/p3e5.sce)) ¿A qué no adivinas donde están las cuentas?
- Una función 4 funciones $g$ ([aquí](U3/p3e6.sce))
- Solo 5 iteraciones ([aquí](U3/p3e7.sce))
- Aproximadamente Newton en 4 puntos ([aquí](U3/p3e8.sce))
- discos en superficies suaves ([aquí](U3/p3e9.sce))
- Las olas y el viento ([aquí](U3/p3e10.sce))


## Unidad 4: Resolución de Sistemas de Ecuaciones Lineales - Métodos Directos

### Métodos
- Resolver una matriz triangular superior ([Aquí](U4/p4m_triSuperior.sce))
- Resolver una matriz triangular superior (ampliada) ([Aquí](U4/p4m_triSuperiorApliada.sce))
- Resolver una matriz triangular Inferior ([Aquí](U4/p4m_triInferior.sce))
- Resolver una matriz triangular Inferior (ampliada) ([Aquí](U4/p4m_triInferiorAmpliada.sce))
- Método de eliminación Gaussiana ([Aquí](U4/p4m_gausselim.sce))
- Método de eliminación Gaussiana con pivoteo parcial ([Aquí](U4/p4m_gausselimPP.sce))
- Método de eliminación Gaussiana ampliado ([Aquí](U4/p4m_gausselimAmpliado.sce))
- Método de eliminación Gaussiana para obtener el determinante ([Aquí](U4/p4m_gausselimDet.sce))
- Método de eliminación Gaussiana con las matrices P, L y U([Aquí](U4/p4m_gausselimPLU.sce))
- Resolución a traves del PLU([Aquí](U4/p4m_solPLU.sce))
- Método Doolittle ([Aquí](U4/p4m_doolittle.sce))
- Método de  Cholesky ([Aquí](U4/p4m_cholesky.sce))
- Método de factorización QR ([Aquí](U4/p4m_qr.sce))
- Método de Crout ([Aquí](U4/p4m_crout.sce))

### Ejercicios

- Implementar los métodos para resolver sistemas triangular superior ([Aquí](U4/p4m_triSuperior.sce)) e inferior ([Aquí](U4/p4m_triInferior.sce))
- Resolvamos sistemas con eliminación Gaussiana ([Aquí](U4/p4e2.sce))
- Matar varias soluciones de un solo calculo 🐦. Operando con matrices de términos independientes([Aquí](U4/p4e3.sce))
- Implementación del método de calculo del determinate a traves de la eliminación gaussiana([Aquí](U4/p4m_gausselimDet.sce))
- Dándole solución al ejercicio 2b([Aquí](U4/p4e5.sce))
- Una solución muy especifica para un problema muy especifico, las matrices tridiagonales ([Aquí](U4/p4e6.sce))
- Implementación del método de la factorización PLU([Aquí](U4/p4m_gausselimPLU.sce)) y aplicarla a una matriz ([Aquí](U4/p4e7.sce))
- Usar la factorización PLU ([Aquí](U4/p4e8.sce))
- Resolviendo problemas a varios sistemas con la descomposición de gauss PLU ([Aquí](U4/p4e9.sce))
- Resolviendo problemas a varios sistemas con la descomposición de LU de doolittle ([Aquí](U4/p4e10.sce))
- Analizar el código provisto para el método de Cholesky ([Aquí](U4/p4m_cholesky.sce)) y aplicarlo a algunas matrices ([Aquí](U4/p4e11.sce))
- Uso los métodos de Cholesky y QR para resolver ua ecuación ([Aquí](U4/p4e12.sce)) 

## Unidad 5: Resolución de Sistemas de Ecuaciones Lineales - Métodos Iterativos
## Unidad 6: Aproximación de Autovalores
## Unidad 7: Interpolación y Ajuste de Curvas
## Unidad 8: Integración Numérica
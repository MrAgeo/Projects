% averiguar el valo de la posicion de la serie
fibonacci(0,1):- !.
fibonacci(1,1):- !.
fibonacci(N,F) :-   N > 1, N1 is N-1, N2 is N-2,fibonacci(N1,F1), fibonacci(N2,F2), F is F1+F2.
% Imprime el resultado y sale del programa.
imprimirfibonacci(N) :- write('El numero '),write(N),
write(' de la serie de Fibonacci es: '), fibonacci(N,X),write(X), nl.% fail.

% averiguar el factorial de un numero
factorial(0,1) :- !.
factorial(X,Y) :- X1 is X-1, factorial(X1,Y1), Y is X*Y1.
imprimirfactorial(N) :- write('El factorial del numero '),write(N),
write(' es: '), factorial(N,X),write(X),nl,fail.


limitan(mexico,canada).
limitan(canada,usa).
limitan(mexico,usa).

limitrofe(X,Y):- limitan(X,Y).
limitrofe(X,Y):- limitan(Y,X).

translimitrofe(X,Y):- limitrofe(X,Z),
                      limitrofe(Z,Y),
                      dif(X,Y).
                     %not(limitrofe(X,Y)).

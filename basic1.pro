consult('bibmm.pro').
right(X,Y,L):- 	nextto(X,Y,L).

start:- length(Sol,3),                  % There are 3 houses
    member([spanish,_],Sol), 
    member([italian,_],Sol), 
    member([_,red],Sol), 
    member([_,white],Sol), 
    member([norwegian,blue],Sol),       % The Norwegian lives in the Blue house. 
    right([spanish,_],[_,red], Sol),    % The Spanish lives directly to the right of the Red house.    
    Sol= [_, [italian,_],_],            % The Italian lives in house two.
	write(Sol). 
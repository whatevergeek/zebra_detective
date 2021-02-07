left(X,Y,L):- 	nextto(X,Y,L).

start:- length(Sol,3),                                  % There are 3 houses
    member([australian,_,_,_],Sol), 
    member([brazilian,_,_,_],Sol), 
    member([german,_,_,_],Sol), 
    member([_,blue,_,_],Sol), 
    member([_,green,_,_],Sol), 
    member([_,red,_,_],Sol), 
    member([_,_,cats,_],Sol), 
    member([_,_,dogs,basketball],Sol),                  % The person with the Dogs plays Basketball.
    member([_,_,fishes,_],Sol), 
    member([_,_,_,football],Sol), 
    member([_,_,_,soccer],Sol), 
    Sol \= [_,[brazilian,_,_,_],_],                     % The Brazilian does not live in house two.
    left([_,_,fishes,_],[_,_,cats,_], Sol),             % The person with the Fishes lives directly to the left of the person with the Cats.    
    Sol = [[_,_,_,football],_,[_,red,_,_]],             % There is one house between the house of the person who plays Football and the Red house on the right. 
    left([_,green,_,_],[_,_,dogs,basketball], Sol),     % The person with the Dogs lives directly to the right of the Green house.      
    Sol = [_,_,[german,_,_,_]],                         % The German lives in house three.
	maplist(writeln, Sol). 
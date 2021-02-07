left(X,Y,L):- 	nextto(X,Y,L).
somewhere_left(X,Y,L):-  
    nth1(X_Index, L, X),
    nth1(Y_Index, L, Y),  
    X_Index < Y_Index.
somewhere_in_between(X, A, B, L):-
    somewhere_left(A, X, L),
    somewhere_left(X, B, L).

start:- length(Sol,4),                                  % There are 4 boys
    member([daniel,_,thriller,_,_],Sol),                % Daniel likes Thriller movies.
    member([joshua,_,horror,_,_],Sol),                  % Joshua likes Horror movies.
    member([nicholas,_,_,_,_],Sol), 
    member([ryan,_,_,_,_],Sol), 
    member([_,black,_,_,_],Sol),
    member([_,blue,_,_,_],Sol),
    member([_,green,_,_,_],Sol),
    member([_,red,_,_,_],Sol), 
    member([_,_,action,_,_],Sol), 
    member([_,_,comedy,_,_],Sol), 
    member([_,_,_,chips,_],Sol), 
    member([_,_,_,cookies,_],Sol), 
    member([_,_,_,crackers,_],Sol), 
    member([_,_,_,popcorn,_],Sol), 
    member([_,_,_,_,11],Sol), 
    member([_,_,_,_,12],Sol), 
    member([_,_,_,_,13],Sol), 
    member([_,_,_,_,14],Sol), 
    Sol \= [_,[joshua,_,_,_,_],_,_], Sol \= [_,_,[joshua,_,_,_,_],_],                               % Joshua is at one of the ends.
    somewhere_left([_,black,_,_,_],[_,_,_,_,11],Sol),                                               % The boy wearing the Black shirt is somewhere to the left of the youngest boy.
    Sol = [_,_,[_,_,_,_,14],_],                                                                     % The 14-year-old boy is at the third position.
    somewhere_in_between([_,red,_,_,_],[_,_,_,_,13],[_,_,action,_,_],Sol),                          % The boy wearing the Red shirt is somewhere between the 13-year-old boy and the one who likes Action movies, in that order
	Sol \= [_,[_,_,_,cookies,_],_,_], Sol \= [_,_,[_,_,_,cookies,_],_],                             % The boy who is going to eat Cookies is at one of the ends.
    left([_,black,_,_,_],[daniel,_,thriller,_,_],Sol),                                              % The boy wearing the Black shirt is exactly to the left of the one who likes Thriller movies.
    left([_,_,comedy,_,_],[_,_,_,crackers,_],Sol),                                                  % The boy who is going to eat Crackers is exactly to the right of the boy who likes Comedy movies
    somewhere_in_between([_,red,_,_,_],[_,_,_,popcorn,_],[nicholas,_,_,_,_],Sol),                   % The boy wearing the Red shirt is somewhere between the boy who is going to eat Popcorn and Nicholas, in that order.
    Sol \= [_,[daniel,_,thriller,_,_],_,_], Sol \= [_,_,[daniel,_,thriller,_,_],_],                 % At one of the ends is the boy who likes Thriller movies.
    somewhere_in_between([nicholas,_,_,_,_],[joshua,_,horror,_,_],[daniel,_,thriller,_,_], Sol),    % Nicholas is somewhere between Joshua and Daniel, in that order.
    Sol = [[_,green,_,_,_],_,_,_],                                                                  % At the first position is the boy wearing the Green shirt.
    maplist(writeln, Sol). 
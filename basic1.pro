left(X, Y, L) :-
    nextto(X, Y, L).

solve :-
    length(Answer, 3),                         % There are 3 houses
    member([spanish, _], Answer),
    member([italian, _], Answer),
    member([_, red], Answer),
    member([_, white], Answer),
    member([norwegian, blue], Answer),         % The Norwegian lives in the Blue house. 
    left([_, red], [spanish, _], Answer),      % The Spanish lives directly to the right of the Red house.    
    Answer=[_, [italian, _], _],               % The Italian lives in house two.
    write(Answer). 


% ?- solve.
% [[norwegian,blue],[italian,red],[spanish,white]]
% true ;
% false.
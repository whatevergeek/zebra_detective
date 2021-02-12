n_house_in_between(N, X, Y, L) :-
    nth1(X_Index, L, X),
    nth1(Y_Index, L, Y),
    T is X_Index+N+1,
    T=Y_Index.

left(X, Y, L) :-
    nextto(X, Y, L).

somewhere_left(X, Y, L) :-
    nth1(X_Index, L, X),
    nth1(Y_Index, L, Y),
    X_Index<Y_Index.

solve :-
    length(Answer, 4),                                  % There are 4 houses
    member([american, _, _, _], Answer),
    member([british, _, _, _], Answer),
    member([canadian, _, _, _], Answer),
    member([irish, _, _, _], Answer),
    member([_, black, _, _], Answer),
    member([_, blue, _, _], Answer),
    member([_, red, _, _], Answer),
    member([_, white, _, _], Answer),
    member([_, _, butterflies, _], Answer),
    member([_, _, dolphins, _], Answer),
    member([_, _, horses, _], Answer),
    member([_, _, turtles, _], Answer),
    member([_, _, _, bowling], Answer),
    member([_, _, _, handball], Answer),
    member([_, _, _, swimming], Answer),
    member([_, _, _, tennis], Answer), 

    % There are two houses between the person who likes Bowling and the person who likes Swimming.
    Answer\=[_, [_, _, _, bowling], _, _],
    Answer\=[_, _, [_, _, _, bowling], _],
    Answer\=[_, [_, _, _, swimming], _, _],
    Answer\=[_, _, [_, _, _, swimming], _],

    % There is one house between the Irish and the person who likes Handball on the left.
    n_house_in_between(1,
                       [_, _, _, handball],
                       [irish, _, _, _],
                       Answer),

    % The second house is Black.
    Answer=[_, [_, black, _, _], _, _],

    % There is one house between the person who likes Horses and the Red house on the right.
    n_house_in_between(1,
                       [_, _, horses, _],
                       [_, red, _, _],
                       Answer),

    % The American lives directly to the left of the person who likes Turtles.
    left([american, _, _, _],
         [_, _, turtles, _],
         Answer),

    % There are two houses between the person who likes Horses and the person who likes Butterflies on the right.
    n_house_in_between(2,
                       [_, _, horses, _],
                       [_, _, butterflies, _],
                       Answer),

    % The person who likes Bowling lives somewhere to the right of the person who likes Tennis.
    somewhere_left([_, _, _, tennis],
                   [_, _, _, bowling],
                   Answer),

    % There is one house between the person who likes Handball and the White house on the right.
    n_house_in_between(1,
                       [_, _, _, handball],
                       [_, white, _, _],
                       Answer),

    % The British lives in the first house.
    Answer=[[british, _, _, _], _, _, _],
    maplist(writeln, Answer). 


% ?- solve.
% [british,blue,horses,swimming]
% [american,black,dolphins,handball]
% [canadian,red,turtles,tennis]
% [irish,white,butterflies,bowling]
% true ;
% false.
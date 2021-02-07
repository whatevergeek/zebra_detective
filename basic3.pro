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
    length(Sol, 4),                                  % There are 4 houses
    member([american, _, _, _], Sol),
    member([british, _, _, _], Sol),
    member([canadian, _, _, _], Sol),
    member([irish, _, _, _], Sol),
    member([_, black, _, _], Sol),
    member([_, blue, _, _], Sol),
    member([_, red, _, _], Sol),
    member([_, white, _, _], Sol),
    member([_, _, butterflies, _], Sol),
    member([_, _, dolphins, _], Sol),
    member([_, _, horses, _], Sol),
    member([_, _, turtles, _], Sol),
    member([_, _, _, bowling], Sol),
    member([_, _, _, handball], Sol),
    member([_, _, _, swimming], Sol),
    member([_, _, _, tennis], Sol), 

    % There are two houses between the person who likes Bowling and the person who likes Swimming.
    Sol\=[_, [_, _, _, bowling], _, _],
    Sol\=[_, _, [_, _, _, bowling], _],
    Sol\=[_, [_, _, _, swimming], _, _],
    Sol\=[_, _, [_, _, _, swimming], _],

    % There is one house between the Irish and the person who likes Handball on the left.
    n_house_in_between(1,
                       [_, _, _, handball],
                       [irish, _, _, _],
                       Sol),

    % The second house is Black.
    Sol=[_, [_, black, _, _], _, _],

    % There is one house between the person who likes Horses and the Red house on the right.
    n_house_in_between(1,
                       [_, _, horses, _],
                       [_, red, _, _],
                       Sol),

    % The American lives directly to the left of the person who likes Turtles.
    left([american, _, _, _],
         [_, _, turtles, _],
         Sol),

    % There are two houses between the person who likes Horses and the person who likes Butterflies on the right.
    n_house_in_between(2,
                       [_, _, horses, _],
                       [_, _, butterflies, _],
                       Sol),

    % The person who likes Bowling lives somewhere to the right of the person who likes Tennis.
    somewhere_left([_, _, _, tennis],
                   [_, _, _, bowling],
                   Sol),

    % There is one house between the person who likes Handball and the White house on the right.
    n_house_in_between(1,
                       [_, _, _, handball],
                       [_, white, _, _],
                       Sol),

    % The British lives in the first house.
    Sol=[[british, _, _, _], _, _, _],
    maplist(writeln, Sol). 


% ?- solve.
% [british,blue,horses,swimming]
% [american,black,dolphins,handball]
% [canadian,red,turtles,tennis]
% [irish,white,butterflies,bowling]
% true ;
% false.
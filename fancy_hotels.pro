left(X,Y,L):- 	nextto(X,Y,L).
somewhere_left(X,Y,L):-  
    nth1(X_Index, L, X),
    nth1(Y_Index, L, Y),  
    X_Index < Y_Index.
somewhere_in_between(X, A, B, L):-
    somewhere_left(A, X, L),
    somewhere_left(X, B, L).

solve :-
    % Five fancy hotels were built side by side in the same street in different decades. 
    % Which hotel is the oldest?
    length(Sol, 5),
    member([blue, _, _, _, _, _], Sol),
    member([green, _, _, _, _, _], Sol),
    member([purple, _, _, _, _, _], Sol),
    member([red, _, _, _, _, _], Sol),
    member([white, _, _, _, _, _], Sol),
    member([_, mirage, _, _, _, _], Sol),
    member([_, palace, _, _, _, _], Sol),
    member([_, royal, _, _, _, _], Sol),
    member([_, seashore, _, _, _, _], Sol),
    member([_, vortex, _, _, _, _], Sol),
    member([_, _, american, _, _, _], Sol),
    member([_, _, british, _, _, _], Sol),
    member([_, _, french, _, _, _], Sol),
    member([_, _, german, _, _, _], Sol),
    member([_, _, italian, _, _, _], Sol),
    member([_, _, _, calvin, _, _], Sol),
    member([_, _, _, derrick, _, _], Sol),
    member([_, _, _, ian, _, _], Sol),
    member([_, _, _, roger, _, _], Sol),
    member([_, _, _, wesley, _, _], Sol),
    member([_, _, _, _, 100, _], Sol),
    member([_, _, _, _, 150, _], Sol),
    member([_, _, _, _, 200, _], Sol),
    member([_, _, _, _, 250, _], Sol),
    member([_, _, _, _, 300, _], Sol),
    member([_, _, _, _, _, '1910s'], Sol),
    member([_, _, _, _, _, '1920s'], Sol),
    member([_, _, _, _, _, '1930s'], Sol),
    member([_, _, _, _, _, '1940s'], Sol),
    member([_, _, _, _, _, '1950s'], Sol),

    % The biggest hotel is somewhere between the Palace Hotel and the hotel that has 150 rooms, in that order.
    somewhere_in_between(
        [_, _, _, _, 300, _],
        [_, palace, _, _, _, _],
        [_, _, _, _, 150, _],
        Sol),

    maplist(writeln, Sol). 
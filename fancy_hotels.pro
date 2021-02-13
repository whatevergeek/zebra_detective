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
    % member([red, _, _, _, _, _], Sol),
    % member([white, _, _, _, _, _], Sol),
    member([_, mirage, _, _, _, _], Sol),
    member([_, palace, _, _, _, _], Sol),
    % member([_, royal, _, _, _, _], Sol),
    % member([_, seashore, _, _, _, _], Sol),
    member([_, vortex, _, _, _, _], Sol),
    member([_, _, american, _, _, _], Sol),
    member([_, _, british, _, _, _], Sol),
    member([_, _, french, _, _, _], Sol),
    member([_, _, german, _, _, _], Sol),
    % member([_, _, italian, _, _, _], Sol),
    member([_, _, _, calvin, _, _], Sol),
    member([_, _, _, derrick, _, _], Sol),
    member([_, _, _, ian, _, _], Sol),
    % member([_, _, _, roger, _, _], Sol),
    member([_, _, _, wesley, _, _], Sol),
    member([_, _, _, _, 100, _], Sol),
    member([_, _, _, _, 150, _], Sol),
    member([_, _, _, _, 200, _], Sol),
    member([_, _, _, _, 250, _], Sol),
    % member([_, _, _, _, 300, _], Sol),
    member([_, _, _, _, _, '1910s'], Sol),
    member([_, _, _, _, _, '1920s'], Sol),
    member([_, _, _, _, _, '1930s'], Sol),
    member([_, _, _, _, _, '1940s'], Sol),
    % member([_, _, _, _, _, '1950s'], Sol),
    % The biggest hotel is somewhere between the Palace Hotel and the hotel that has 150 rooms, in that order.
    somewhere_in_between(
        [_, _, _, _, 300, _],
        [_, palace, _, _, _, _],
        [_, _, _, _, 150, _],
        Sol),
    % In the second position is the hotel founded in the 30s.
    Sol = [_,[_, _, _, _, _, '1930s'],_,_,_],
    % The White hotel is somewhere to the left of the smallest hotel.
    somewhere_left([white, _, _, _, _, _],[_, _, _, _, 100, _],Sol),  
    % In the middle is the hotel owned by the German.
    Sol = [_,_,[_, _, german, _, _, _],_,_],
    % The hotel owned by the American is somewhere between the hotel that has 250 rooms and the White hotel, in that order.
    % Roger manages the Red hotel.
    member([red, _, _, roger, _, _] ,Sol),
    % The Seashore Hotel has 300 rooms.
    member([_, seashore, _, _, 300, _] ,Sol),
    % The Vortex Hotel is somewhere to the right of the Green hotel.
    % The Italian built his hotel in the 50s.
    member([_, _, italian, _, _, '1950s'] ,Sol),
    % The hotel that has 250 rooms is exactly to the left of the hotel managed by Roger.
    % At the first position is the hotel whose the owner was born in Paris.
    % The Green hotel is somewhere to the left of the hotel that has 200 rooms.
    % Ian works at the first hotel.
    % The Royal Hotel is somewhere between the hotel owned by the French and the Mirage Hotel, in that order.
    % The Italian owns the fourth hotel.
    % The Royal Hotel is White.
    member([white, royal, _, _, _, _] ,Sol),
    % Calvin manages the fourth hotel.
    % The Green hotel is somewhere to the left of the hotel founded right after World War II ended.
    % The White hotel is next to the hotel founded in the 30s.
    % The hotel managed by Calvin is somewhere between the Blue hotel and the hotel managed by Derrick, in that order.
    % At the third position is the hotel founded when The Great Depression started.
    maplist(writeln, Sol). 
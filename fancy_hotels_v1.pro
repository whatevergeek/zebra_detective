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
    member([mirage, _, _, _, _, _] ,Sol),
    member([palace, _, _, _, _, _] ,Sol),
    % The Royal Hotel is White.
    member([royal, white, _, _, _, _] ,Sol),
    % The Seashore Hotel has 300 rooms.
    member([seashore, _, _, _, 300, _] ,Sol),
    member([vortex, _, _, _, _, _] ,Sol),
    member([_, blue, _, _, _, _] ,Sol),
    member([_, green, _, _, _, _] ,Sol),
    member([_, purple, _, _, _, _] ,Sol),
    % Roger manages the Red hotel.
    member([_, red, _, roger, _, _] ,Sol),
    member([_, _, american, _, _, _] ,Sol),
    member([_, _, british, _, _, _] ,Sol),
    member([_, _, french, _, _, _] ,Sol),
    member([_, _, german, _, _, _] ,Sol),
    % The Italian built his hotel in the 50s. 
    member([_, _, italian, _, _, 1950] ,Sol),
    member([_, _, _, calvin, _, _] ,Sol),
    member([_, _, _, derrick, _, _] ,Sol),
    member([_, _, _, ian, _, _] ,Sol),
    member([_, _, _, wesley, _, _] ,Sol),
    member([_, _, _, _, 100, _] ,Sol),
    member([_, _, _, _, 150, _] ,Sol),
    member([_, _, _, _, 200, _] ,Sol),
    member([_, _, _, _, 250, _] ,Sol),
    member([_, _, _, _, _, 1910] ,Sol),
    member([_, _, _, _, _, 1920] ,Sol),
    member([_, _, _, _, _, 1930] ,Sol),
    member([_, _, _, _, _, 1940] ,Sol),
    % The biggest hotel is somewhere between the Palace Hotel and the hotel that has 150 rooms, in that order.
    somewhere_in_between(
        [seashore, _, _, _, 300, _],
        [palace, _, _, _, _, _],
        [_, _, _, _, 150, _],
        Sol),
    % The White hotel is somewhere to the left of the smallest hotel.
    somewhere_left([royal, white, _, _, _, _],[_, _, _, _, 100, _],Sol),    
    % In the middle is the hotel owned by the German. 
    Sol = [_,_,[_, _, german, _, _, _],_,_],
    % The hotel owned by the American is somewhere between the hotel that has 250 rooms and the White hotel, in that order.
    somewhere_in_between(
        [_, _, american, _, _, _],
        [_, _, _, _, 250, _],
        [royal, white, _, _, _, _],
        Sol),
    % The Vortex Hotel is somewhere to the right of the Green hotel.
    somewhere_left([_, green, _, _, _, _],[vortex, _, _, _, _, _],Sol),
    % The hotel that has 250 rooms is exactly to the left of the hotel managed by Roger.  
    left([_, _, _, _, 250, _],[_, red, _, roger, _, _],Sol),
    % At the first position is the hotel whose the owner was born in Paris.
    Sol = [[_, _, french, _, _, _],_,_,_,_],
    % The Green hotel is somewhere to the left of the hotel that has 200 rooms.
    somewhere_left([_, green, _, _, _, _],[_, _, _, _, 200, _],Sol),
    % Ian works at the first hotel.
    Sol = [[_, _, _, ian, _, _],_,_,_,_],
    % The Royal Hotel is somewhere between the hotel owned by the French and the Mirage Hotel, in that order.
    somewhere_in_between([royal, white, _, _, _, _],[_, _, french, _, _, _],[mirage, _, _, _, _, _],Sol),
    % The Italian owns the fourth hotel.
    Sol = [_,_,_,[_, _, italian, _, _, 1950] ,_],
    % Calvin manages the fourth hotel.
    Sol = [_,_,_,[_, _, _, calvin, _, _],_],
    % The Green hotel is somewhere to the left of the hotel founded right after World War II ended.
    somewhere_left([_, green, _, _, _, _],[_, _, _, _, _, 1940],Sol),
    % The White hotel is next to the hotel founded in the 30s.
    nextto([royal, white, _, _, _, _],[_, _, _, _, _, 1930],Sol),
    % The hotel managed by Calvin is somewhere between the Blue hotel and the hotel managed by Derrick, in that order.
    somewhere_in_between(
        [_, _, _, calvin, _, _],
        [_, blue, _, _, _, _],
        [_, _, _, derrick, _, _],
        Sol),
    % At the third position is the hotel founded when The Great Depression started.
    Sol = [_,_,[_, _, _, _, _, 1920],_,_],
    maplist(writeln, Sol). 
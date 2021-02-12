left(X, Y, L) :-
    nextto(X, Y, L).

solve :-
    % There are 3 houses
    length(Answer, 3),
    member([australian, _, _, _], Answer),
    member([brazilian, _, _, _], Answer),
    member([german, _, _, _], Answer),
    member([_, blue, _, _], Answer),
    member([_, green, _, _], Answer),
    member([_, red, _, _], Answer),
    member([_, _, cats, _], Answer),

    % The person with the Dogs plays Basketball.
    member([_, _, dogs, basketball], Answer),
    member([_, _, fishes, _], Answer),
    member([_, _, _, football], Answer),
    member([_, _, _, soccer], Answer),

    % The Brazilian does not live in house two.
    Answer\=[_, [brazilian, _, _, _], _],    

    % The person with the Fishes lives directly to the left of the person with the Cats.    
    left([_, _, fishes, _],
         [_, _, cats, _],
         Answer),

    % There is one house between the house of the person who plays Football and the Red house on the right. 
    Answer=[[_, _, _, football], _, [_, red, _, _]],

    % The person with the Dogs lives directly to the right of the Green house.      
    left([_, green, _, _],
         [_, _, dogs, basketball],
         Answer),

     % The German lives in house three.
    Answer=[_, _, [german, _, _, _]],
    maplist(writeln, Answer). 


% ?- solve.
% [brazilian,blue,fishes,football]
% [australian,green,cats,soccer]
% [german,red,dogs,basketball]
% true ;
% false.
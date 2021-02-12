left(X, Y, L) :-
    nextto(X, Y, L).
somewhere_left(X, Y, L) :-
    nth1(X_Index, L, X),
    nth1(Y_Index, L, Y),
    X_Index<Y_Index.
somewhere_in_between(X, A, B, L) :-
    somewhere_left(A, X, L),
    somewhere_left(X, B, L).

solve :-
    % There are 4 boys
    length(Answer, 4),        

    % Daniel likes Thriller movies.                     
    member([daniel, _, thriller, _, _], Answer),  

    % Joshua likes Horror movies.              
    member([joshua, _, horror, _, _], Answer),
    member([nicholas, _, _, _, _],
           Answer),
    member([ryan, _, _, _, _], Answer),
    member([_, black, _, _, _], Answer),
    member([_, blue, _, _, _], Answer),
    member([_, green, _, _, _], Answer),
    member([_, red, _, _, _], Answer),
    member([_, _, action, _, _], Answer),
    member([_, _, comedy, _, _], Answer),
    member([_, _, _, chips, _], Answer),
    member([_, _, _, cookies, _],
           Answer),
    member([_, _, _, crackers, _],
           Answer),
    member([_, _, _, popcorn, _],
           Answer),
    member([_, _, _, _, 11], Answer),
    member([_, _, _, _, 12], Answer),
    member([_, _, _, _, 13], Answer),
    member([_, _, _, _, 14], Answer),

    % Joshua is at one of the ends.
    Answer\=[_, [joshua, _, _, _, _], _, _],
    Answer\=[_, _, [joshua, _, _, _, _], _],    

    % The boy wearing the Black shirt is somewhere to the left of the youngest boy.
    somewhere_left([_, black, _, _, _],
                   [_, _, _, _, 11],
                   Answer),          
                   
    % The 14-year-old boy is at the third position.                                     
    Answer=[_, _, [_, _, _, _, 14], _],

    % The boy wearing the Red shirt is somewhere between the 13-year-old boy and the one who likes Action movies, in that order
    somewhere_in_between([_, red, _, _, _],
                         [_, _, _, _, 13],
                         
                         [ _,
                           _,
                           action,
                           _,
                           _
                         ],
                         Answer),     
                         
    % The boy who is going to eat Cookies is at one of the ends.                     
    Answer\=[_, [_, _, _, cookies, _], _, _],
    Answer\=[_, _, [_, _, _, cookies, _], _],

    % The boy wearing the Black shirt is exactly to the left of the one who likes Thriller movies.
    left([_, black, _, _, _],
         [daniel, _, thriller, _, _],
         Answer),
    
    % The boy who is going to eat Crackers is exactly to the right of the boy who likes Comedy movies
    left([_, _, comedy, _, _],
         [_, _, _, crackers, _],
         Answer),

    % The boy wearing the Red shirt is somewhere between the boy who is going to eat Popcorn and Nicholas, in that order.
    somewhere_in_between([_, red, _, _, _],
                         
                         [ _,
                           _,
                           _,
                           popcorn,
                           _
                         ],
                         
                         [ nicholas,
                           _,
                           _,
                           _,
                           _
                         ],
                         Answer),
    
    % At one of the ends is the boy who likes Thriller movies.
    Answer\=[_, [daniel, _, thriller, _, _], _, _],
    Answer\=[_, _, [daniel, _, thriller, _, _], _],      

    % Nicholas is somewhere between Joshua and Daniel, in that order.           
    somewhere_in_between(
                         [ nicholas,
                           _,
                           _,
                           _,
                           _
                         ],
                         [joshua, _, horror, _, _],
                         [daniel, _, thriller, _, _],
                         Answer),
    Answer=[[_, green, _, _, _], _, _, _],                                                                  % At the first position is the boy wearing the Green shirt.
    maplist(writeln, Answer). 


% ?- solve.
% [joshua,green,horror,popcorn,13]
% [ryan,red,comedy,chips,12]
% [nicholas,black,action,crackers,14]
% [daniel,blue,thriller,cookies,11]
% true ;
% false.
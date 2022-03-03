%this function m-file, named LeeJ_dotcross, performs dot to product and
%cross product of two vectors. In this function, two vectors are passed in,
%vector1 and vector2, and two results are returned to the program.
%the result will be returned as 1 x 2 matrix,
%value in (1,1) will be dot to product of two vectors
%value in (2,1) will be cross product of two vectors
%dot to product and cross product are operated using built-in functions

function [D, C] = LeeJ_dotcross(V1,V2)

D = dot(V1,V2);
C = cross(V1,V2);

return

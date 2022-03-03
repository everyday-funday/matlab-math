
%this function m-file ,named LeeJ_mult,performs matrix multiplication. 
%Two input matrices are required to run this function
%two matrices that are passed in gets multiplied by using for loop.
%In this function, two input matrices are multiplied. 
%the product of two matrices is returned to the program.

function M = LeeJ_mult(input1, input2)
[rowinput1, colinput1] = size(input1);
[rowinput2, colinput2] = size(input2);
for i = 1:rowinput1
    for j = 1:rowinput2
        M(i,j) = input1(i,:)*input2(:,j);
    end
end

return

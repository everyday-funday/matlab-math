%This file is a function m-file that solves linear equations by Gauss
%elimination with partial pivoting. It passes in matrix A which represents the
%coefficient of variables and column vector b which represents the right
%hand side constants. This function will return and display a row vector that
%corresponds with solution to the variables. If matrix A has a determinant
%of 0, it will just return a zero vector.


function x = gauss_elimination(A,b)

if det(A) == 0
    
    x = zeros(length(b),1)
    
    return
end
  
if cond(A) > 50
    disp('WARNING: The system is ill-conditioned')
    
end

%getting size of row and column of A matrix to operate the gaussian
%elimination.
[rowA,colA]=size(A);


%concatenating matrix A and vector b, creates 4x5 matrix
A_aug = [A b];



%Gaussian elimination with partial pivoting algorithm
%this for loop selects which column to operate the elimination
for col = 1 : colA
    
    % this equation will find which row has the maximum magnitude
     [maxvalue,maxrow] = max(abs(A_aug(col:end,col)));
   
    %pivoting algorithm
    if maxrow ~= 1
        maxrow = maxrow + col - 1;
        %placing pivot row into a temp vector
        temp = A_aug(col,col:colA+1);
        %replacing the pivot row with maxrow
        A_aug(col,col:colA+1)=A_aug(maxrow,col:colA+1);
        %replacing the maxrow with temp vector
        A_aug(maxrow,col:colA+1) = temp;
    end
    
    %this for loop selects which row to be evaluated
    for row = col + 1 : rowA
        
        %calculating the row factor
        factor = A_aug(row,col)/A_aug(col,col);
        %operating gauss elimination equation. Note that target column is
        %not included in the calculation. Since we already know that all
        %the terms below the target terms will be zero, there is no need to
        %calculate the values. 
        A_aug(row,col+1:end) = A_aug(row,col+1:end)- factor*...
                                A_aug(col,col+1:end);
        %we can just define them as zeros
        A_aug(row,col)=0;
    end
end

%Starting back substitution
x(rowA) = A_aug(rowA,rowA+1)/A_aug(rowA,rowA);
%the equation above finds a variable from last row of gauss eliminated matrix

% starting for loop to do back substitution rowA:-1:1 will switch evaluated
% row. After one substitution, this for loop will decrement the variable 'row'
% and the algorithm will now substitue for equation with one more unknow
% variable
for row = rowA-1:-1:1 
	sum = 0;
    
    %This for loop will make the program to select correct column to 
    %operate the back substitution
	for column = row+1:rowA

        %this variable sum will be sum of the coefficient and the variables
        %that are calculated from the previous loop
		sum = sum + A_aug(row,column) * x(column);
    end
    
    %this final equation will store the solution into corresponding row of 
    %x vector. (ex. value of x1 will be stored in x(1) and that is why
    %first for loop stops at 1.
	x(row) = (A_aug(row,rowA+1) - sum)/A_aug(row,row);
end

disp(['vector x is ', num2str(x)])
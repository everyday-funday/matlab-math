% % Joseph Young Lee

% This program demonstrate basic use of matlab in matrix manipulation.
clc
clear

temp1 = 0;

while ~temp1
    
    disp('Please input two matrices A and B that can be multiplied together')
    disp('enter 3x3 matrices.')
    disp('in order to type in the next column, add a space between values')
    disp('in order to type in the next row, add a semicolon')
    disp('exameple format: [a b c; d e f; g h i]')
    
    A = input('enter matrix A: ') %input command to read user input
    B = input('enter matrix B: ')
    
    [rowA, colA] = size(A); % getting seperated size values of row and
    [rowB, colB] = size(B); % columns of both matrices A and B
    
    if colA == rowB
        temp1 = 1;
    else
        disp('the inner matrix demensions do not match, please type in')
        disp('the correct format')
        disp(' ')
    end
end
% temporary variable is defined in order to effectively use while loop
temp1 = 0;


while ~temp1
    disp('enter two 3 term column vectors x and y')
    disp('make sure that matrix demenstion is 3x1')
    disp('(format: [a; b; c])')
    disp(' ')
    
    x = input('column vector x: ') %reading input
    y = input('column vector y: ')
    
    [rowx, colx] = size(x); %Fing row and column sizes for both vectors
    [rowy, coly] = size(y);
    
    
    %Conditional statements to check if input vectors have 3x1 demensions.
    if rowx == 3 && rowy == 3 && colx == 1 && coly == 1
        temp1 = 1;
    else
        disp('invalid format, please input 3x1 demension matrices')
        disp(' ')
    
    end
end
    
AmultB = LeeJ_mult(A,B) %Calling LeeJ_mult function m-file to multiply two matrices

Atrans = A' %creating transpose matrix A using built-in Matlab function


%creating transpose matrix B using for loop.
Btrans = zeros(rowB,colB);
%creating Btrans with zero values with demension of B

for i = 1:rowB
    for j = 1:colB
        Btrans(j,i) = B(i,j); %setting one value into Btrans
    end
end

Btrans %display transposed B

%multiplying two transposed matrices with built-in multiplication
BtmultAt = Btrans*Atrans;  

% Showing Bt * At = (A*B)t
disp('(Bt * At) - (A*B)t is ')
(Btrans * Atrans) - (A*B)'


[xdoty, xcrossy] = LeeJ_dotcross(x,y); %calling LeeJ_dotcross function m-file

%displaying results
xdoty
xcrossy


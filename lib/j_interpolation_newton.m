%This program performs interpolation using Newton's Divided Difference
%Polynomials. There are three inputs, data file name (fid) that will be
%evaluated, target x point, and a convergence criterion. 
function result = j_interpolation_newton(dataname,x_target,error_input)

%reading the file using dlmread function
data = dlmread(dataname);

%separating the datas into variables
x = data(1,:);
y = data(2,:);
rows = length(x)

%lower
x1 = 0;

%upper
x2 = 0;


%This for-loop finds two data points that bounds the target point
for i = 1 : rows
    
    if x_target > x(i) && x_target < x(i+1)
        
        x1 = x(i);
        x2 = x(i+1);
        
        ante = i;
        post = i + 1;
        
    end
end
   
%calculating interpolation value with the equation
ipolate = (y(ante)-y(post))/(x2-x1);

%now creating table with the variables
table= [x1, y(ante), ipolate; x2,y(post), 0];

yestimate = table(1,2) + table(1,3)*(x_target-table(1,1))
        
low = 0;
up = 0;

i = 3;

es = 0;
%setting temporary error value to activate the while loop
error = 1;

    while es < error_input
       
        % if-else statement that checkes over the x-arrays to find next
        % point for interpolation.
        % First it checks if it reached both end of data
        % next it searches for shorter distance.
        if ante == 1 && post == rows
            return
            
        elseif ante == 1
            table(i,1:2) = [x(post + 1), y(post+1)];
            post = post + 1;
            up = up +1;
            
        elseif post == rows
            table(i,1:2) = [x(ante - 1), y(ante-1)];
            ante = ante - 1;
            low = low + 1;
            
        elseif abs(x_target - x(ante-1)) < abs(x_target - x(post+1))
            
            table(i, 1:2) = [x(ante-1), y(ante-1)]
            ante = ante - 1;
            low = low + 1;

        elseif abs(x_target-x(ante-1)) > abs(x_target-x(post+1))
            
            table(i,1:2) = [x(post+1),y(post+1)];
            post = post+1;
            up = up +1;
               
        elseif up > low
            
            table(i,1:2) = [x(ante-1),y(ante-1)]; 
            ante = ante+1;
            low = up+1;
               
        else
            
            table(i,1:2) = [x(post+1),y(post+1)];
            post = post+1;
            up = up +1;

        end
        
        
        
        for j = 3:i + 1
            table(i-(j-2),j)=(table(i-(j-3),j-1)-table(i-(j-2),j-1))/...
                (table(i,1)-table(i-(j-2),1))
        end
        
        %adding error terms in the table
        error = table(1,i+1)
        
        for k = 1:i-1
            error = error * (x_target-table(k,1));
        end
        
        %incermenting i index
        i = i +1;
        
        es = abs(error/(yestimate+error));
        
        %calculating new estimate
        yestimate = yestimate + error
          
        
        %result of interpolation
        result = yestimate;

    end
    
   








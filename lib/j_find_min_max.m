% purpose of this program is to find the extremum of input function using
% either golden-section method or quadratic method. there are total three
% inputs to this function m-file. A string input which represents the
% function will be evaluated and one integer that will decide whether the
% program will compute minimum or maximum (max = 1, min = 2) and second
% input integer will decide which method will be used in the program.
% (golden-section = 1, quadratic = 2). Result will be displayed using disp
% function and it will also return an x value that will be the location of
% either max or min. 

function result = j_find_min_max(strname,maxmin,method)

%using inline function to accept strname as a function
f = inline(strname);

%temporary value for convergence so that while loop will still work.
es = 100;

% if input method integer is 1, perform golden-section method
if method == 1
    
    %perform golden-section method 
    disp('Using golden-section method')
   
    %golden-section method requires upper and lower bounds to evaluate the
    %extremum
    disp('please enter lower and upper bound for this method')
    low = input('lower bound value(Xl)): ');
    up = input('upper bound value(Xu): ');
    
    %input desired convergence criteria
    disp('please enter the cnvergence criteria')
    es_wanted =  input('convergence criteria for x (%): ');
    
    %golden-ratio is used in this method
    Gratio = (sqrt(5)-1)/2;
    
    %calculating x1 and x2
    x1 = low + Gratio*(up-low);
    x2 = up - Gratio*(up-low);
    
    %while the convergence criteria is not met.
    while es > es_wanted
        
        
        %if maxmin = 1, compute maximum
        if maxmin == 1
            
            %these two if-statements work so that the new range of data
            %will always consist of maximum value.
            if f(x2) > f(x1)
                up = x1;
                x1 = x2;
                
                new_x2 = up - Gratio*(up-low);
                
                %calculating convergence
                es = abs((new_x2 - x2)/new_x2) * 100;
                
                x2 = new_x2;
                
            else
                low = x2;
                x2 = x1;
                
                new_x1 = low + Gratio*(up-low);
                
                %calculating convergence
                es = abs((new_x1 - x1)/new_x1)*100;
                
                x1 = new_x1;
            end
            
        %if maxmin = 2, evaluate minimum value    
        else
            %these two if-statements work so that the new range of data
            %will always consist of minimum value.
            if f(x2) < f(x1)
                up = x1;
                x1 = x2;
                
                new_x2 = up - Gratio*(up-low);
                
                %calculating convergence
                es = abs((new_x2 - x2)/new_x2)*100;
                
                x2 = new_x2;
            else
                low = x2;
                x2 = x1;
                
                new_x1 = low + Gratio*(up-low);
                %calculating convergence
                es = abs((new_x1 - x1)/new_x1)*100;
                
                x1 = new_x1;
            end
        end
    end
    
    %displaying the result
    if maxmin == 1
    disp(['Using Golden-section Method, the function ' strname ' has maximum point at x = '...
        num2str(x1) '. and the maximum value is ' num2str(f(x1)) '.'])
    else
    disp(['Using Golden-section Method, the function ' strname ' has  minimum point at x = '...
        num2str(x1) '. and the minimum value is ' num2str(f(x1)) '.'])
    end
    
    %returning a final x value for extremum
    result = x1;

else
   %perform quadratic method
    
   disp('Using Quadratic method')        
   %this method asks for three initial values in order to approcimate
   %the root
   disp('please enter three data values(x)')
   x0 = input('enter x value for i=-2: ');
   x1 = input('enter x value for i=-1: ');
   x2 = input('enter x value for i=0: ');
   
   %input desired convergence criteria
   disp('please enter the cnvergence criteria')
   es_wanted =  input('convergence criteria for x (%): ');
       
   
   %while convergence criteria is not met
   while es > es_wanted
       
       %quadratic method equation of calculating the x3 value
        x3 = (f(x0)*((x1^2)-(x2^2))+f(x1)*((x2^2)-(x0^2))+f(x2)*((x0^2)-(x1^2)))/...
                (2*f(x0)*(x1-x2)+2*f(x1)*(x2-x0)+2*f(x2)*(x0-x1));
       
        %Finding Maximum
         if maxmin == 1
             
             %when finding maximum, next range of data is selected so that
             %the maximum point always stays in the range
            if f(x3) < f(x1)
                x2 = x3;
                
                new_x3 = (f(x0)*((x1^2)-(x2^2))+f(x1)*((x2^2)-(x0^2))+f(x2)*((x0^2)-(x1^2)))/...
                            (2*f(x0)*(x1-x2)+2*f(x1)*(x2-x0)+2*f(x2)*(x0-x1));
                es = abs((new_x3 - x3)/new_x3) * 100;
                
            else
                x0 = x1;
                x1 = x3;
                
                new_x3 = (f(x0)*((x1^2)-(x2^2))+f(x1)*((x2^2)-(x0^2))+f(x2)*((x0^2)-(x1^2)))/...
                            (2*f(x0)*(x1-x2)+2*f(x1)*(x2-x0)+2*f(x2)*(x0-x1));
                        
                es = abs((new_x3 - x3)/new_x3)*100;
                
            end
       %Finding Minimum     
         else
             %when finding minimum, next range of data is selected so that
             %the minimum point always stays in the range
            if f(x3) < f(x1)
                
                x2 = x1;
                x1 = x3;
                new_x3 = (f(x0)*((x1^2)-(x2^2))+f(x1)*((x2^2)-(x0^2))+f(x2)*((x0^2)-(x1^2)))/...
                            (2*f(x0)*(x1-x2)+2*f(x1)*(x2-x0)+2*f(x2)*(x0-x1));
                
                es = abs((new_x3 - x3)/new_x3)*100;
                
            else
                x0 = x3;
                
                new_x3 = (f(x0)*((x1^2)-(x2^2))+f(x1)*((x2^2)-(x0^2))+f(x2)*((x0^2)-(x1^2)))/...
                            (2*f(x0)*(x1-x2)+2*f(x1)*(x2-x0)+2*f(x2)*(x0-x1));
                
                es = abs((new_x3 - x3)/new_x3)*100;
            end
        end     

       
       
   end
   %displaying the result
       if maxmin == 1
           disp(['Using Quadratic Method, the function ' strname ' has maximum point at x = '...
               num2str(x3) '. and the maximum value is ' num2str(f(x3)) '.'])  
       else
           disp(['Using Quadratic Method, the function ' strname ' has minimum point at x = '...
               num2str(x3) '. and the minimum value is ' num2str(f(x3)) '.'])     
       end
       
       result = x3;
end
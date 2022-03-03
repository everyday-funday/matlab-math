%Purpose of this program is to operate five different methods to solve roots of the
%equation. There are two inputs in this program; string data of the
%function and a method number:
%
%   1=bisection,
%   2=false position, 
%   3=secant,
%   4=modified secant, 
%   5=muller's. 
% 
% Depending on the method, it will ask for some
%initial values that corresponds with the choosen method (convergence criteria will
%be asked also). This program will approximate the root and  create a
%methodresult.txt file that show table of iterations.

function answer = solve_roots(strname,method)

f = inline(strname);

%temporary values for convergence. Given so that all the while loop
%conditions will be false
e1 = 100;
e2 = 100;

%temp iteration number
i = 0;

%creating the methodresult.txt file.
fid = fopen('methodresult.txt','w');

%using switch command to operate different methods
switch method
    
    case 1 % bisection method is operated
        
        %program informs which method the user is on.
        disp('Using Bisection method')
        
        %program asks user for upper and lower bound values
        disp('please enter lower and upper bound for this method')
        low = input('lower bound value(Xl)): ');
        up = input('upper bound value(Xu): ');
        
        %program asks user for convergence criteria
        disp('please enter the convergence criteria');
        e_s1 = input('convergence criteria for f(t) (%): ');
        e_s2 = input('convergence criteria for x (%): ');
        
        %this line of code will creat the header for methodresult.txt
        fprintf(fid,'i\txl\txu\tf(xl)\tf(xu)\txmid\tf(xmid)\tef(t)\tex\n');
        
        %while loop allows the program to run until the input convergence
        %criteria is aquired. 
        while (e1 > e_s1 || e2 > e_s2)
            
            
            %calculating the mid point data
            mid = (low + up )/2;
            
            %calculating f values of each low up and mid values
            f_mid = f(mid);
            f_up = f(up);
            f_low = f(low);
            
            %mid value substitution is about to occur to reduce the range
            %of approximated values.
            
            %when the root lies between mid and up
            if (f_mid) * (f_up) <0
                
                low = mid;
            
            %when the root lies between low and mid    
            else
                
                up = mid;
            end
            
            %calculating new mid and f(mid) values to calculate the
            %convergence
            new_mid = (low+up)/2;
            new_f_mid = f(new_mid);
            
            %calculating convergences
            e2 = abs((new_mid-mid)/(new_mid)) * 100;
            e1 = abs(f(new_mid));
            
            %printing a line of data in the methodresult.txt file.
            fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f\n'...
                ,i,low,up,f_low,f_up,mid,f_mid,e1,e2);
            
            %incrementing iteration number
            i = i + 1;
            
        end
        
        %closing the .txt file
        fclose(fid);
        
        %displaying the answer
        disp('methodresult.txt file has been created')
        answer = new_mid;
        

        
        
    case 2 % false position method
        
        disp('Using False-Position method')
        
        %program asks user to put upper and lower bounds for this method
        disp('please enter lower and upper bound for this method')
        low = input('lower bound value(Xl)): ');
        up = input('upper bound value(Xu): ');
        
        %program asks users to put convergence criteria
        disp('please enter the convergence criteria')
        e_s1 = input('convergence criteria for f(t) (%): ');
        e_s2 = input('convergence criteria for x (%): ');
        
        %creating the heading of methodresult.txt for this method
        fprintf(fid,'i\txr\tf(xr)\txl\tf(xl)\txu\tf(xu)\tef(t)\tex\n');
        
        %while loop allows the program to run until the input convergence
        %criteria is aquired. 
        while (e1 > e_s1 || e2 > e_s2)
            
            %approximating root from upper and lower bounds using equation
            %for false position method.
            root = up - f(up) * ((low -up)/(f(low)-f(up)));
            
            %finding values for f for all three values
            f_root = f(root);
            f_up = f(up);
            f_low = f(low);
            
            %root lies between root and up
            if (f_root) * (f_up) <0
                
                low = root;
                
            %root lies between root and low    
            else
                
                up = root;
            end
            %Range of low and up has changed
            
            %calculating new root and f(root) values for convergence
            new_root = up - f(up) * ((low -up)/(f(low)-f(up)));
            new_f_root = f(new_root);
            
            %calculating convergence
            e2 = abs((new_root-root)/(new_root)) * 100;
            e1 = abs(f(new_root));
            
            %printing a line of data in the methodresult.txt file.
            fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f %2.4f\n'...
                ,i,root,f_root,low,f_low,up,f_up,e1,e2);
            
            %iteration number increment
            i = i + 1;
        end
        
        %closing the .txt file
        fclose(fid);
        
        %displaying results
        disp('methodresult.txt file has been created')
        answer = new_root;
        
        
    case 3 % secant method
        
        disp('Using Secant method')
        
        %program asks for user to put x0 and x1 values for secant method
        disp('please enter two starting points')
        x0 = input('starting point x0: ');
        x1 = input('starting point x1: ');
        
        %asking for convergence criteria
        disp('please enter the convergence criteria')
        e_s1 = input('convergence criteria for f(t) (%): ');
        e_s2 = input('convergence criteria for x (%): ');
        
        %printing the heading for the methodresult.txt
        fprintf(fid,'i\tx\tf(x)\tef(x)\tex\n');
        
        %printing two lines of intial data
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f\n',0,x0,f(x0),0,0);
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f\n',1,x1,f(x1),0,0);
        
        i = 2;
        
        %while loop allows the program to run until the input convergence
        %criteria is aquired. 
        while (e1 > e_s1 || e2 > e_s2)
            
            %calculating next x value using equation from secant method
            x2 = x1 - ((f(x1)*(x1-x0))/(f(x1) - f(x0)));
            
            %calculating convergence
            e2 = abs((x2-x1)/(x2)) * 100;
            e1 = abs(f(x2));
            
            %Assigning next values for each variables to operate next
            %iteration.
            x0 = x1;
            x1 = x2;
            
            %printing a line of data in the methodresult.txt file.
            fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f\n',i,x2,f(x2),e1,e2);
            
            %iteration increment
            i = i + 1;
        
        end
        
        %closing the .txt file
        fclose(fid);
        
        %displaying results
        disp('methodresult.txt file has been created')
        answer = x2;
        
        
    case 4 % modified secant method
        

        disp('Using Modified Secant method')
        
        %This method asks the user for starting point and delta value
        disp('please enter a starting point and a value for delta')
        x0 = input('starting point x0: ');
        del = input('delta value: ');
        
        %Again, it asks for convergence criteria
        disp('please enter the convergence criteria');
        e_s1 = input('convergence criteria for f(t) (%): ');
        e_s2 = input('convergence criteria for x (%): ');
        
        %creating header for methodresult.txt file
        fprintf(fid,'i\tx\tf(x)\tef(x)\tex\n');
        
        %writting a line tha consists of intitial values
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f\n',0,x0,f(x0),0,0);
        
        
        %while loop allows the program to run until the input convergence
        %criteria is aquired. 
        while (e1 > e_s1 || e2 > e_s2)
            
            %calculating the next value with modified secant equation
            x1 = x0 - (f(x0)*del*x0)/(f(x0+del*x0)-f(x0));

            %calculating convergence
            e2 = abs((x1-x0)/(x1)) * 100;
            e1 = abs(f(x1));
            
            %replacing x0 with x1, in order to proceed to iterations 
            x0 = x1;
            
            %iteration number increment
            i = i + 1;
            
            %printing a line of data in the methodresult.txt file.
            fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f\n',i,x1,f(x1),e1,e2);
            
        
        end
        
        %closing the .txt file
        fclose(fid);
        
        %displaying the result
        disp('methodresult.txt file has been created')
        answer = x1;
            
        
    case 5 % Muller's method
        
        disp('Using Mullers method')
        
        %this method asks for three initial values in order to approcimate
        %the root
        disp('please enter three data values(x)')
        x0 = input('enter x value for i=-2: ');
        x1 = input('enter x value for i=-1: ');
        x2 = input('enter x value for i=0: ');
        
        %asking convergence criteria
        disp('please enter the convergence criteria');
        e_s1 = input('convergence criteria for f(t) (%): ');
        e_s2 = input('convergence criteria for x (%): ');
        
        %creating header for the .txt file
        fprintf(fid,'i\tdelx\tx\tf(x)\te1\te2\n');
        
        %writting three lines of data that consists of initial data that
        %was typed by the user
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f\n',-2,NaN,x0,f(x0),0,0);
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f\n',-1,NaN,x1,f(x1),0,0);
        fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f\n',0,NaN,x2,f(x2),0,0);
        
        i = 1;
        
        %while loop allows the program to run until the input convergence
        %criteria is aquired. 
        while (e1 > e_s1 || e2 > e_s2)
            
            %calculating a,b,c values to operate muller's method
            a = (((f(x2)-f(x1))/(x2-x1))-((f(x1)-f(x0))/(x1-x0)))/(x2-x0);
            b = a*(x2-x0) + ((f(x2)-f(x0))/(x2-x0));
            c = f(x2);
            
            %calculating both plus and minus vales for the quadratic part
            %of muller's method equation
            delxplus = -((2*c)/(b+sqrt((b^2)-4*a*c)));
            delxminus = -((2*c)/(b-sqrt((b^2)-4*a*c)));
            
            
            % this if statement indicate condition when delxplus will
            % change x3 value closer to the root
            if (abs(x2 - delxplus) < abs(x2 -delxminus))
                
                delx = delxplus;
                x3 = x2 + delx;
             
            % this if statement indicate condition when delxminus will
            % change x3 value closer to the root    
            else
                
                delx = delxminus;
                x3 = x2 + delx;
                
            end
            %x3 is calculated
            
            %calculating convergence
            e2 = abs((x3-x2)/(x3)) * 100;
            e1 = abs(f(x3));
            
            %replacing each corresponding values in order to go on with the
            %iteration
            x0 = x1;
            x1 = x2;
            x2 = x3;
            
            %printing a line of data in the methodresult.txt file.
            fprintf(fid,'%1.0f %2.4f %2.4f %2.4f %2.4f %2.4f\n',i,delx,x3,f(x3),e2,e1);
            
            %iteration increment
            i = i+1;
            
        end
        
        %closing .txt file
        fclose(fid);
        
        %displaying results
        disp('methodresult.txt file has been created')
        answer = x3;

        
end


% Purpose of this program is to calculate average night, dawn, day and dusk
% windspeed for each month. This program gets data from text file and
% computes average using for-loop, while-loop, and if-statements

%% opening files 
clc
clear all

file1 = fopen('2010WeatherData_IA.txt');

%understand this line how it calls the data
w1 = textscan(file1,'%d%d%d%s%d%d%d%d%d%f%d%d%d','headerlines',1, 'delimiter',',');

%reading Sundata_IA.txt file by dlmread function
s = dlmread('Sundata_IA.txt');

%extracting data, time, wind speed from 2010WeatherData_IA.txt file
%They are located in 2nd,3rd,8th columns
%datetimewind
wind= [w1{2} w1{3} w1{8}];


%Eliminating any rows with minutes anything other than 15,35,55
[rows_data,~] = size(wind) ;



new_row=1;

for row =1:rows_data
    mins = mod(wind(row,2),100);
    if (mins == 15)||(mins==35)||(mins==55)
        
        new_wind(new_row,:)=wind(row,:);
        new_row = new_row + 1;
    end
end


data_pt =1 ;
still_today =0;%declaring still_today variable in order to calculate by day by day.
sum_night_day_avg = 0;
sum_dawn_day_avg = 0;
sum_day_day_avg = 0;
sum_dusk_day_avg = 0;

dom = 1;


rowss = size(s,1);

    
    finalmatrix = zeros(12,4);
    
    
for doy = 1:(rowss-1) %compute from doy = 1 to doy = 365

    
    night_total = 0;
    night_pts = 0;
    dawn_total = 0;
    dawn_pts = 0;
    day_total = 0;
    day_pts = 0;
    dusk_total = 0;
    dusk_pts = 0;
    mon_next = 0;

    sun_up = s(doy,2); %get sun_up time (changes depending on iterations)
    sun_down = s(doy,3); %get sun_down time (changes depending on iterations)
    
    today = s(doy,1); %get date of the day YYYYMMDD
    date_str = num2str(today); 
    this_mon = str2num(date_str(5:6)); %finding month (gives 1,2,3,4,5,...,12)
    
        if (today == new_wind(data_pt,1)) %if today's date matches wind(data_pt,1), still_today true.
            still_today =1; 
        end


    %in this while loop, we will compute night, dawn, day, dusk windspeed
    %and data points. It will also compute daily average and store the
    %value into a new matrix.
    
    while (still_today == 1 && data_pt <= size(new_wind,1)) 
        
        %2nd column of wind matrix gives the time when the windspeed is
        %measured
        time = new_wind(data_pt,2);
        
        %evaluating night, after dusk (sun_down+100) before dawn (sun_up - 100)
        if ((time < sun_up -100) || (time >  sun_down + 100))

            night_total = night_total + new_wind(data_pt,3);
            night_pts = night_pts +1;

        %evaluating dawn,
        elseif (time < sun_up + 100)

            dawn_total = dawn_total + new_wind(data_pt,3);
            dawn_pts = dawn_pts + 1;

        %evaluating day, 
        elseif (time < sun_down - 100)
            
            day_total = day_total + new_wind(data_pt,3);
            day_pts = day_pts + 1;

        %evaluating dusk,
        else

            dusk_total = dusk_total + new_wind(data_pt,3);
            dusk_pts = dusk_pts + 1;

        end
        
        %finding the next date of next wind data.
        if (data_pt < size(new_wind,1))
            day_next = new_wind(data_pt+1,1);
            
        else
            %making day_next ~= today true when data point is at the end
            day_next = today + 111; 
        end
        
        
        if(day_next ~= today)

            day_next_str = num2str(day_next);
            
            mon_next = str2num(day_next_str(5:6));
                
            night_day_avg = night_total / night_pts;
            dawn_day_avg = dawn_total / dawn_pts;
            day_day_avg = day_total / day_pts;
            dusk_day_avg = dusk_total / dusk_pts;
            
            %adding all the averages
            sum_night_day_avg = sum_night_day_avg + night_day_avg;
            sum_dawn_day_avg = sum_dawn_day_avg + dawn_day_avg;
            sum_day_day_avg = sum_day_day_avg + day_day_avg;
            sum_dusk_day_avg = sum_dusk_day_avg + dusk_day_avg;

            dom = dom + 1;
                
            still_today = 0;
        end
        

        if mon_next ~= this_mon
            
            %getting monthly average
            night_mon_avg = sum_night_day_avg / dom;
            dawn_mon_avg = sum_dawn_day_avg / dom;
            day_mon_avg = sum_day_day_avg / dom;
            dusk_mon_avg = sum_dusk_day_avg / dom;
            
            
            %sum daily average & store in final matrix

            
            finalmatrix(this_mon,1) = night_mon_avg;
            finalmatrix(this_mon,2) = dawn_mon_avg;
            finalmatrix(this_mon,3) = day_mon_avg;
            finalmatrix(this_mon,4) = dusk_mon_avg;
           
            %sum daily average & store in final matrix
            %eliminate doy matrix'
            
            sum_night_day_avg = 0;
            sum_dawn_day_avg = 0;
            sum_day_day_avg = 0;
            sum_dusk_day_avg = 0;
            
            dom = 1;
            
        end
        
        
        data_pt = data_pt +1;
    
    end
   
    

end
monthvector = 1:12;

disp('montly average of night, dawn, day, dusk, (month, night avg, dawn avg, day avg, dusk avg)')

monthlyaverage = [monthvector' finalmatrix]

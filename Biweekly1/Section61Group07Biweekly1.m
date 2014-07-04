%% Startup

% Authors: John Maloney, Leonard Chan
% Section 74

clear all;
close all;
clc;

%% Question 1
% Calculate Area and Circumference of a circle of radius r
r = 12;
A = pi*r^2
C = 2*pi*r

%% Question 2
% Creating vectors
u = 1:2:19;
v = (2:2:20)';
v_t = transpose(v);

fprintf('Size of first vector: %d\n', length(u));
fprintf('Size of second vector: %d\n', length(v_t));
result1 = u + v_t
fprintf('Product of Vectors: %d\n', u*v); % This is the dot product of the vectors;

%% Question 3
figure(1)
hold on
grid on

nums = 20*rand(100,1);

% Plot
plot(nums)
plot(nums, 'rx')
xlabel('Value')
ylabel('Randomly Generated Number')
title('Random Numbers')

%% Question 4
nums = 50*randn(1,1000);

countGreater = 0;
count50 = 0;
count20to50 = 0;

% Count numbers found that meet qualifications
for i = 1:length(nums)
    if(nums(i) > 50)
        countGreater = countGreater + 1;
    end
    
    if(nums(i) >= 50)
        count50 = count50 + 1;
    elseif(nums(i) >= 20)
        count20to50 = count20to50 + 1;
    end
end

% Calculate Proabilities
fprintf('Probability number > 50: %f\n', countGreater/length(nums));
fprintf('Probability number is >= 50: %f\n', count50/length(nums));
fprintf('Probability number is < 50: %f\n', count20to50/length(nums));

%% Question 5
nums = 500*rand(1,1000);

% Randomly Chosen Number
fprintf('Randum number from array: %f\n', nums(randi(1000)));

countGreater = 0;
countLess = 0;
countEqual = 0;

% Count numbers found that meet qualifications
for i = 1:length(nums)
    if(nums(i) > 150)
        countGreater = countGreater + 1;
    elseif(nums(i) == 150)
        countEqual = countEqual + 1;
    elseif(nums(i) > 120)
        countLess = countLess + 1;
    end
end

% Calculate Probabilities
fprintf('Probability number is > 150: %f\n', countGreater/length(nums));
fprintf('Probability number is >= 150: %f\n', (countGreater+countEqual)/length(nums));
fprintf('Probability number is < 150 and > 120: %f\n', countLess/length(nums));

%% Question 6
nums = 25*randn(100,100);

countA = 0;
countB = 0;
sum = 0;
sum25 = 0;

% Count numbers and get sums
for i = 1:length(nums)
    for j = 1:length(nums(1))
        sum = sum + nums(i,j);
        if(nums(i,j) > 25)
            countA = countA + 1;
            sum25 = sum25 + nums(i,j);
        elseif(nums(i,j) < 15)
            countB = countB + 1;
        end
    end
end

% Get number of elements
dimensions = size(nums);
n = dimensions(1)*dimensions(2);

% Probabilities
fprintf('Probability number in matrix is greater than 25: %f\n', countA/n);
fprintf('Probability number in matrix is less than 15: %f\n', countB/n);

% Means
fprintf('Mean of all numbers: %f\n', sum/n);
fprintf('Mean of numbers > 25: %f\n', sum25/countA);

%% Question 7
nums = 500*rand(100,100);

sum = 0;
sumRange = 0;

countGreater = 0;
countRange = 0;

% Count numbers and get sums
for i = 1:length(nums)
    for j = 1:length(nums(1))
        sum = sum + nums(i,j);
        if(nums(i,j) > 150)  
            countGreater = countGreater + 1;
            if(nums(i,j) < 300)
                countRange = countRange + 1;
                sumRange = sumRange + nums(i,j);
            end
        end
    end
end

% Get number of elements
dimensions = size(nums);
fprintf('Numbers in array: %d\n', dimensions(1)*dimensions(2));

% Probabilities
fprintf('Probability number is > 150: %f\n', countGreater/n);
fprintf('Probability number is > 150 and < 300: %f\n', countRange/n);

fprintf('Sum: %f\n', sum);
fprintf('Mean: %f\n', sum/n);
fprintf('The theoretical mean is 0\n');
fprintf('Sum of numbers > 150 and < 300: %f\n', sumRange);

%% Question 8
m = 1:.5:10;
fprintf('Array is a row vector of size %f\n', length(m));

v = 25*rand(length(m),1);
p = transpose(m).*v

% Mass Plot
figure(2)
grid on

plot(m,p)
title('Momentum vs Mass of Particles with Random Velocity')
xlabel('Mass')
ylabel('Momentum')
legend('Particles', 'location', 'NorthWest')

% Velocity Plot
figure(3)
grid on

plot(v,p, '*')
title('Momentum vs Velocity of Particles of varied masses')
xlabel('Velocity')
ylabel('Momentum')
legend('Particles', 'location', 'NorthWest')


%% Question 9

% extract Chevron datas
% ndata contains all the cells in number form
% text contains all the data in text form
[ndata, text] = xlsread('Chevron.xlsx');

% convert dates from number dates to date strings
% we gather all the data in the first column starting at row 2 since the
% first column contains the dates and the first row in that column just
dates = flipud(text(2:end,1));

% flips list of closing prices in fourth column
closing = flipud(ndata(:,4));

maximum = max(closing);
minimum = min(closing);
range_ = range(closing);
avg = mean(closing);
binsize = ceil(range_/10);

figure(4);

% plot stock prices on same figure
subplot(2,1,1);
plot(datenum(dates), closing);
grid on;
datetick('x');
xlabel('Date');
ylabel('Closing Stock Price ($)');
title('Chevron Stock Price in 2013');

hold on;

% plot histogram on same figure
subplot(2,1,2);
hist(closing, floor(minimum):binsize:ceil(maximum));
grid on;
title('Chevron Stock Price Distribution in 2013');
legend(sprintf('Bin size: $%.0d', binsize));
ylabel('Frequency');
xlabel('Stock Price Range ($)');

fprintf('Min: $%.2f\n', minimum);
fprintf('Max: $%.2f\n', maximum);
fprintf('Range: $%.2f\n', range_);
fprintf('Mean: $%.2f\n', avg);

% same as Chevron analysis but for Blackberry stock
[ndata, text, allData] = xlsread('Blackberry.xlsx');

dates = flipud(text(2:end,1));
closing = flipud(ndata(:,4));

maximum = max(closing);
minimum = min(closing);
range = range(closing);
avg = mean(closing);
binsize = ceil(range/10);

figure(5);

subplot(2,1,1);
plot(datenum(dates), closing);
grid on;
datetick('x');
xlabel('Date');
ylabel('Closing Stock Price ($)');
title('Blackberry Stock Price in 2013');

hold on;

subplot(2,1,2);
hist(closing, floor(minimum):binsize:ceil(maximum));
grid on;
title('Blackberry Stock Price Distribution in 2013');
legend(sprintf('Bin size: $%.0d', binsize));
ylabel('Frequency');
xlabel('Stock Price Range ($)');

fprintf('Min: $%.2f\n', minimum);
fprintf('Max: $%.2f\n', maximum);
fprintf('Range: $%.2f\n', range);
fprintf('Mean: $%.2f\n', avg);



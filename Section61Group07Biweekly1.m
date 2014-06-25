% Authors: John Maloney, Leonard Chan
% Section 74
clear
clc
%% 1 
% Basic Data Generation and Processing 
%% Question 1
r = 12;
A = pi*r^2
C = 2*pi*r

%% Question 2
u = 1:2:19;
v = (2:2:20)';
v_t = transpose(v);
length1 = length(u)
length2 = length(v_t)
result1 = u + v_t
result2 = u*v

%% 2
% Probability and Random (Stochastic) Variables
%% Question 3
hold on
grid on
figure(1)

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
probability1 = countGreater/length(nums)
probability2 = count50/length(nums)
probability3 = count20to50/length(nums)

%% Question 5
nums = 500*rand(1,1000);

% Randomly Chosen Number
num = nums(randi(1000))

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
probability1 = countGreater/length(nums)
probability2 = (countGreater+countEqual)/length(nums)
probability3 = countLess/length(nums)

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
dimensions = size(nums)
n = dimensions(1)*dimensions(2)

% Probabilities
probability1 = countA/n
probability2 = countB/n

% Means
mean = sum/n
mean25 = sum25/countA

%% Question 7
nums = 500*rand(100,100);

sum = 0;
sumRange = 0;
countRange = 0;

% Count numbers and get sums
for i = 1:length(nums)
    for j = 1:length(nums(1))
        sum = sum + nums(i,j);
        if(nums(i,j) > 150 && nums(i,j) < 300)
            countRange = countRange + 1;
            sumRange = sumRange + nums(i,j);
        end
    end
end

% Get number of elements
dimensions = size(nums)
n = dimensions(1)*dimensions(2)

% Probability
probability = countRange/n

sum = sum
mean = sum/n
sumRange = sumRange

%% Question 8
m = 1:.5:10;
size = length(m)
'row'

v = 25*rand(size,1);
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

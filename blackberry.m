clear all;
close all;
clc;

[ndata, text, allData] = xlsread('Blackberry.xlsx');

dates = flipud(datestr(ndata(:,1) + datenum('01-Jan-1904')));
closing = flipud(ndata(:,5));

maximum = max(closing);
minimum = min(closing);
range = range(closing);
avg = mean(closing);
binsize = ceil(range/10);

figure;

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
legend(sprintf('Bin size: %.0d', binsize));
ylabel('Frequency');
xlabel('Stock Price Range ($)');

fprintf('Min: $%.2f\n', minimum);
fprintf('Max: $%.2f\n', maximum);
fprintf('Range: $%.2f\n', range);
fprintf('Mean: $%.2f\n', avg);

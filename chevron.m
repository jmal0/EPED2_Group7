clear all;close all;clc;
format long;


% extract Chevron datas
[ndata, text, allData] = xlsread('Chevron.xlsx');

% convert dates from number dates to date strings
dates = flipud(text(2:end,1));

closing = flipud(ndata(:,4));

maximum = max(closing);
minimum = min(closing);
range_ = range(closing);
avg = mean(closing);
binsize = ceil(range_/10);

figure;

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
legend(sprintf('Bin size: %.0d', binsize));
ylabel('Frequency');
xlabel('Stock Price Range ($)');

fprintf('Min: $%.2f\n', minimum);
fprintf('Max: $%.2f\n', maximum);
fprintf('Range: $%.2f\n', range_);
fprintf('Mean: $%.2f\n', avg);

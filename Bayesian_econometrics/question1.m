% Draw from the truncated distribution
draws = rnormtrunc(1000, 0.5, 2, 0);

% Plot a histogram
hist(draws)

% Part c
% 
'What is the probability the parameter lies inside the interval (0,1)'

mean(draws>0 & draws<1)

% 
'Compute the 0.05 and 0.95 percentiles of the distribution'
qs = quantile(draws, [0.05, 0.95])

% 
'What is the length of the interval?'
qs(2) - qs(1)

% Can I find a shorter 90% interval? 
% Yes
qs2 = quantile(draws,[0, 0.9])
qs2(2) - qs2(1)

% I know this will be a shorter interval as there is more mass around the mean of the untruncated normal distribution (0.5)



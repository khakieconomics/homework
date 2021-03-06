%program which does empirical illustration for chapter 3
%load in the data set. Here use house price data from hprice.txt
load hprice.txt;
n=size(hprice,1);
y=hprice(:,1);
x=hprice(:,2:5);
x=[ones(n,1) x];
k=5;
%%
%Hyperparameters for natural conjugate prior
v0=5;
b0=0*ones(k,1);
b0(2,1)=10;
b0(3,1)=5000;
b0(4,1)=10000;
b0(5,1)=10000;
s02=1/4.0e-8;
capv0=2.4*eye(k);
capv0(2,2)=6e-7;
capv0(3,3)=.15;
capv0(4,4)=.6;
capv0(5,5)=.6;
capv0inv=inv(capv0);

%%
%Call script which carries actually does posterior analysis
ch3post;

% Plot the predictive distribution of ystar
'ystarm' 
ystarm
plot_out = t_den_q2(10000, v1, ystarm, ystarsd^2);

'lower 90%'
quantile(plot_out, 0.05)

'upper 90%'
quantile(plot_out, 0.95)

'mean'
mean(plot_out)
hold on
ksdensity(plot_out/1000);
xt = get(gca,'XTick');
set(gca,'XTickLabel', sprintf('%.0f|',xt))
title({'Kernel density estimate of predictive distribution';'of price of new house, thousands of dollars'})
hold off


%%


%Print out whatever you want
% 'Hyperparameters for informative natural conjugate prior'
% b0
% capv0
% v0
% s02

'Posterior results based on Informative Prior'
b1
% bsd
% probpos
% bhpdi95
% bhpdi99
% hmean
% hsd
% lmarglik
% ystarm
% ystarsd
% ystarcapv


%%
%Hyperparameters for zero beta

b0=0*ones(k,1);


%Call script which carries actually does posterior analysis
ch3post;

'High posterior density intervals'
bhpdi90

'Point estimate standard error'
sqrt(1/hmean)
'HPDI interval for the standard error'
sqrt(1./gaminv([0.05 0.95], v1/2, 2*hmean/v1))

%%
%save the log of marginal likelihood for later use
lmarglik2=lmarglik;


%Print out whatever you want
'Posterior results based on zero beta Prior'
b1

% bsd
% probpos
% bhpdi95
% bhpdi99
% hmean
% hsd
% ystarm
% ystarsd
% ystarcapv


%%
% This section evaluates the model that takes only 


k=3;
x=hprice(:,3:4);
x=[ones(n,1) x];

%Hyperparameters for natural conjugate prior
v0=5;
b0=0*ones(k,1);

s02=1/4.0e-8;
capv0=2.4*eye(k);
%capv0(2,2)=6e-7; # Land size is out
capv0(2,2)=.15;
capv0(3,3)=.6;
capv0inv=inv(capv0);

%Call script which carries actually does posterior analysis
ch3post;

'b1'
b1
postodds=exp(lmarglik-lmarglik2)

%posterior model probabilities for each restricted model
modelprob = postodds./(1+postodds)


'High posterior density intervals'
bhpdi90

'Point estimate standard error'
sqrt(1/hmean)
'HPDI interval for the standard error'
sqrt(1./gaminv([0.05 0.95], v1/2, 2*hmean/v1))

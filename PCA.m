clc
clear all
close all

%Principal Component Analysis

file= xlsread('house_prices_data_training_data.csv');
features= file(:,4:21);
[m, n]= size(features);

for i=1:1:n
    featuresN(:,i)= Normalization(features(:,i));
end

Corr_x = corr(featuresN); %Correlation
x_cov= cov(featuresN); %Covariance
[U S V]=  svd(x_cov);
eigenValues= diag(S);

result= [];
Alpha= [];
for k=1:1:n
    Alpha(k)= 1-(sum(eigenValues(1:k)')/sum(eigenValues));
    if Alpha(k)<=0.001
        result(k)= Alpha(k);
        break;
    end
end

R= U(:,1:k)'*featuresN';
xApprox= U(:,1:k)*R;

error= ((1/n)*sum(sum((featuresN-xApprox').^2)))/sum(sum((featuresN).^2));

%Linear Regression

xApprox= xApprox';

oldTheta0=10;
oldTheta1=5;
oldTheta2=2;
oldTheta3=1;

x0= ones(1,m)';

x1= (xApprox(1:m,4));
x2= (xApprox(1:m,8));
 
% x1= (x1s-mean(x1s))/std(x1s);
% x2= (x2s-mean(x2s))/std(x2s);
y= ((file(1:m,3))-mean(file(1:m,3)))/std(file(1:m,3));


alpha= 0.01;

J= 0;
oldJ= 1;

counter= 1;

x= [x0 x1 x2];

flag=1;
while flag==1

oldJ= (1/(2*m))*sum(((oldTheta0*x(:,1)) + (oldTheta1*x(:,2)) + (oldTheta2*x(:,3)) - y).^2);    
    
theta0= oldTheta0 - ((alpha/m)*sum(((oldTheta0*x(:,1)) + (oldTheta1*x(:,2)) + (oldTheta2*x(:,3)) - y).*x(:,1)));
theta1= oldTheta1 - ((alpha/m)*sum(((oldTheta0*x(:,1)) + (oldTheta1*x(:,2)) + (oldTheta2*x(:,3)) - y).*x(:,2)));
theta2= oldTheta2 - ((alpha/m)*sum(((oldTheta0*x(:,1)) + (oldTheta1*x(:,2)) + (oldTheta2*x(:,3)) - y).*x(:,3)));

J= (1/(2*m))*sum(((theta0*x(:,1)) + (theta1*x(:,2)) + (theta2*x(:,3)) - y).^2);

oldTheta0= theta0;
oldTheta1= theta1;
oldTheta2= theta2;

mse(counter)= J;
counter= counter+1;

q=(oldJ - J)./oldJ;
if q <.000001;
    flag=0;
end
end
axis= [1:length(mse)];
figure(1)
plot(axis, mse);
title('Hypothesis (Two Features in First Degree Order)');
xlabel('Number of Iterations');
ylabel('MSE');
clc
clear all
close all

%Anomaly Detection

file= xlsread('completeData.csv');
trainingData= file(1:17999,4:21);
[pointsNumber, dimensions]= size(trainingData);


for j=1:1:dimensions

h= hist(trainingData(:,j));
test= histogram(trainingData(:,j),'Normalization','cdf');
pmf= h/pointsNumber;
pdf= pmf/10;

mu(j)= mean(trainingData(:,j));
sd(j)= std(trainingData(:,j));

% gaussian= (1/sqrt(2*pi*sd))*exp(-((featuresN-mu).^2)/(2*sd));

featuresN= sort(trainingData(:,j));

y(:,j)= normpdf(featuresN, mu(j), sd(j));
% plot(featuresNN,y)
% title('PDF')

pd= fitdist(featuresN,'Normal');
x(:,j)= cdf(pd,featuresN);
plot(featuresN,x(:,j))
title('CDF')

t(j)= min(x(:,j));

end


x= prod(x,2); %CDF Product of all Features
t= min(x); %Threshold 

testData= file(18000:length(file),4:21);

for j=1:1:dimensions
    
    featuresT= sort(testData(:,j));
    pd = makedist('Normal','mu',mu(j),'sigma',sd(j));
    xTest(:,j)= cdf(pd,featuresT);

end

xTest= prod(xTest,2);
anomaly= 0;

for i=1:1:length(featuresT)
    if xTest(i)<t || xTest(i)> 1-t
        anomaly= anomaly+1; %Anomaly Detected!
    end
end
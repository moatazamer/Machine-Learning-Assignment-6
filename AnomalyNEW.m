clc
clear all
close all

%Anomaly Detection

file= xlsread('house_prices_data_training_data.csv');
trainingData= file(:,4:21);
[pointsNumber, dimensions]= size(trainingData);

for i=1:1:dimensions
    trainingData(:,i)= Normalization(trainingData(:,i));
end

for j=1:1:dimensions

mu(j)= mean(trainingData(:,j));
sd(j)= std(trainingData(:,j));

end

for i=1:1:dimensions
    
y(:,i)= normpdf(trainingData(:,i), mu(i), sd(i));


% pd= fitdist(trainingData(:,i),'Normal');
pd= makedist('Normal','mu',mu(i),'sigma',sd(i));
x(:,i)= cdf(pd,trainingData(:,i));


end

productCDF= prod(x,2);
productPDF= prod(y,2);

anomaly= 0;
t= 0.0000001;
for i=1:1:pointsNumber
    if productCDF(i)<= t || productCDF(i)>= 1-t
        anomaly= anomaly+1;
    end
end

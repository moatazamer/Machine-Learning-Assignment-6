clc
clear all
close all 

%Clustering

file= xlsread('house_prices_data_training_data.csv');
features= file(:,4:21);
[pointsNumber, dimensions]= size(features);


for i=1:1:dimensions
    featuresN(:,i)= Normalization(features(:,i));
end

featuresReduced= PCA_Function(featuresN);

for d=1:1:2
    counter= 1;
    if d==2
        featuresN= featuresReduced;
    end
for k=2:1:20
    disp(k)
    centroid= rand([k dimensions]);
    for i=1:1:pointsNumber
        for j=1:1:dimensions
            for z=1:1:k
%               distance(i,j,z)= dist(centroid(z,j), featuresN(i,j));
                distance(i,j,z)= sqrt((centroid(z,j) - featuresN(i,j))^2);
            end
            [value,index]= min(distance(i,j,:));
            clusters(i,j)= index;
            values(i,j)= value;
        end
    end
    
     x= hist(clusters,k)/pointsNumber;  

    for i=1:1:pointsNumber
        for j=1:1:dimensions
            for z=1:1:k
                if clusters(i,j)==z
                    centroidA(i,j)= centroid(z,j);
                    centroidU(i,j)= x(z,j);
                end
            end
        end
    end

    

    error(counter)= (1/pointsNumber)*sum(sum((featuresN-centroidA).^2));
    errorU(counter)= (1/pointsNumber)*sum(sum((featuresN-centroidU).^2));
    counter= counter+1;
end
clustersNumber= [2:20];
figure(d)
plot(clustersNumber, error);
xlabel('Number of Clusters');
ylabel('Distortion');
end



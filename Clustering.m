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
for k=1:1:10
    disp(k)
%     centroid= rand([k dimensions]);
    randidx= randperm(size(featuresN, 1));
    centroid= featuresN(randidx(1:k), 1:dimensions);
    for t=1:1:10
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
    
     for z=1:1:k
         for j=1:1:dimensions
             positions= find(clusters(:,j)==z);
             for i=1:1:length(positions)
                 dataB(i)= featuresN(positions(i),j);
             end
             temp(z,j)= mean(dataB);
         end
     end
     
            for i=1:1:pointsNumber
                for j=1:1:dimensions
                    for z=1:1:k
                        if clusters(i,j)==z
                            centroid(i,j)= temp(z,j);
                        end
                    end
                end
            end
            mse(t)= (1/pointsNumber)*sum(sum((featuresN-centroid).^2));
    end
    
    error(counter)= min(mse);
    counter= counter+1;
end
clustersNumber= [1:10];
figure(d)
plot(clustersNumber, error);
xlabel('Number of Clusters');
ylabel('Distortion');
[errorValue(d),optimalClusters(d)]= min(error);
end



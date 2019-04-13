function [ xApprox ] = PCA_Function( featuresN )

[m, n]= size(featuresN);

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
xApprox= xApprox';


end


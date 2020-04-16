%% MATLAB Implementation of Otsu Thresholding
close all;
clear all;
clc

image=imread('cameraman.tif'); % Read the Image
image=imresize(image,2);
figure(1),imshow(image),title('Original Image'); %   Original Image
figure(2),imhist(image),title('Histogram of original image'); %  Histogram of original image

n=imhist(image); % Compute the histogram
Sum=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero

for i=1:256
    Prob(i)=n(i)/Sum; %Computing the probability of each intensity level
end

for T=2:255     
    w0=sum(Prob(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(Prob(T+1:256)); %probability of class2 (separated by threshold)
    u0=dot([0:T-1],Prob(1:T))/w0; % class mean u0r
    u1=dot([T:255],Prob(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); %  variance between class
    if sigma>max 
        max=sigma; 
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end

bw=imbinarize(image,threshold/255); % Convert to Binary Image
figure(3),imshow(bw); 


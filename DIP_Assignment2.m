% DIP assignment 2
clear all;
clc
y=imread('Superset_DP.png');
% Conversion to 8 bit grey image
R=y(:,:,1);
G=y(:,:,2);
B=y(:,:,3);
yg=R*.3+G*.5+B*.1;
yg=im2uint8(yg);
figure(1)
imshow(yg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




yc1= imadjust(yg,[0.3,0.7]);%%%%%%increasing contrast
yc2=imadjust(yg,[0.1,0.9]);%%%%%%%decreasing contrast
 
yb1= yg+70;%%%%%% increasing brightness
yb2=yg-70;%%%%%%%decreasing brightness

%%%%%%%%%%%%%%histogram equilization%%%%%%%%%%%%%%%%%%%

yc1_h=histeq(yc1);
yc2_h=histeq(yc2);
yb1_h=histeq(yb1);
yb2_h=histeq(yb1);



figure(2)
subplot(4,2,1)
imshow(yc1),title('High Contrast  Image');
subplot(4,2,2)
imshow(yc2),title('Low contrast Image');
subplot(4,2,3)
imshow(yb1),title('high brightness Image');
subplot(4,2,4)
imshow(yb2),title('low brightness Image');


figure(3) %%%%%%%%%%%%%increased contrast%%%%%%%%
subplot(3,1,1)
histogram(yg),title('original Image');
subplot(3,1,2)
histogram(yc1),title('Edited Image,High Contrast');
subplot(3,1,3)
histogram(yc1_h),title('Equalized Image');

figure(4) %%%%%%%%%%%%%decreased contrast%%%%%%%%
subplot(3,1,1)
histogram(yg),title('original Image');
subplot(3,1,2)
histogram(yc2),title('Edited Image,Low Contrast');
subplot(3,1,3)
histogram(yc2_h),title('Equalized Image');

figure(5) %%%%%%%%%%%%%increased brightness%%%%%%%%
subplot(3,1,1)
histogram(yg),title('original Image');
subplot(3,1,2)
histogram(yb1),title('Edited Image,Increased Brightness');
subplot(3,1,3)
histogram(yb2_h),title('Equilized Image');

figure(6) %%%%%%%%%%%%%decreased brightness%%%%%%%%
subplot(3,1,1)
histogram(yg),title('original Image');
subplot(3,1,2)
histogram(yb2),title('Edited Image,Decreased Brightness');
subplot(3,1,3)
histogram(yb2_h),title('Equalized Image');

figure(7)
subplot(4,2,1)

imshow(yc1_h),title('Equalilzed high Contrast Image')
subplot(4,2,2)

imshow(yc2_h),title('Equalilzed low Contrast Image')




subplot(4,2,3)
imshow(yb1_h),title('Equalilzed high brightness Image')
subplot(4,2,4)

imshow(yb2_h),title('Equalilzed low brightness Image')

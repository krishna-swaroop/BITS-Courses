clear all;
clc
img3=imread('a_image.jpg');
img3=rgb2gray(img3);
img3_rot=imrotate(img3(),45);
figure(1)

subplot(2,1,1)
imshow(img3);
subplot(2,1,2)
imshow(img3_rot);

%sobel Edge Detection
sob1=edge(img3,'Sobel');
sob2=edge(img3_rot,'Sobel');

%robert's Edge Detection
rob1=edge(img3,'Roberts');
rob2=edge(img3_rot,'Roberts');

%prewitt's Edge Detection
pre1=edge(img3,'Prewitt');
pre2=edge(img3_rot,'Prewitt');



figure(2)
subplot(3,2,1)
imshow(sob1),title('Sobel')
subplot(3,2,2)
imshow(sob2),title('Sobel')
subplot(3,2,3)
imshow(rob1),title('Robert')
subplot(3,2,4)
imshow(rob2),title('Robert')
subplot(3,2,5)
imshow(pre1),title('Prewitt')
subplot(3,2,6)
imshow(pre2),title('Prewitt')

%laplacian
lap_mask= [0 -1 0; -1 4 -1; 0 -1 0];
img3_lap=conv2(lap_mask,img3);
img3_rot_lap=conv2(lap_mask,img3_rot);

figure(3)
subplot(2,1,1)
imshow(img3_lap),title('Laplacian')
subplot(2,1,2)
imshow(img3_rot_lap),title('Laplacian')













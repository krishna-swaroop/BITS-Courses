clear all;
clc
img=imread('hubble.tif');
img=rgb2gray(img);
figure(1)
imshow(img);


figure(2)
imhist(img)

%%%%%%%%%%%%%%%%applying filter,part A%%%%%%%%%%%%%%%%%%%%%%%
avg_mask=(1/225)*ones(15,15);
img_avg=conv2(avg_mask,img);
figure(3)
imshow(img_avg/255)



%%%%%%%%%%%%%%part B%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img2=255*ones(100,100);

for i=44:59
    for j=44:59
           img2(i,j)=0;
        
    end
end

figure(4)
imshow(img2)
x=80;                                %filter size
avg_mask2=(1/(x*x))*ones(x);
img2_avg=conv2(avg_mask2,img2);

figure(5)
imshow(img2_avg/255)

%%%%%%%%%%%%%%%%%%%%%%%%%%%3C%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img3=255*ones(100,100);

for i=25:75
    for j=48:52
           img3(i,j)=0;
        
    end
end

for j=25:75
    for i=48:52
           img3(i,j)=0;
        
    end
end

img3_rot=imrotate(img3(),45);
figure(6)

subplot(2,1,1)
imshow(img3);
subplot(2,1,2)
imshow(img3_rot);

%sobles
sob1=edge(img3,'Sobel');
sob2=edge(img3_rot,'Sobel');

%robert
rob1=edge(img3,'Roberts');
rob2=edge(img3_rot,'Roberts');

%prewitts
pre1=edge(img3,'Prewitt');
pre2=edge(img3_rot,'Prewitt');



figure(7)
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

figure(8)
subplot(2,1,1)
imshow(img3_lap),title('Laplacian')
subplot(2,1,2)
imshow(img3_rot_lap),title('Laplacian')








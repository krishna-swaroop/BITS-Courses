
clear all
clc
a=imread('Superset_DP.png');
% a=imresize(a,[720,1280]);
% a=rgb2gray(a);
imshow(a);
%c=im2uint8(a);
% b=double(a);
% figure(1)
% imshow(a);
% c1=mod(floor(b/1),2);
% c2=mod(floor(b/4),2);
% c3=mod(floor(b/8),2);
% c4=mod(floor(b/16),2);
% c5=mod(floor(b/32),2);
% c6=mod(floor(b/64),2);
% c7=mod(floor(b/128),2);
% 
% figure(2)
% imshow(c1);
% figure(3)
% imshow(c2);
% figure(4)
% imshow(c3);
% figure(5)
% imshow(c4);
% figure(6)
% imshow(c5);
% figure(7)
% imshow(c6);
% figure(8)
% imshow(c7);
% 
% %J = imrotate(a,35);
% 
%  
% %% without using imrotate
% a=imread('Superset_DP.png');
% a=imresize(a,[720,1280]);
% a=rgb2gray(a);
% [rowsi,colsi,z]= size(a); 
% 
% angle=5;
% 
% rads=2*pi*angle/360;  
% 
% rowsf=ceil(rowsi*abs(cos(rads))+colsi*abs(sin(rads)));                      
% colsf=ceil(rowsi*abs(sin(rads))+colsi*abs(cos(rads)));                     
% C=uint8(zeros([rowsf colsf 3 ]));
% xo=ceil(rowsi/2);                                                            
% yo=ceil(colsi/2);
% 
% midx=ceil((size(C,1))/2);
% midy=ceil((size(C,2))/2);
% for i=1:size(C,1)
%     for j=1:size(C,2)                                                       
% 
%          x= (i-midx)*cos(rads)+(j-midy)*sin(rads);                                       
%          y= -(i-midx)*sin(rads)+(j-midy)*cos(rads);                             
%          x=round(x)+xo;
%          y=round(y)+yo;
% 
%          if (x>=1 && y>=1 && x<=size(a,1) &&  y<=size(a,2) ) 
%               C(i,j,:)=a(x,y,:);  
%          end
% 
%     end
% end
% 
% 
% 
% 
% 
% 
% figure(9)
% imshow(C);
% %% Resize
% 
% k = imresize(a,.25);
% figure(10)
% imshow(k);
% figure(11)
% L = imtranslate(a,[250, 250]);
% imshow(L);
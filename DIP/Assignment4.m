%%% MATLAB Implementation of JPEG Compression Algorithm

clear all
n = 8;
m = 8 ;
image = imread('cameraman.tif');
figure(2)
imshow(image)
I = imresize(image,[512 512]);
N=8;
M=8;
I_dim = size(I);
I_Trsfrm.block=zeros(N,M);  
Norm_Mat=[16 11 10 16 24 40 51 61      
          12 12 14 19 26 58 60 55
          14 13 16 24 40 57 69 56
          14 17 22 29 51 87 80 62
          18 22 37 56 68 109 103 77
          24 35 55 64 81 104 113 92
          49 64 78 87 103 121 120 101
          72 92 95 98 112 100 103 99];
      save('Initial.txt','I');
      
for A=1:I_dim(1)/N
    for B=1:I_dim(2)/M
        for k=1:N
            for l=1:M
                prod=0;
                for i=1:N
                    for j=1:M
                        prod=prod+double(I(N*(A-1)+i,M*(B-1)+j))*cos(pi*(k-1)*(2*i-1)/(2*N))*cos(pi*(l-1)*(2*j-1)/(2*M));
                    end
                end
                if k==1
                    prod=prod*sqrt(1/N);
                else
                    prod=prod*sqrt(2/N);
                end
                if l==1
                    prod=prod*sqrt(1/M);
                else
                    prod=prod*sqrt(2/M);
                end
                I_Trsfrm(A,B).block(k,l)=prod;
            end
        end
        % Normalizing the DCT Matrix and Quantizing the resulting values.
        I_Trsfrm(A,B).block=round(I_Trsfrm(A,B).block./Norm_Mat);
    end
end
% zig-zag coding of the each 8 X 8 Block.
for A=1:I_dim(1)/N
    for B=1:I_dim(2)/M
        I_zigzag(A,B).block=zeros(1,0);
        freq_sum=2:(N+M);
        counter=1;
        for i=1:length(freq_sum)
            if i<=((length(freq_sum)+1)/2)
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        if I_Trsfrm(A,B).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(I_Trsfrm(A,B).block(x_indices(p),y_indices(p)))),n);
                        else
                            bin_eq=dec2bin(I_Trsfrm(A,B).block(x_indices(p),y_indices(p)),n);
                        end
                        I_zigzag(A,B).block=[I_zigzag(A,B).block,bin_eq(1:m)];
                    end
            else
                counter=counter+1;
                if rem(i,2)~=0
                    x_indices=counter:freq_sum(i)-counter;
                else
                    x_indices=freq_sum(i)-counter:-1:counter;
                end
                    index_len=length(x_indices);
                    y_indices=x_indices(index_len:-1:1); % Creating reverse of the array as "y_indices".
                    for p=1:index_len
                        if I_Trsfrm(A,B).block(x_indices(p),y_indices(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(I_Trsfrm(A,B).block(x_indices(p),y_indices(p)))),n);
                        else
                            bin_eq=dec2bin(I_Trsfrm(A,B).block(x_indices(p),y_indices(p)),n);
                        end
                        I_zigzag(A,B).block=[I_zigzag(A,B).block,bin_eq(1:m)];
                    end
            end
        end
    end
end
% Clearing unused variables from Memory space
clear I_Trsfrm prod; 
clear x_indices y_indices counter;
% Run-Length Encoding the resulting code.
for A=1:I_dim(1)/N
    for B=1:I_dim(2)/M
        
        % Computing the Count values for the corresponding symbols and
        % savin them in "I_run" structure.
        count=0;
        run=zeros(1,0);
        sym=I_zigzag(A,B).block(1);
        j=1;
        block_len=length(I_zigzag(A,B).block);
        for i=1:block_len
            if I_zigzag(A,B).block(i)==sym
                count=count+1;
            else
                run.count(j)=count;
                run.sym(j)=sym;
                j=j+1;
                sym=I_zigzag(A,B).block(i);
                count=1;
            end
            if i==block_len
                run.count(j)=count;
                run.sym(j)=sym;
            end
        end 
        
        % Computing the codelength needed for the count values.
        dim=length(run.count);  % calculates number of symbols being encoded.
        maxvalue=max(run.count);  % finds the maximum count value in the count array of run structure.
        codelength=log2(maxvalue)+1;
        codelength=floor(codelength);
        
        % Encoding the count values along with their symbols.
        I_runcode(A,B).code=zeros(1,0);
        for i=1:dim
            I_runcode(A,B).code=[I_runcode(A,B).code,dec2bin(run.count(i),codelength),run.sym(i)]; %%% Access JPEG Bitstream from this structure
        end
    end
end
figure(1)
imshow(I)
imwrite(I,'result.jpg');
k=imfinfo('result.jpg');  
ib=k.Width*k.Height*k.BitDepth/8;
cb=k.FileSize;
cr=ib/cb;
% Saving the Compressed Code to Disk.
save ('CameramanCompressed.txt','I_runcode');
% Clearing unused variables from Memory Space.
clear I_zigzag run;

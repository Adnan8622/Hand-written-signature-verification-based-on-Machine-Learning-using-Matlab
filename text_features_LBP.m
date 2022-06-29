function feature_vec=text_features_LBP(img);

%%%%%%%%%%%%%%%%%%%%%% Local Binary Pattern %%%%%%%%%%%%%%%%%%%%%


% img=[7 6 5 4 2 4 2
%      1 2 3 4 7 6 3 
%      8 3 6 3 2 1 7 
%      8 7 6 5 4 3 4
%      9 6 3 2 1 5 4
%      8 6 9 5 3 2 1
%      7 5 7 4 5 7 5
%      ];

% img=imread('lena.bmp');
% img=rgb2gray(img);
% img=double(img);
% img = imread('Fig6.38(a).jpg');
% img=imresize(img,[300 300]);
%  img = rgb2gray(img);
img = double(img);
% img=imresize(img,[256 256]);
% [maxx,ii] = max(img(:));%%%%%%%%%Retuern Maximumm value and its indix
% [x,y] = ind2sub(size(img),ii);%%%%%%% extract row and columan of Maximum value


weight=[1 2 4
        128 0 8
        64 32 16];
  
     [r,c] = size(img);
      out = zeros(r,c);
     
     for x=2:r-1
         for y=2:c-1
        sub_img=img(x-1:x+1,y-1:y+1);
        
    for i=2:3-1
        for j=2:3-1
       
                
        if(sub_img(i-1,j-1)>=sub_img(i,j))
        sub_img(i-1,j-1)=1;
        else
            sub_img(i-1,j-1)=0;
        end
        
        if(sub_img(i-1,j)>=sub_img(i,j))
        sub_img(i-1,j)=1;
        else
            sub_img(i-1,j)=0;
        end
        
        if(sub_img(i-1,j+1)>=sub_img(i,j))
        sub_img(i-1,j+1)=1;
        else
            sub_img(i-1,j+1)=0;
        end
        
        if(sub_img(i,j-1)>=sub_img(i,j))
        sub_img(i,j-1)=1;
        else
            sub_img(i,j-1)=0;
        end
        
        if(sub_img(i,j+1)>=sub_img(i,j))
        sub_img(i,j+1)=1;
        else
            sub_img(i,j+1)=0;
        end
        
        if(sub_img(i+1,j-1)>=sub_img(i,j))
        sub_img(i+1,j-1)=1;
        else
            sub_img(i+1,j-1)=0;
        end
        
        if(sub_img(i+1,j)>=sub_img(i,j))
        sub_img(i+1,j)=1;
        else
            sub_img(i+1,j)=0;
        end
        
        if(sub_img(i+1,j+1)>=sub_img(i,j))
        sub_img(i+1,j+1)=1;
        else
            sub_img(i+1,j+1)=0;
        end
        
      
        end
    end %% END of inner for loops
       res=sub_img.*weight;
        SUM=sum(res(:));
       out(x,y)=SUM;      
         
         end
     end %% END of out for loops
     
        
 img=mat2gray(img);
 out=mat2gray(out);
 out=uint8(out.*255);
 
 feature_vec=zeros(1,10);
 
 Max=max(out(:));

     for i=1:r
         for j=1:c
      
             if(out(i,j)>0 && out(i,j)<=25)
             feature_vec(1)=feature_vec(1)+1;
             elseif(out(i,j)>25 && out(i,j)<=50)
             feature_vec(2)=feature_vec(2)+1;
             elseif(out(i,j)>50 && out(i,j)<=75)
             feature_vec(3)=feature_vec(3)+1;
             elseif(out(i,j)>75 && out(i,j)<=100)
             feature_vec(4)=feature_vec(4)+1;
             elseif(out(i,j)>100 && out(i,j)<=125)
             feature_vec(5)=feature_vec(5)+1;
             elseif(out(i,j)>125 && out(i,j)<=150)
             feature_vec(6)=feature_vec(6)+1;
             elseif(out(i,j)>150 && out(i,j)<=175)
             feature_vec(7)=feature_vec(7)+1;
             elseif(out(i,j)>175 && out(i,j)<=200)
             feature_vec(8)=feature_vec(8)+1;
             elseif(out(i,j)>200 && out(i,j)<=225)
             feature_vec(9)=feature_vec(9)+1;
             elseif(out(i,j)>225 && out(i,j)<=255)
             feature_vec(10)=feature_vec(10)+1;
             
             end
         
         end
     end
     
     
  feature= feature_vec;
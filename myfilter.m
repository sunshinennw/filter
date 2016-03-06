function B=myfilter(img,r,method,sigma)
% ˫���˲�,ģ��뾶Ϊr��sigmaΪgaussian��variance��˫���˲��ȿ����˿ռ�λ�õ�Ӱ��Ҳ���������ؼ�Ĳ��죬�ܹ����ߡ�����
%��ȡcopy edge����߽�
% 2015/6/22 nannanwang 

[m,n,z]=size(img);
% ���Ҷ�ͼ���ɫͼ�ֿ�����
I=boundary(img,m,n,z,r);
if strcmp(method,'bilateral')
 if z==1
%% ����spatial weight
[x,y] = meshgrid(-r:r,-r:r);
w1=exp(-(x.^2+y.^2)/(2*sigma(1)^2));     %�Ծ�����Ϊ�Ա�����˹�˲���
%% ���ٽ���
h=waitbar(0,'filter...');
%% Range weitht
for i=r+1:m+r
    for j=r+1:n+r        
        w2=exp(-(I(i-r:i+r,j-r:j+r)-I(i,j)).^2/(2*sigma(2)^2)); %����Χ�͵�ǰ���ػҶȲ�ֵ��Ϊ�Ա����ĸ�˹�˲���
        w=w1.*w2;
        s=I(i-r:i+r,j-r:j+r).*w; %Cross-correlation
        I(i,j)=sum(sum(s))/sum(sum(w));     
    end
    waitbar(i/m);
end
   close(h)
   B=I(r+1:m+r,r+1:n+r);
%% ��ɫͼ��ʱת����lab�ռ�
 else
% Rescale range variance 
 sigma(2) = 100*sigma(2); 
[x,y] = meshgrid(-r:r,-r:r);
w1=exp(-(x.^2+y.^2)/(2*sigma(1)^2));     %�Ծ�����Ϊ�Ա�����˹�˲���
h=waitbar(0,'bilateral wait...');
for i=r+1:m+r
    for j=r+1:n+r        
        lr=(I(i-r:i+r,j-r:j+r,1)-I(i,j,1)).^2;
        lg=(I(i-r:i+r,j-r:j+r,2)-I(i,j,2)).^2;
        lb=(I(i-r:i+r,j-r:j+r,3)-I(i,j,3)).^2;
        w2=exp(-(lr+lb+lg)/(2*sigma(2)^2)); %����Χ�͵�ǰ���ػҶȲ�ֵ��Ϊ�Ա����ĸ�˹�˲���
        w=w1.*w2;
        c=I(i-r:i+r,j-r:j+r,:);
        for k=1:3
        I(i,j,k)=sum(sum(w.*c(:,:,k)))/sum(sum(w));
        end
    end
    waitbar(i/m);
end
close(h)
B=I(r+1:m+r,r+1:n+r,:);
if exist('applycform','file')  
     B = applycform(B,makecform('lab2srgb'));  
  else    
   B = colorspace('RGB<-Lab',B);  
end  
 end
end
%% ��ֵ�˲�
if strcmp(method,'Median')
  if z==1
      h=waitbar(0,'filter...');
      for i=r+1:m+r
          for j=r+1:n+r
              temp=reshape(I(i-r:i+r,j-r:j+r),(2*r+1)^2,1);
              I(i,j)=median(temp); %ȡ�˲���ģ���е���ֵ
          end
          waitbar(i/m);
      end
      close(h)
      B=I(r+1:m+r,r+1:n+r,:);
  else
     h=waitbar(0,'median filter...');
      for i=r+1:m+r
          for j=r+1:n+r
              for k=1:3
              temp=reshape(I(i-r:i+r,j-r:j+r,k),(2*r+1)^2,1);
              I(i,j,k)=median(temp); %ȡ�˲���ģ���е���ֵ
              end
          end
          waitbar(i/m);
      end
      close(h)
      B=I(r+1:m+r,r+1:n+r,:);
%   if exist('applycform','file')  
%      B = applycform(B,makecform('lab2srgb'));  
%   else    
%    B = colorspace('RGB<-Lab',B);  
  end
end
%% ��ֵ�˲�
if strcmp(method,'average') 
%     w=zeros(2*r+1,2*r+1);  % ע�Ͳ��ֿ���ʵ��sharpen filter
%     w(r+1,r+1)=w(r+1,r+1)+2;
%     w=w-1/(2*r+1)^2*ones(2*r+1,2*r+1);
w=[0 1 0; 1 -4 1; 0 1 0];
   % w=ones(2*r+1,2*r+1)/(2*r+1)^2;
        h=waitbar(0,'average filter...');
  if z==1
         for i=r+1:m+r
             for j=r+1:n+r
                 I(i,j)=sum(sum(I(i-r:i+r,j-r:j+r).*w));
             end
             waitbar(i/m)
         end
         close(h)
         B=I(r+1:m+r,r+1:n+r,:);
 else
         for i=r+1:m+r
             for j=r+1:n+r
                 for k=1:3
                 I(i,j,k)=sum(sum(I(i-r:i+r,j-r:j+r,k).*w));
                 end
             end
             waitbar(i/m)
         end
         close(h)
  B=I(r+1:m+r,r+1:n+r,:);  
  end
end
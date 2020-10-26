a=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/police/images (8).jpeg');
I = rgb2gray(a);
I1=brisque(I)
J = imnoise(I,'gaussian',0,0.00050);
K = wiener2(J,[5 5]);
K=imsharpen(K,'Radius',2.5,'Amount',1.5);
I2=brisque(K);
fprintf("%f %f",I1,I2);
%this is for brinsk 

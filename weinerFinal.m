a=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/police/images (8).jpeg');
%imshow(a);
I = rgb2gray(a);
J = imnoise(I,'gaussian',0,0.00050);
K = wiener2(J,[5 5]);
K=imsharpen(K,'Radius',2.5,'Amount',1.5);
%figure; 
%imshow(K);
montage({a, K});

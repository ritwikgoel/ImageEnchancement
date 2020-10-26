a=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/police/images (8).jpeg');
I = rgb2gray(a);
J = imnoise(I,'gaussian',0,0.00050);
K = wiener2(J,[5 5]);
K=imsharpen(K,'Radius',2.5,'Amount',1.5);
err = immse(K, I);
fprintf('\n The mean-squared error is %0.4f\n', err);

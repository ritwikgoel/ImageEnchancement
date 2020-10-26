%a=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/police/images (8).jpeg');
%imshow(a);
function weiner=weinerFinal(a)
I = rgb2gray(a);
J = imnoise(I,'gaussian',0,0.00050);
weiner = wiener2(J,[5 5]);
weiner=imsharpen(weiner,'Radius',2.5,'Amount',1.5);
%figure; 
%imshow(K);
return;

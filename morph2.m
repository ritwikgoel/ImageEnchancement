
%I = imread('https://raw.githubusercontent.com/ritwikgoel/ImageEnchancement/master/DataSet/car/images%20(9).jpeg');
%imshow(I);
function bw=morph2(Im)
se = strel('disk',15);
background = imopen(Im,se);
%imshow(background);
I2 = Im - background;
%imshow(I2)
I3 = imadjust(I2);
%imshow(I3);
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
return;
%imshow(bw);

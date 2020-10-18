I = imread('https://raw.githubusercontent.com/ritwikgoel/ImageEnchancement/master/DataSet/car/images%20(9).jpeg');
imshow(I);
se = strel('disk',15);
background = imopen(I,se);
imshow(background);
I2 = I - background;
imshow(I2)
I3 = imadjust(I2);
imshow(I3);
bw = imbinarize(I3);
bw = bwareaopen(bw,50);
imshow(bw);
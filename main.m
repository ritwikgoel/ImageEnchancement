
image=imread('https://raw.githubusercontent.com/ritwikgoel/ImageEnchancement/master/DataSet/car/images%20(9).jpeg');
imshow(image);
M=uint8(SMQT(double(image),1,8));
imshow(M);
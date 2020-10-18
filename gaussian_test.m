im=double(rgb2gray(imread('https://raw.githubusercontent.com/ritwikgoel/ImageEnchancement/master/DataSet/car/images%20(9).jpeg')));

F_u_v=fft(im);

F_u_v=(fftshift(F_u_v));

figure(1);

temp=log(abs(F_u_v));

%imshow(temp,[]);

%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5 5],3);
%# Filter it
Ig = imfilter(temp,G,'same');
%# Display
iF_u_v=ifft(Ig);

iF_u_v=(ifftshift(iF_u_v));
temp2=log(abs(iF_u_v));

imshow(temp2,[]);

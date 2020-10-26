a=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/police/images (8).jpeg');
I = rgb2gray(a);
J = imnoise(I,'gaussian',0,0.00050);
K = wiener2(J,[5 5]);
K=imsharpen(K,'Radius',2.5,'Amount',1.5);
[peaksnr, snr] = psnr(K, I);
  
fprintf('\n The SNR value is %0.4f\n', snr);
fprintf('\n The Peak-SNR value is %0.4f\n', peaksnr);

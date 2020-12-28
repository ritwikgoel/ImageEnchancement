
image=imread('/home/tangobeer/Desktop/ImageEnchancement/DataSet/car/1.jpeg');

M=uint8(SMQT(double(image),1,8));
montage({image, M});
[peaksnr, snr] = psnr(M, image);
err = immse(M, image);
fprintf('\n The mean-squared error is %0.4f\n', err);

  
fprintf('\n The SNR value is %0.4f\n', snr);
fprintf('\n The Peak-SNR value is %0.4f\n', peaksnr);


    
    
for k = 1:6
  jpgFilename = sprintf('%d.jpeg', k);
  fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/car', jpgFilename);
  if exist(fullFileName, 'file')
    imageData = imread(fullFileName );
    imageDataGrey=rgb2gray(imageData);
  else
    warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
    uiwait(warndlg(warningMessage));
  end
  M=uint8(SMQT(double(imageData),1,8));
  
  montage({imageData, M})
  pause(2);
end

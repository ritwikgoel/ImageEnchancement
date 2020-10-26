for k = 1:6
  jpgFilename = sprintf('%d.jpeg', k);
  fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/car', jpgFilename);
  if exist(fullFileName, 'file')
    imageData = imread(fullFileName );
    imageDatagray=rgb2gray(imageData);
  else
    warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
    uiwait(warndlg(warningMessage));
  end
  M = uint8(SMQT(double(imageData),1,8));
  
  lowlight=lowlight2(imageData);
  weiner=weinerFinal(imageData);
  morph=morphological(imageDatagray);
  montage({imageData, M,lowlight,weiner,morph})
  pause(2);
end



for k = 1:6
  jpgFilename = sprintf('%d.jpeg', k);
  fullFileName = fullfile('/home/tangobeer/Desktop/ImageEnchancement/DataSet/car', jpgFilename);
  if exist(fullFileName, 'file')
    imageData = imread(fullFileName );
  else
    warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
    uiwait(warndlg(warningMessage));
  end
  imshow(imageData);
  pause(2);
end


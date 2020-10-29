counterSMQT=0;
counterlowlight=0;
counterweiner=0;
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
  
  %add quality metrics here
  %immse needs a grey image 
  if (immse(rgb2gray(M),imageDatagray)>immse(rgb2gray(lowlight),imageDatagray)) && (immse(rgb2gray(M),imageDatagray)>immse((weiner),imageDatagray))
      counterSMQT=counterSMQT+1;
  elseif(immse(rgb2gray(lowlight),imageDatagray)>immse(rgb2gray(M),imageDatagray)) && (immse(rgb2gray(lowlight),imageDatagray)>immse((weiner),imageDatagray))   
      counterlowlight=counterlowlight+1;
  elseif(immse((weiner),imageDatagray)>immse(rgb2gray(M),imageDatagray)) && (immse((weiner),imageDatagray)>immse((rgb2gray(lowlight)),imageDatagray)) 
      counterweiner=counterweiner+1;
  end 
  montage({imageData, M,lowlight,weiner,morph})
  pause(1);
end

fprintf('Counter for SMQT (immse): %d \n',counterSMQT);
fprintf('Counter for lowlight(immse): %d \n',counterlowlight);
fprintf('Counter for weiner filter(immse): %d \n',counterweiner);


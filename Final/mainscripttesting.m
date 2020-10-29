imcounterSMQT=0;
imcounterlowlight=0;
imcounterweiner=0;
psnrcounterSMQT=0;
psnrcounterlowlight=0;
psnrcounterweiner=0;
bricounterSMQT=0;
bricounterlowlight=0;

bricounterweiner=0;
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
  if (immse(rgb2gray(M),imageDatagray)<immse(rgb2gray(lowlight),imageDatagray)) && (immse(rgb2gray(M),imageDatagray)<immse((weiner),imageDatagray))
      imcounterSMQT=imcounterSMQT+1;
  elseif(immse(rgb2gray(lowlight),imageDatagray)<immse(rgb2gray(M),imageDatagray)) && (immse(rgb2gray(lowlight),imageDatagray)<immse((weiner),imageDatagray))   
      imcounterlowlight=imcounterlowlight+1;
  elseif(immse((weiner),imageDatagray)<immse(rgb2gray(M),imageDatagray)) && (immse((weiner),imageDatagray)<immse((rgb2gray(lowlight)),imageDatagray)) 
      imcounterweiner=imcounterweiner+1;
  end 
  [smqtpeaksnr, smqtsnr] = psnr(rgb2gray(M), imageDatagray);
  [lowlightpeaksnr, lowlightsnr] = psnr(rgb2gray(lowlight), imageDatagray);
  [weinerpeaksnr, weinersnr] = psnr(weiner, imageDatagray);
%   fprintf('\n The SNR value is %0.4f\n', weinersnr);
%   fprintf('\n The Peak-SNR value is %0.4f\n', weinerpeaksnr);

   %for peak snr 
   if (smqtpeaksnr<lowlightpeaksnr) && (smqtpeaksnr<weinerpeaksnr)
       psnrcounterSMQT=psnrcounterSMQT+1;
   elseif(smqtpeaksnr>lowlightpeaksnr) && (lowlightpeaksnr<weinerpeaksnr)
       psnrcounterlowlight=psnrcounterlowlight+1;
   else
       psnrcounterweiner=psnrcounterweiner+1;
   end
   
   if (brisque((M))<brisque(lowlight)) && (brisque((M))<brisque(weiner))
      bricounterSMQT=bricounterSMQT+1;
  elseif(brisque((lowlight))<brisque(M)) && (brisque((lowlight))<brisque(weiner))   
      bricounterlowlight=bricounterlowlight+1;
   else
      bricounterweiner=bricounterweiner+1;
  end 


  montage({imageData, M,lowlight,weiner,morph})
  title('From L-R original, SMQT,lowlight,weiner');
  pause(2);
end

fprintf('Counter for SMQT (immse): %d \n',imcounterSMQT);
fprintf('Counter for lowlight(immse): %d \n',imcounterlowlight);
fprintf('Counter for weiner filter(immse): %d \n',imcounterweiner);
fprintf('Counter for SMQT (psnr): %d \n',psnrcounterSMQT);
fprintf('Counter for lowlight(psnr): %d \n',psnrcounterlowlight);
fprintf('Counter for weiner filter(psnr): %d \n',psnrcounterweiner);
fprintf('Counter for SMQT (brisque): %d \n',bricounterSMQT);
fprintf('Counter for lowlight(brisque): %d \n',bricounterlowlight);
fprintf('Counter for weiner filter(brisque): %d \n',bricounterweiner);
%psnr and snr seem to be the same 



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
%   M = uint8(SMQT(double(imageData),1,8));
%   lowlight=lowlight2(M);
%   figure; imshow(lowlight);
    if (psnrcounterSMQT<= psnrcounterweiner) && (psnrcounterSMQT<=psnrcounterlowlight)
        %SMQT lowest
        weiner=weinerFinal(imageData);
        lowlight=lowlight2(weiner);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to PSNR (weiner->lowlight)')
       
    elseif (psnrcounterSMQT>= psnrcounterweiner) && (psnrcounterweiner<=psnrcounterlowlight)
        %weiner lowest lowlight and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        lowlight=lowlight2(M);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to PSNR (SMQT->lowlight)')
        
    elseif (psnrcounterlowlight<=psnrcounterweiner) && (psnrcounterSMQT>=psnrcounterlowlight)
        %lowlight lowest smqt and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        weiner=weinerFinal(M);
        montage({imageData,weiner})
        title('Hybrid of best 2 algorithm with respect to PSNR (SMQT->weiner)')
    end
    %montage({imageData,finalimage}) 
    pause(1);
        
end

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
%   M = uint8(SMQT(double(imageData),1,8));
%   lowlight=lowlight2(M);
%   figure; imshow(lowlight);
    if (bricounterSMQT<= bricounterweiner) && (bricounterSMQT<=bricounterlowlight)
        %SMQT lowest
        weiner=weinerFinal(imageData);
        lowlight=lowlight2(weiner);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to Brisk (weiner->lowlight)')
       
    elseif (bricounterSMQT>= bricounterweiner) && (bricounterweiner<=bricounterlowlight)
        %weiner lowest lowlight and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        lowlight=lowlight2(M);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to Brisk (SMQT->lowlight)')
        
    elseif (bricounterlowlight<=bricounterweiner) && (bricounterSMQT>=bricounterlowlight)
        %lowlight lowest smqt and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        weiner=weinerFinal(M);
        montage({imageData,weiner})
        title('Hybrid of best 2 algorithm with respect to Brisk (SMQT->weiner)')
    end
    %montage({imageData,finalimage}) 
    pause(1);
        
end


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
%   M = uint8(SMQT(double(imageData),1,8));
%   lowlight=lowlight2(M);
%   figure; imshow(lowlight);
    if (imcounterSMQT<= imcounterweiner) && (imcounterSMQT<=imcounterlowlight)
        %SMQT lowest
        weiner=weinerFinal(imageData);
        lowlight=lowlight2(weiner);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to IMMSE (weiner->lowlight)');
       
    elseif (imcounterSMQT>= imcounterweiner) && (imcounterweiner<=imcounterlowlight)
        %weiner lowest lowlight and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        lowlight=lowlight2(M);
        montage({imageData,lowlight})
        title('Hybrid of best 2 algorithm with respect to IMMSE (SMQT->lowlight)')
        
    elseif (imcounterlowlight<=imcounterweiner) && (imcounterSMQT>=imcounterlowlight)
        %lowlight lowest smqt and weiner 
        M = uint8(SMQT(double(imageData),1,8));
        weiner=weinerFinal(M);
        montage({imageData,weiner})
        title('Hybrid of best 2 algorithm with respect to IMMSE (SMQT->weiner)')
        
    end
    %montage({imageData,finalimage}) 
    pause(1);
        
end




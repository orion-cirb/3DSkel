function [mask_process,mask] = ProcessingMask(mask)
%PROCESSINGMASK Process mask before skeletonize it
%   Apply several filters to the mask :
%   - Convert in 8-bit
%   - Median 3D filter : remove single points
%   - Fill holes
%   - Gaussian 3D filter : smooth the edges
%   - Reconvert to mask (Otsu Method for automatic threshold)
%   - Fill holes
%
%[mask_process] = ProcessingMask(mask)
%
%Input :
%   - mask (type [], char, logical or uint8) : mask to process
%Output :
%   - mask_process (type logical)
%
%Need to instal MIJI for MATLAB/ImageJ communication
%Part of the package MIJ : http://bigwww.epfl.ch/sage/soft/mij/

%assignin('base', 'mask', mask)



%% Start MIJI (and ImageJ)
inter = ij.macro.Interpreter;
inter.batchMode = true;
if ismac
    MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
else
    MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
end


%% Load the mask
disp('Copying mask in ImageJ...');
MIJ.createImage(uint8(mask).*255);


%% Filtering
disp('Filtering running...')
MIJ.run('8-bit');
%MIJ.run('Median...', 'radius=1 stack');
MIJ.run('Invert LUT');
if length(size(mask))>2
    MIJ.run('Fill Holes', 'stack');
end
MIJ.run('Invert LUT');
MIJ.run('Gaussian Blur 3D...', 'x=1 y=1 z=1');
MIJ.run('Convert to Mask', 'method=Otsu background=Default calculate black');
MIJ.run('Invert LUT');
if length(size(mask))>2
    MIJ.run('Fill Holes', 'stack');
end
MIJ.run('Invert LUT');
disp('Copying mask in Matlab...');
mask_process= logical(MIJ.getCurrentImage());   %Add the mask in the Matlab Workspace

MIJ.run('Close');
macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end
MIJ.exit();

end


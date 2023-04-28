function [mask] = CreateMask(parameters)
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



% %% Start MIJI (and ImageJ)
% inter = ij.macro.Interpreter;
% inter.batchMode = true;
% if ismac
%     MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
% else
%     MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
% end


% %% Load the mask
% disp('Copying mask in ImageJ...');
% MIJ.createImage(image);


%% Filtering and Thresholding
disp('Creating Binary Mask...')
ij.IJ.run('Properties...', ['unit=um pixel_width=',num2str(parameters.voxelwidth.X),...
                            ' pixel_height=',num2str(parameters.voxelwidth.Y),...
                            ' voxel_depth=',num2str(parameters.voxelwidth.Z)]);
% MIJ.run('Resample', ['factor=',num2str(parameters.resizestack),...
%                     ' factor=',num2str(parameters.resizestack),...
%                     ' factor=1']);
MIJ.run('Size...', ['width=',num2str(parameters.size.X./parameters.resizestack),...
                   ' height=',num2str(parameters.size.Y./parameters.resizestack),...
                   ' depth=',num2str(parameters.size.Z),...
                   ' constrain average interpolation=Bicubic']);                        
MIJ.run('Median...', 'radius=2 stack');
MIJ.run('Gaussian Blur 3D...', 'x=1 y=1 z=1');
%MIJ.run('Duplicate...', 'duplicate');
%MIJ.run('Difference of Gaussians', '  sigma1=12 sigma2=3 scaled enhance stack');
%imageCalculator('Multiply create stack', "Ctrl-1-3-crop.tif","Ctrl-1-3-crop-1.tif");
macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/macro/threshold.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\macro\threshold.ijm']);
end
%MIJ.run('Threshold...', 'Triangle dark stack');
%MIJ.run('Convert to Mask', 'method=Triangle background=Dark calculate black');
MIJ.run('8-bit');
median_factor=num2str(ceil(0.65*8./parameters.voxelwidth.resizestackX));
disp(median_factor);
MIJ.run('Median...', ['radius=',median_factor,' stack']);
nb_iteration= num2str(ceil(0.65*5./parameters.voxelwidth.resizestackX));
MIJ.run('Options...', ['iterations=',nb_iteration,' count=1 pad do=Open stack']);
% run('Threshold...');
% MIJ.waitForUser('aaaa');
% GetThreshold(lower,upper); passer des variables dans matlab
% SetResult(lower,upper);
MIJ.run('Invert LUT');
%if length(size(image))>2
MIJ.run('Fill Holes', 'stack');
%end
MIJ.run('Invert LUT');
disp('Copying mask in Matlab...');
mask= logical(MIJ.getCurrentImage());   %Add the mask in the Matlab Workspace

MIJ.run('Close');
MIJ.run('Close');
MIJ.run('Close');
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end
MIJ.exit();

end


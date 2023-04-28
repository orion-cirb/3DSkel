function [resize_mask] = ResizeMask(mask,parameters)
%%Create skeleton from a binary mask with Fiji (ImageJ)
%
%CreateSkeleton uses the plugin Skeletonize 2D/3D (ImageJ) to create the skeleton
%
%[skel, mask, mask_process] = CreateSkeleton(mask, mask_process)
%
%Input : 
%   - mask (type [], char, logical or uint8) : mask to convert in skeleton
%Output : 
%   - skel (type binary image) : skeleton
%
%Need to instal MIJI for MATLAB/ImageJ communication
%Part of the package MIJ : http://bigwww.epfl.ch/sage/soft/mij/
%clc;


%% Start MIJI (and ImageJ)
%inter.batchMode = true;
inter = ij.macro.Interpreter;
inter.batchMode = true;
if ismac
    MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
else
    MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
end


%% Load the mask
disp('Copying filtered mask in ImageJ...');
MIJ.createImage(uint8(mask).*255);

%% Resize Mask
disp('Resizing mask in ImageJ...');
sizeX=size(mask,1);
sizeY=size(mask,2);
sizeZ=size(mask,3);
fprintf('handles.parameters.size.X: %1d\n',sizeX);
fprintf('handles.parameters.size.Y: %1d\n',sizeY);
fprintf('handles.parameters.size.Z: %1d\n',sizeZ);
fprintf('handles.parameters.resizemask: %1d\n',parameters.resizemask);
ij.IJ.run('Properties...', ['unit=um pixel_width=',num2str(parameters.voxelwidth.resizestackX),...
                            ' pixel_height=',num2str(parameters.voxelwidth.resizestackY),...
                            ' voxel_depth=',num2str(parameters.voxelwidth.Z)]);
MIJ.run('Size...', ['width=',num2str(sizeX./parameters.resizemask),...
                   ' height=',num2str(sizeY./parameters.resizemask),...
                   ' depth=',num2str(sizeZ),...
                   ' constrain interpolation=None']);      
MIJ.run('Convert to Mask', 'method=Triangle background=Dark calculate black');
MIJ.run('8-bit');
disp('Copying resized mask in Matlab...');
resize_mask= logical(MIJ.getCurrentImage());   %Add the skeleton in the Matlab Workspace
MIJ.run('Close');
macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end
MIJ.closeAllWindows;
MIJ.exit();

end


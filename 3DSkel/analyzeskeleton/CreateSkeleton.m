function [skel,mask] = CreateSkeleton(mask,parameters)
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
sizeX=size(mask,1);
sizeY=size(mask,2);
sizeZ=size(mask,3);
fprintf('handles.parameters.size.X: %1d\n',sizeX);
fprintf('handles.parameters.size.Y: %1d\n',sizeY);
fprintf('handles.parameters.size.Z: %1d\n',sizeZ);
fprintf('handles.parameters.resizemask: %1d\n',parameters.resizemask);
ij.IJ.run('Properties...', ['unit=um pixel_width=',num2str(parameters.voxelwidth.resizemaskX),...
                            ' pixel_height=',num2str(parameters.voxelwidth.resizemaskY),...
                            ' voxel_depth=',num2str(parameters.voxelwidth.Z)]);
% MIJ.run('Size...', ['width=',num2str(sizeX./parameters.resizemask),...
%                    ' height=',num2str(sizeY./parameters.resizemask),...
%                    ' depth=',num2str(sizeZ),...
%                    ' constrain average interpolation=Bicubic']);      
% MIJ.run('Convert to Mask', 'method=Triangle background=Dark calculate black');

%% Skeletonize an image in ImageJ from Matlab using MIJI
disp('Skeletonize...');
MIJ.run('8-bit');
MIJ.run('Invert LUT');
if length(size(mask))>2
    MIJ.run('Fill Holes', 'stack');
end
MIJ.run('Invert LUT');
MIJ.run('Skeletonize (2D/3D)');         %Run the plugin Skeletonize(2D/3D)
disp('Copying skeleton in Matlab...');
skel= logical(MIJ.getCurrentImage());   %Add the skeleton in the Matlab Workspace
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


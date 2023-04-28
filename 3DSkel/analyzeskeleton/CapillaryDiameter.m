function [diametermap] = CapillaryDiameter(skel,mask,parameters,start,exit)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%clc;


%% Load the mask

% 
% disp('Openning mask...');
% if nargin==0
%     [FileName,PathName,FilterIndex] = uigetfile('*','Select maskETON');
%     if FileName == 0
%         error('No mask selected !');
%     end
%     mask= OpenBinaryStack([PathName,FileName]);
% elseif isempty(mask) == 1
%     [FileName,PathName,FilterIndex] = uigetfile('*','Select MASK');
%     if FileName == 0
%         error('No mask selected !');
%     end
%     mask= OpenBinaryStack([PathName,FileName]);
% elseif mask == 0
% %     [FileName,PathName,FilterIndex] = uigetfile('*','Select maskETON');
% %     if FileName == 0
% %         error('No mask selected !');
% %     end
% %     mask= OpenBinaryStack([PathName,FileName]);
%     diameter=0;
%     disp('Done.');
%     return;
% elseif ischar(mask)== 1
%     mask= OpenBinaryStack(mask);
%     if mask == 0
%         error('No mask selected !');
%     end
% elseif isinteger(mask) == 1
%     mask = logical(mask);
% end
% 


%% Start MIJI (and ImageJ)
inter = ij.macro.Interpreter;
inter.batchMode = true;
if start==1
    if ismac
        MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
    else
        MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
    end
end

%% Load the mask
disp('Copying mask in ImageJ...');
MIJ.createImage(uint8(mask).*255);


%% Calculate the mean capillary diameter
disp('Calculate Diameter...');
ij.IJ.run('Properties...', ['unit=um pixel_width=',num2str(parameters.voxelwidth.resizemaskX),...
                            ' pixel_height=',num2str(parameters.voxelwidth.resizemaskY),...
                            ' voxel_depth=',num2str(parameters.voxelwidth.Z)]);
MIJ.run('8-bit');
MIJ.run('Local Thickness (masked, calibrated, silent)');
distancemap=MIJ.getCurrentImage();
MIJ.run('Close'); MIJ.run('Close');
MIJ.closeAllWindows;

%Clear memory (by creating a blank image and processing local thickness)
MIJ.createImage(uint8(zeros(3,3)));
MIJ.run('8-bit');
MIJ.run('Local Thickness (masked, calibrated, silent)');
MIJ.run('Close'); MIJ.run('Close');
MIJ.closeAllWindows;
macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end

if exit==1
MIJ.exit();
end

distancemap(isnan(distancemap))=0;  %Replace NaN with 0
diametermap= distancemap(and(distancemap,skel));
diameter_mean= mean(diametermap)
diameter_SD= std(diametermap,1)

% if length(size(mask))>2
%     distancemap= bwdistsc1(~mask,[parameters.voxelwidth.X parameters.voxelwidth.Y parameters.voxelwidth.Z],12);
%     diametermap= distancemap(and(distancemap,skel));
%     diameter= 2*mean(diametermap);
% else
%     distancemap = bwdist(~mask);
%     diametermap= distancemap(and(distancemap,skel));
%     diameter= mean(diametermap);
% end


end


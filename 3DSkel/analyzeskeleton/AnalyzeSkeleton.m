function [results,branchinfo,skel] = AnalyzeSkeleton(skel,parameters)
% Analyze skeleton using ImageJ (plugin Analyze Skeleton 2D/3D)
%
%[results,branchinfo] = AnalyzeSkeleton(skel, parameters)
%
%Input : 
%   - skel (skeleton : filepath or binary image or [])
%   - parameters (type struct) : voxel_width (width of a pixel in µm), 
%                                THR (threshold length for the skeleton analysis)
%Output :
%   - results (type struct) : global info for each independant skeleton (branches, junctions, end-point...)
%   - branchinfo (type struct) : detailed info for each branch (skeleton ID, length, coordinates, euclidian distance)

clc;
global FileName
global outputfolder
%% Start MIJI (and ImageJ)
inter = ij.macro.Interpreter;
inter.batchMode = true;
if ismac
    MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
else
    MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
end


%% Load the skeleton
disp('Copying skeleton in ImageJ...');
MIJ.createImage(uint8(skel).*255);


%% Analyze skeleton in ImageJ from Matlab using MIJI

ij.IJ.run('Properties...', ['unit=um pixel_width=',num2str(parameters.voxelwidth.resizemaskX),...
                            ' pixel_height=',num2str(parameters.voxelwidth.resizemaskY),...
                            ' voxel_depth=',num2str(parameters.voxelwidth.Z)]);
disp('Analyze Skeleton...');
MIJ.run('Analyze Skeleton (2D/3D)', 'prune=none show display');        %Run the plugin Analyze Skeleton (2D/3D)

%Save the results in the output folder
%currentFolder = pwd;
if ismac
    currentFolderResults= [outputfolder,'/Results_',FileName(1:end-4),'.csv'];
    currentFolderBranchInfo= [outputfolder,'/Branchinfo_',FileName(1:end-4),'.csv'];
else
    currentFolderResults= [outputfolder,'\Results_',FileName(1:end-4),'.csv'];
    currentFolderBranchInfo= [outputfolder, '\BranchInfo_',FileName(1:end-4),'.csv'];
end
MIJ.selectWindow('Results');
ij.IJ.saveAs('Results', currentFolderResults);

MIJ.selectWindow('Branch information');
ij.IJ.saveAs('Results', currentFolderBranchInfo);
MIJ.run('Close'); MIJ.run('Close'); MIJ.run('Close'); MIJ.run('Close');

macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end
MIJ.closeAllWindows;
MIJ.exit;


%% Import results
disp('Import results in Matlab...');
results= importdata(currentFolderResults);
branchinfo= importdata(currentFolderBranchInfo);

end
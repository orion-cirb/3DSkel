function [filepath] = SaveMask(mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global outputfolder
filepath=[outputfolder,'\mask.tif'];

for z= 1:size(mask,3)
    if z == 1
        writeMode = 'overwrite';
    else
        writeMode = 'append';
    end
    imwrite(uint8(mask(:,:,z)).*255, [outputfolder,'\mask.tif'], ...
        'tif', 'Compression', 'none', 'WriteMode', writeMode);
end

end


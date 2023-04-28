function [mask] = OpenMask(mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global FileName

disp('Openning mask...');

if nargin==0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select MASK');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select MASK');
    end
    if FileName == 0
        error('No mask selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'MASKPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'MASK_')
            FileName= FileName(6:end);
        end
        A=exist('mask_process');
        if A==1
            mask=mask_process;
        end
    else
        mask= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif isempty(mask) == 1
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select MASK');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select MASK');
    end
    if FileName == 0
        error('No mask selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'MASKPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'MASK_')
            FileName= FileName(6:end);
        end
        A=exist('mask_process');
        if A==1
            mask=mask_process;
        end
    else
        mask= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif mask == 0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select MASK');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select MASK');
    end
    if FileName == 0
        error('No mask selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'MASKPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'MASK_')
            FileName= FileName(6:end);
        end
        A=exist('mask_process');
        if A==1
            mask=mask_process;
        end
    else
        mask= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif ischar(mask)== 1
    mask= OpenBinaryStack(mask);
    if mask == 0
        error('No mask selected !');
    end
    
elseif isinteger(mask) == 1
    mask = logical(mask);
end

end


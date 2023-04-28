function [skel] = OpenSkel(skel)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global FileName

disp('Openning skeleton...');

if nargin==0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select SKELETON');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select SKELETON');
    end
    if FileName == 0
        error('No skel selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'SKELPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'SKEL_')
            FileName= FileName(6:end);
        end
        A=exist('skel_process');
        if A==1
            skel=skel_process;
        end
    else
        skel= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif isempty(skel) == 1
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select SKELETON');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select SKELETON');
    end
    if FileName == 0
        error('No skel selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'SKELPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'SKEL_')
            FileName= FileName(6:end);
        end
        A=exist('skel_process');
        if A==1
            skel=skel_process;
        end
    else
        skel= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif skel == 0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select SKELETON');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select SKELETON');
    end
    if FileName == 0
        error('No skel selected !');
    elseif strcmpi(FileName(end-3:end),'.mat')
        load([PathName,FileName]);
        if regexpi(FileName,'SKELPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'SKEL_')
            FileName= FileName(6:end);
        end
        A=exist('skel_process');
        if A==1
            skel=skel_process;
        end
    else
        skel= OpenBinaryStack([PathName,FileName]);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif ischar(skel)== 1
    
    if strcmpi(FileName(end-3:end),'.mat')
        load(skel);
        if regexpi(FileName,'SKELPROCESS_')
            FileName= FileName(13:end);
        elseif regexpi(FileName,'SKEL_')
            FileName= FileName(6:end);
        end
        A=exist('skel_process');
        if A==1
            skel=skel_process;
        end
    else
        skel= OpenBinaryStack([PathName,FileName]);
    end

    if skel == 0
        error('No skel selected !');
    end
    
elseif isinteger(skel) == 1
    skel = logical(skel);
end

end


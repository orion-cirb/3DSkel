function [image,size] = OpenImage(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global FileName

disp('Openning image...');

if nargin==0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select IMAGE.TIF');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select IMAGE.TIF');
    end
    if FileName == 0
        error('No image selected !');
    else
        %image= OpenStack([PathName,FileName]);
        %% Start MIJI (and ImageJ)
        inter = ij.macro.Interpreter;
        inter.batchMode = false;
        if ismac
            MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
        else
            MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
        end
        disp(' 1) Load images ...');
        disp(FileName);
        InfoImage= imfinfo([PathName,FileName]);
        size.X= InfoImage(1).Width;
        size.Y= InfoImage(1).Height;
        size.Z= length(InfoImage);
        MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif isempty(image) == 1
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.*','Select IMAGE.TIF');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select IMAGE.TIF');
    end
    if FileName == 0
        error('No image selected !');
    else
        %image= OpenStack([PathName,FileName]);
        %% Start MIJI (and ImageJ)
        inter = ij.macro.Interpreter;
        inter.batchMode = false;
        if ismac
            MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
        else
            MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
        end
        disp(' 1) Load images ...');
        disp(FileName);
        InfoImage= imfinfo([PathName,FileName]);
        size.X= InfoImage(1).Width;
        size.Y= InfoImage(1).Height;
        size.Z= length(InfoImage);
        MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif image == 0
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.','Select MASK');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*.*','Select MASK');
    end
    if FileName == 0
        error('No image selected !');
    else
        %image= OpenStack([PathName,FileName]);
        %% Start MIJI (and ImageJ)
        inter = ij.macro.Interpreter;
        inter.batchMode = false;
        if ismac
            MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
        else
            MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
        end
        disp(' 1) Load images ...');
        disp(FileName);
        InfoImage= imfinfo([PathName,FileName]);
        size.X= InfoImage(1).Width;
        size.Y= InfoImage(1).Height;
        size.Z= length(InfoImage);
        MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    end
    %MIJ.run('Open...', ['path=[',[PathName,FileName],']']);
    
elseif ischar(image)== 1
    %image= OpenStack(image);
    %% Start MIJI (and ImageJ)
    inter = ij.macro.Interpreter;
    inter.batchMode = false;
    if ismac
        MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
    else
        MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
    end
    disp(' 1) Load images ...');
    disp(FileName);
    InfoImage= imfinfo(image);
    size.X= InfoImage(1).Width;
    size.Y= InfoImage(1).Height;
    size.Z= length(InfoImage);
    MIJ.run('Open...', ['path=[',image,']']);
    if image == 0
        error('No image selected !');
    end
    
end


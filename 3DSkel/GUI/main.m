function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 28-Feb-2019 12:49:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.GUI1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%% INITIALISATION

function initialize_gui(fig_handle, handles, isreset)
clc;
currentFolder = pwd;

if ismac
    rmdir([currentFolder,'/temp'],'s');
    mkdir([currentFolder,'/temp']);
    addpath('../analyzeskeleton');
    addpath('../skel2graph3d');
    addpath('../MIJI');
    javaaddpath('../MIJI/mij.jar');
    javaaddpath('../MIJI/ij.jar');
    addpath('../xlwrite');
    javaaddpath('../xlwrite/poi_library/poi-3.8-20120326.jar');
    javaaddpath('../xlwrite/poi_library/poi-ooxml-3.8-20120326.jar');
    javaaddpath('../xlwrite/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('../xlwrite/poi_library/xmlbeans-2.3.0.jar');
    javaaddpath('../xlwrite/poi_library/dom4j-1.6.1.jar');
    javaaddpath('../xlwrite/poi_library/stax-api-1.0.1.jar');
    addpath('../GUI/Fiji.app/scripts');
else
    rmdir([currentFolder,'\temp'],'s');
    mkdir([currentFolder,'\temp']);
    addpath('..\analyzeskeleton');
    addpath('..\skel2graph3d');
    addpath('..\MIJI');
    javaaddpath('..\MIJI\mij.jar');
    javaaddpath('..\MIJI\ij.jar');
    addpath('..\xlwrite');
    javaaddpath('..\xlwrite\poi_library\poi-3.8-20120326.jar');
    javaaddpath('..\xlwrite\poi_library\poi-ooxml-3.8-20120326.jar');
    javaaddpath('..\xlwrite\poi_library\poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('..\xlwrite\poi_library\xmlbeans-2.3.0.jar');
    javaaddpath('..\xlwrite\poi_library\dom4j-1.6.1.jar');
    javaaddpath('..\xlwrite\poi_library\stax-api-1.0.1.jar');
    addpath('..\GUI\Fiji.app\scripts');
end

global outputfolder;
global FileName;
global listfolder;
listfolder=0;
FileName=0;
if ismac
    outputfolder = [currentFolder,'/temp'];
else
    outputfolder = [currentFolder,'\temp'];
end
set(handles.OutputFolderText, 'String', [outputfolder,'    NOT DEFINED !!!'],'foregroundcolor',[1 0 0]);
%clc;

% Initialisation
handles.image=[];
handles.mask=[];
handles.mask_process=[];
handles.skel=[];
handles.skel_process=[];
handles.parameters=[];
handles.results=[];
handles.branchinfo=[];
handles.status=[];
handles.results.data=[];
handles.branchinfo.data=[];
handles.results.data2=[];
handles.branchinfo.data2=[];
handles.totallength=[];
handles.totalbranches=[];
handles.totaljunctions=[];
handles.totalendpoints=[];
handles.volume=[];
handles.meantortuosity=[];
handles.diameter=[];
handles.splicing=[];
handles.progress=[];
handles.filename='No opened file';
handles.listresults= {''};
handles.compactness=[];
handles.internalendpoints=[];
handles.externalendpoints=[];
handles.diameter_mean=[];
handles.diameter_SD=[];
handles.nbskelton=[];
handles.connectivity=[];

if ismac
    handles.PathName.fig='../..';
else
    handles.PathName.fig='..\..';
end

% Checkbox
handles.CreateMask_checkbox = 0;
% handles.ProcessingMask_checkbox = 0;
handles.CreateSkeleton_checkbox = 0;
handles.ProcessingSkeleton_checkbox = 0;
handles.AnalyzeSkeleton_checkbox = 0;
handles.CapillaryDiameter_checkbox = 0;
handles.SelectAll_checkbox = 0;
handles.timeseries_checkbox = 0;
handles.splicing_checkbox = 0;
set(handles.CreateMaskCheckbox, 'Value', handles.CreateMask_checkbox);
% set(handles.ProcessingMaskCheckbox, 'Value', handles.ProcessingMask_checkbox);
set(handles.CreateSkeletonCheckbox, 'Value', handles.CreateSkeleton_checkbox);
set(handles.ProcessingSkeletonCheckbox, 'Value', handles.ProcessingSkeleton_checkbox);
set(handles.AnalyzeSkeletonCheckbox, 'Value', handles.AnalyzeSkeleton_checkbox);
set(handles.CapillaryDiameterCheckbox, 'Value', handles.CapillaryDiameter_checkbox);
set(handles.SelectAllCheckbox, 'Value', handles.SelectAll_checkbox);
set(handles.timeseries, 'Value', handles.timeseries_checkbox);
set(handles.SplicingDataSetCheckbox, 'Value', handles.splicing_checkbox);

% Parameters
handles.parameters.voxelwidth.X = 0.325;
handles.parameters.voxelwidth.Y = 0.325;
handles.parameters.voxelwidth.Z = 1;
handles.parameters.THR_micrometer = 20;
handles.parameters.resizestack= 1;
handles.parameters.resizemask= 1;
handles.parameters.size=[];
handles.parameters.THR_pixel= handles.parameters.THR_micrometer/(handles.parameters.voxelwidth.X.*handles.parameters.resizestack.*handles.parameters.resizemask);
handles.parameters.voxelwidth.resizestackX= handles.parameters.resizestack.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizestackY= handles.parameters.resizestack.*handles.parameters.voxelwidth.Y;
handles.parameters.voxelwidth.resizemaskX= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizemaskY= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.Y;
set(handles.voxelwidthX, 'String', handles.parameters.voxelwidth.X);
set(handles.voxelwidthY, 'String', handles.parameters.voxelwidth.Y);
set(handles.voxelwidthZ, 'String', handles.parameters.voxelwidth.Z);
set(handles.THR, 'String', handles.parameters.THR_micrometer);
handles.splicing.X=1;
handles.splicing.Y=1;
handles.splicing.Z=1;
handles.splicing.margin=0;

% Listbox
set(handles.FileName, 'String', handles.filename,'foregroundcolor',[1 0 0]);
set(handles.ResultsListbox,'Value',1);
set(handles.ResultsListbox, 'String', handles.listresults);

% Status
handles.status.CreateMask = 'Not done';
% handles.status.ProcessingMask = 'Not done';
handles.status.CreateSkeleton = 'Not done';
handles.status.ProcessingSkeleton = 'Not done';
handles.status.AnalyzeSkeleton = 'Not done';
handles.status.CapillaryDiameter = 'Not done';
StatusProcess(fig_handle,handles, handles.CreateMaskStatus, 'Not done', [1 0 0]);
% StatusProcess(fig_handle,handles, handles.ProcessingMaskStatus, 'Not done', [1 0 0]);
StatusProcess(fig_handle,handles, handles.CreateSkeletonStatus, 'Not done', [1 0 0]);
StatusProcess(fig_handle,handles, handles.ProcessingSkeletonStatus, 'Not done', [1 0 0]);
StatusProcess(fig_handle,handles, handles.AnalyzeSkeletonStatus, 'Not done', [1 0 0]);
StatusProcess(fig_handle,handles, handles.CapillaryDiameterStatus, 'Not done', [1 0 0]);

disp('3DSkel Quantification Software... v30');
disp('Initialisation Done!');
% Update handles structure
guidata(handles.GUI1, handles);



%% IMAGE PROPERTIES


%------------------------ VOXEL WIDTH XYZ --------------------------------%

function voxelwidthX_Callback(hObject, eventdata, handles)
% hObject    handle to voxelwidthX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voxelwidthX as text
%        str2double(get(hObject,'String')) returns contents of voxelwidthX as a double
handles.parameters.voxelwidth.X = str2double(get(hObject, 'String'));
handles.parameters.THR_pixel= handles.parameters.THR_micrometer/(handles.parameters.voxelwidth.X.*handles.parameters.resizestack.*handles.parameters.resizemask);
handles.parameters.voxelwidth.resizestackX= handles.parameters.resizestack.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizemaskX= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.X;

% fprintf('handles.parameters.THR_pixel: %1d\n',handles.parameters.THR_pixel);
% fprintf('handles.parameters.voxelwidth.X: %1d\n',handles.parameters.voxelwidth.X);
% fprintf('handles.parameters.voxelwidth.resizestackX: %1d\n',handles.parameters.voxelwidth.resizestackX);
% fprintf('handles.parameters.voxelwidth.resizemaskX: %1d\n',handles.parameters.voxelwidth.resizemaskX);
% fprintf('handles.parameters.voxelwidth.resizestackY: %1d\n',handles.parameters.voxelwidth.resizestackY);
% fprintf('handles.parameters.voxelwidth.resizemaskY: %1d\n',handles.parameters.voxelwidth.resizemaskY);
% fprintf('handles.parameters.resizestack: %1d\n',handles.parameters.resizestack);
% fprintf('handles.parameters.resizemask: %1d\n',handles.parameters.resizemask);
 
guidata(hObject,handles)

function voxelwidthY_Callback(hObject, eventdata, handles)
% hObject    handle to voxelwidthY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voxelwidthY as text
%        str2double(get(hObject,'String')) returns contents of voxelwidthY as a double
handles.parameters.voxelwidth.Y = str2double(get(hObject, 'String'));
handles.parameters.voxelwidth.resizestackY= handles.parameters.resizestack.*handles.parameters.voxelwidth.Y;
handles.parameters.voxelwidth.resizemaskY= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.Y;

guidata(hObject,handles)

function voxelwidthZ_Callback(hObject, eventdata, handles)
% hObject    handle to voxelwidthZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voxelwidthZ as text
%        str2double(get(hObject,'String')) returns contents of voxelwidthZ as a double
handles.parameters.voxelwidth.Z = str2double(get(hObject, 'String'));
guidata(hObject,handles)


%---------------------------- TIME SERIES --------------------------------%

% --- Executes on button press in timeseries.
function timeseries_Callback(hObject, eventdata, handles)
% hObject    handle to timeseries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of timeseries
handles.timeseries_checkbox = get(hObject, 'Value');

guidata(hObject,handles)




%% PROCESSING PARAMETERS

%------------------- THR (Branch length threshold) -----------------------%

function THR_Callback(hObject, eventdata, handles)
% hObject    handle to THR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of THR as text
%        str2double(get(hObject,'String')) returns contents of THR as a double
handles.parameters.THR_micrometer=str2double(get(hObject, 'String'));
handles.parameters.THR_pixel= handles.parameters.THR_micrometer/(handles.parameters.voxelwidth.X.*handles.parameters.resizestack.*handles.parameters.resizemask);

% fprintf('handles.parameters.THR_pixel: %1d\n',handles.parameters.THR_pixel);
% fprintf('handles.parameters.voxelwidth.X: %1d\n',handles.parameters.voxelwidth.X);

guidata(hObject,handles)

%------------------- Resize Stack -----------------------%

function ResizeStack_Callback(hObject, eventdata, handles)
% hObject    handle to ResizeStack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ResizeStack as text
%        str2double(get(hObject,'String')) returns contents of ResizeStack as a double
handles.parameters.resizestack= str2double(get(hObject, 'String'));
handles.parameters.voxelwidth.resizestackX= handles.parameters.resizestack.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizestackY= handles.parameters.resizestack.*handles.parameters.voxelwidth.Y;
handles.parameters.voxelwidth.resizemaskX= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizemaskY= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.Y;
handles.parameters.THR_pixel= handles.parameters.THR_micrometer/(handles.parameters.voxelwidth.X.*handles.parameters.resizestack.*handles.parameters.resizemask);
fprintf('handles.parameters.voxelwidth.resizestackX: %1d\n',handles.parameters.voxelwidth.resizestackX);
fprintf('handles.parameters.voxelwidth.resizemaskX: %1d\n',handles.parameters.voxelwidth.resizemaskX);
fprintf('handles.parameters.voxelwidth.resizestackY: %1d\n',handles.parameters.voxelwidth.resizestackY);
fprintf('handles.parameters.voxelwidth.resizemaskY: %1d\n',handles.parameters.voxelwidth.resizemaskY);
% fprintf('handles.parameters.resizestack: %1d\n',handles.parameters.resizestack);
% fprintf('handles.parameters.resizemask: %1d\n',handles.parameters.resizemask);

guidata(hObject,handles)

function ResizeMask_Callback(hObject, eventdata, handles)
% hObject    handle to ResizeMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ResizeMask as text
%        str2double(get(hObject,'String')) returns contents of ResizeMask as a double
handles.parameters.resizemask= str2double(get(hObject, 'String'));
handles.parameters.voxelwidth.resizestackX= handles.parameters.resizestack.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizestackY= handles.parameters.resizestack.*handles.parameters.voxelwidth.Y;
handles.parameters.voxelwidth.resizemaskX= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.X;
handles.parameters.voxelwidth.resizemaskY= handles.parameters.resizestack.*handles.parameters.resizemask.*handles.parameters.voxelwidth.Y;
handles.parameters.THR_pixel= handles.parameters.THR_micrometer/(handles.parameters.voxelwidth.X.*handles.parameters.resizestack.*handles.parameters.resizemask);
fprintf('handles.parameters.voxelwidth.resizestackX: %1d\n',handles.parameters.voxelwidth.resizestackX);
fprintf('handles.parameters.voxelwidth.resizemaskX: %1d\n',handles.parameters.voxelwidth.resizemaskX);
fprintf('handles.parameters.voxelwidth.resizestackY: %1d\n',handles.parameters.voxelwidth.resizestackY);
fprintf('handles.parameters.voxelwidth.resizemaskY: %1d\n',handles.parameters.voxelwidth.resizemaskY);
% fprintf('handles.parameters.resizestack: %1d\n',handles.parameters.resizestack);
% fprintf('handles.parameters.resizemask: %1d\n',handles.parameters.resizemask);
 
guidata(hObject,handles)
%------------------- Splicing Data Set -----------------------%

function SplicingDataSetCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to SplicingDataSetCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SplicingDataSetCheckbox
handles.splicing_checkbox= get(hObject, 'Value');
if handles.splicing_checkbox
    handles.splicing.X=2;
    handles.splicing.Y=2;
    handles.splicing.Z=1;
    handles.splicing.margin=70;
else
    handles.splicing.X=1;
    handles.splicing.Y=1;
    handles.splicing.Z=1;
    handles.splicing.margin=0;
end

guidata(hObject,handles)

%% PROCESS

%------------------------ CREATE MASK --------------------------------%

% --- Executes on button press in CreateMask.
function [mask_process, mask] = CreateMask_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global outputfolder;
global listfolder; listfolder=0;
size_stack=[];
StatusProcess(hObject,handles,handles.CreateMaskStatus,'Wait',[1 0.6 0]);
handles.mask = [];
[handles.image,size_stack]= OpenImage(handles.image);
handles.parameters.size=size_stack;
set(handles.FileName,'String',FileName,'foregroundcolor',[0 0 0]);

[mask] = CreateMask(handles.parameters);
handles.mask= mask;
mask_process= mask;
handles.mask_process= mask;

if ismac
    save([outputfolder,'/MASK_',FileName(1:end-4),'.mat'],'mask','-v7.3');
else
    save([outputfolder,'\MASK_',FileName(1:end-4),'.mat'],'mask','-v7.3');
end

% Status
disp('Done.');
StatusProcess(hObject,handles,handles.CreateMaskStatus,'Done',[0 0.8 0]);
% StatusProcess(hObject,handles,handles.ProcessingMaskStatus,'Ready',[0.2 0.6 1]);
guidata(hObject,handles)

% %------------------------ PROCESSING MASK --------------------------------%
% 
% % --- Executes on button press in ProcessingMask.
% function [mask_process, mask] = ProcessingMask_Callback(hObject, eventdata, handles)
% % hObject    handle to ProcessingMask (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global FileName;
% global outputfolder;
% global listfolder; listfolder=0;
% StatusProcess(hObject,handles,handles.ProcessingMaskStatus,'Wait',[1 0.6 0]);
% [handles.mask]= OpenMask(handles.mask);
% set(handles.FileName,'String',FileName,'foregroundcolor',[0 0 0]);
% handles.mask_process = [];
% a=handles.splicing.X; b=handles.splicing.Y; c=handles.splicing.Z; margin=handles.splicing.margin; inc2=0;
% mask= RegionizeStack(handles.mask,a,b,c,margin);
% 
% for z=1:c
%     for y=1:b
%         for x=1:a
%             inc2=inc2+1;
%             fprintf('Step %1d/%1d\n',inc2,a*b*c);
%             [mask_process,~] = ProcessingMask(mask{x,y,z});
%             handles.mask_process{x,y,z} = mask_process;
%         end
%     end
% end
% 
% mask= handles.mask;
% handles.mask_process = FusionStack(handles.mask_process,a,b,c,margin);
% mask_process = handles.mask_process;
% 
% if ismac
%     save([outputfolder,'/MASKPROCESS_',FileName(1:end-4),'.mat'],'mask_process','-v7.3');
% else
%     save([outputfolder,'\MASKPROCESS_',FileName(1:end-4),'.mat'],'mask_process','-v7.3');
% end
% 
% % Status
% disp('Done.');
% StatusProcess(hObject,handles,handles.ProcessingMaskStatus,'Done',[0 0.8 0]);
% StatusProcess(hObject,handles,handles.CreateSkeletonStatus,'Ready',[0.2 0.6 1]);
% guidata(hObject,handles)


%------------------------ CREATE SKELETON --------------------------------%

% --- Executes on button press in CreateSkeleton.
function [skel, mask_process] = CreateSkeleton_Callback(hObject, eventdata, handles)

% hObject    handle to CreateSkeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global outputfolder;
global listfolder; listfolder=0;
global progress;
StatusProcess(hObject,handles,handles.CreateSkeletonStatus,'Wait',[1 0.6 0]);
[handles.mask_process]= OpenMask(handles.mask_process);
set(handles.FileName,'String',FileName,'foregroundcolor',[0 0 0]);
handles.skel = [];
a=handles.splicing.X; b=handles.splicing.Y; c=handles.splicing.Z; margin=handles.splicing.margin; inc2=0;

if handles.parameters.resizemask>1
    [resize_mask]= ResizeMask(handles.mask_process,handles.parameters);
    mask_process= RegionizeStack(resize_mask,a,b,c,margin);
elseif handles.parameters.resizemask==1
    mask_process= RegionizeStack(handles.mask_process,a,b,c,margin);
end

for z=1:c
    for y=1:b
        for x=1:a
            inc2=inc2+1;
            fprintf('Step %1d/%1d\n',inc2,a*b*c);
            [skel,~] = CreateSkeleton(mask_process{x,y,z},handles.parameters);
            handles.skel{x,y,z} = skel;
        end
    end
end
%[filepath]=SaveMask(mask_process{x,y,z});
handles.skel = FusionStack(handles.skel,a,b,c,margin);
skel = handles.skel;
mask_process = FusionStack(mask_process,a,b,c,margin);
handles.mask_process= mask_process;

if ismac
    save([outputfolder,'/SKEL_',FileName(1:end-4),'.mat'],'skel','-v7.3');
else
    save([outputfolder,'\SKEL_',FileName(1:end-4),'.mat'],'skel','-v7.3');
end

%Calculate the Volume and Compactness of the network
if size(mask_process)>2
% nnz(mask_process)
% numel(mask_process)
handles.compactness= nnz(mask_process)./numel(mask_process);
handles.volume= nnz(mask_process).*handles.parameters.voxelwidth.resizemaskX.*handles.parameters.voxelwidth.resizemaskY.*handles.parameters.voxelwidth.Z.*10^-9;
end

volume=[];
volume= num2cell(handles.volume);
header_volume= {'Volume (mm3)'};
volume= cat(1,header_volume,volume);

compactness=[];
compactness= num2cell(handles.compactness);
header_compactness= {'Compactness'};
compactness= cat(1,header_compactness,compactness);

% Display results in a table in GUI3
if handles.timeseries_checkbox == 0
    run DisplayResultsTable;
    obj = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    h1 = findobj(obj,'Tag','Volume');
    h2 = findobj(obj,'Tag','Compactness');
    set(h1, 'String', handles.volume);
    set(h2, 'String', handles.compactness);
end

if handles.timeseries_checkbox == 1
    position=[];
    position.volume= [xlscol(progress+1),'8'];
    position.compactness= [xlscol(progress+1),'9'];
    if ismac
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_volume,1,'A8');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_compactness,1,'A9');
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.volume,1,position.volume);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.compactness,1,position.compactness);
    else
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_volume,1,'A8');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_compactness,1,'A9');
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.volume,1,position.volume);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.compactness,1,position.compactness);
    end
end

% Save results in Excel
if ismac
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],volume,1,'M19');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],compactness,1,'N19');
else
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],volume,1,'M19');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],compactness,1,'N19');
end

% Status
disp('Done.');
StatusProcess(hObject,handles,handles.CreateSkeletonStatus,'Done',[0 0.8 0]);
StatusProcess(hObject,handles,handles.ProcessingSkeletonStatus,'Ready',[0.2 0.6 1]);
guidata(hObject,handles)


%---------------------- PROCESSING SKELETON ------------------------------%
% Process (branch length thresholding) and display 3D skeleton with Matlab

% --- Executes on button press in ProcessingSkeleton.
function [skel_process, skel, node] = ProcessingSkeleton_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingSkeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global outputfolder;
global listfolder; listfolder=0;
[handles.skel]= OpenSkel(handles.skel);
set(handles.FileName, 'String', FileName,'foregroundcolor',[0 0 0]);
StatusProcess(hObject,handles,handles.ProcessingSkeletonStatus,'Wait',[1 0.6 0]);
node=[];
[skel_process, skel, node, link] = ProcessingSkeleton(handles.skel,handles.parameters);
DisplaySkeleton(skel, skel_process, node, link, handles.parameters);
if handles.timeseries_checkbox == 1
close 1;
end

handles.skel_process = skel_process;
handles.skel = skel;
handles.node= node;

if ismac
    save([outputfolder,'/SKELPROCESS_',FileName(1:end-4),'.mat'],'skel_process','-v7.3');
else
    save([outputfolder,'\SKELPROCESS_',FileName(1:end-4),'.mat'],'skel_process','-v7.3');
end

% Status
disp('Done.');
StatusProcess(hObject,handles,handles.ProcessingSkeletonStatus,'Done',[0 0.8 0]);
StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Ready',[0.2 0.6 1]);
if ~isempty(handles.mask_process)
    StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Ready',[0.2 0.6 1]);
end
guidata(hObject,handles)


%------------------------ ANALYZE SKELETON -------------------------------%
% Analyze skeleton (branches, branch length, total length...) with ImageJ

% --- Executes on button press in AnalyzeSkeleton.
function [skel_process, listresults] = AnalyzeSkeleton_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyzeSkeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outputfolder;
global FileName;
global listfolder; listfolder=0;
global progress;
StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Wait',[1 0.6 0]);
[handles.skel_process]= OpenSkel(handles.skel_process);

set(handles.FileName, 'String', FileName,'foregroundcolor',[0 0 0]);
[handles.results,handles.branchinfo,skel_process]= AnalyzeSkeleton(handles.skel_process,handles.parameters);
handles.skel_process = skel_process;

 % Calculate #Branches and junctions after thresholding
threshold = handles.parameters.THR_pixel.*handles.parameters.voxelwidth.resizemaskX;
corrections=[];
corrections(:,1:4) = getrealbranches(handles.branchinfo.data,handles.results.data,threshold);
handles.totalbranches = sum(corrections(:,2));
handles.totaljunctions = sum(corrections(:,4));
handles.totalendpoints = sum(handles.results.data(:,4));

% Calculate the tortuosity
tortuosity = handles.branchinfo.data(:,10)./handles.branchinfo.data(:,3);
handles.meantortuosity = (sum(tortuosity)-sum(corrections(:,3)))/sum(handles.branchinfo.data(:,10)>(handles.parameters.THR_pixel.*handles.parameters.voxelwidth.resizemaskX));

% Calculate the total length
handles.totallength = sum(handles.branchinfo.data(:,3));

% Calculate and Display histogram of branch length
if handles.timeseries_checkbox == 0
    run DisplayResultsTable;
    obj1 = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    axes1 = findobj(obj1,'Tag','histogram');
    cla(axes1);
    [count,interval,~,h] = histbranchlength(handles.branchinfo.data,threshold,'on');  
    axes_handle1 = findobj(h, 'Type', 'Axes'); % find handle to axes in figure
    axes_children_handle1 = get(axes_handle1, 'Children');
    copyobj(axes_children_handle1,axes1);
    %close histo;
elseif handles.timeseries_checkbox == 1
    [count,interval,~,h] = histbranchlength(handles.branchinfo.data,threshold,'off');
end

%Calculate new skeleton informations
handles.results.data2= [handles.results.data(:,1) corrections(:,1:4) handles.results.data(:,4) handles.results.data(:,8:9)];
handles.branchinfo.data2= [handles.branchinfo.data(:,1:3) handles.branchinfo.data(:,10) tortuosity];

%Calculate nb of skeletons
handles.nbskeleton=[];
handles.nbskeleton= length(handles.results.data2(:,1));

%Calculate real end-points (internal)
sizeX= size(handles.skel,1).*handles.parameters.voxelwidth.resizemaskX;
sizeY= size(handles.skel,2).*handles.parameters.voxelwidth.resizemaskY;
sizeZ= size(handles.skel,3).*handles.parameters.voxelwidth.Z;
idx_ep=[]; ep=[]; endpoints=[];
idx_ep= [handles.node.ep]==1; %Find index of endpoints
ep=handles.node(idx_ep); %Extract endpoints
endpoints=struct;
k=0; m=0; flag1=0; flag2=0;
X=[]; Y=[]; Z=[];
for i=1:length(ep)

    X = ep(i).comx.*handles.parameters.voxelwidth.resizemaskX;
    Y = ep(i).comy.*handles.parameters.voxelwidth.resizemaskY;
    Z = ep(i).comz.*handles.parameters.voxelwidth.Z;
    
    if X<15 || Y<15 || Z<15
        k=k+1;
        endpoints.external(k)=ep(i);
        flag1=1;
    else
        m=m+1;
        endpoints.internal(m)=ep(i);
        flag2=1;
    end
end
if flag2==1
    handles.internalendpoints=length(endpoints.internal);
else
    handles.internalendpoints=0;
end
if flag1==1
    handles.externalendpoints=length(endpoints.external);
else
    handles.externalendpoints=0;
end

%Calculate weighted connectivity
handles.connectivity=[];
handles.connectivity = (sum(handles.results.data2(:,3).^2)-handles.nbskeleton)./handles.totalbranches.^2; %Weighted connectivity in graph theory
%handles.connectivity = (handles.totalbranches-handles.nbskeleton)./(handles.totalbranches); %Simple connectivity in graph theory


% Display results in a table in GUI3
if handles.timeseries_checkbox == 0
    obj = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    h1 = findobj(obj,'Tag','ResultsTable');
    h2 = findobj(obj,'Tag','BranchInfoTable');
    h3 = findobj(obj,'Tag','TotalLength');
    h4 = findobj(obj,'Tag','TotalBranches');
    h5 = findobj(obj,'Tag','TotalBranchPoints');
    h6 = findobj(obj,'Tag','TotalEndPoints');
    h7 = findobj(obj,'Tag','MeanTortuosity');
    h8 = findobj(obj,'Tag','InternalEndPoints');
    h9 = findobj(obj,'Tag','Connectivity');
    h10 = findobj(obj,'Tag','NbSkeleton');
    set(h1, 'data', handles.results.data2);
    set(h2, 'data', handles.branchinfo.data2);
    set(h3, 'String', handles.totallength);
    set(h4, 'String', handles.totalbranches);
    set(h5, 'String', handles.totaljunctions);
    set(h6, 'String', handles.totalendpoints);
    set(h7, 'String', handles.meantortuosity);
    set(h8, 'String', handles.internalendpoints);
    set(h9, 'String', handles.connectivity);
    set(h10, 'String', handles.nbskeleton);
end

% Write results
results=[];
results= num2cell(handles.results.data2);
header_results= {'Skeleton ID' 'Length' '#Branches' '#Rejected Branches' '#Branch points' 'End-points' 'Triple points' 'Quadruple points'};
results= cat(1,header_results,results);

branchinfo=[];
branchinfo= num2cell(handles.branchinfo.data2);
header_branchinfo= {'' 'Skeleton ID' 'Branch length' 'Euclidian distance' 'Tortuosity'};
branchinfo= cat(1,header_branchinfo,branchinfo);

histo=[];
count= num2cell(count);
histo= cat(2,interval,count);
header_histo= {'Branch length' '#Branches'};
histo= cat(1,header_histo,histo);

totallength=[];
totallength= num2cell(handles.totallength);
header_totallength= {'Total length (µm)'};
totallength= cat(1,header_totallength,totallength);

totalbranches=[];
totalbranches= num2cell(handles.totalbranches);
header_totalbranches= {'Total branches'};
totalbranches= cat(1,header_totalbranches,totalbranches);

totaljunctions=[];
totaljunctions= num2cell(handles.totaljunctions);
header_totaljunctions= {'Total branch points'};
totaljunctions= cat(1,header_totaljunctions,totaljunctions);

totalendpoints=[];
totalendpoints= num2cell(handles.totalendpoints);
header_totalendpoints= {'Total endpoints'};
totalendpoints= cat(1,header_totalendpoints,totalendpoints);

internalendpoints=[];
internalendpoints= num2cell(handles.internalendpoints);
header_internalendpoints= {'Internal endpoints'};
internalendpoints= cat(1,header_internalendpoints,internalendpoints);

meantortuosity=[];
meantortuosity= num2cell(handles.meantortuosity);
header_meantortuosity= {'Mean tortuosity'};
meantortuosity= cat(1,header_meantortuosity,meantortuosity);

nbskeleton=[];
nbskeleton= num2cell(handles.nbskeleton);
header_nbskeleton= {'# skeletons'};
nbskeleton= cat(1,header_nbskeleton,nbskeleton);

connectivity=[];
connectivity= num2cell(handles.connectivity);
header_connectivity= {'Connectivity'};
connectivity= cat(1,header_connectivity,connectivity);

% Save results in Excel
if ismac
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],results,1);
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],branchinfo,2);
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],histo,1,'J1');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],totallength,1,'M1');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],totalbranches,1,'M4');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],totaljunctions,1,'M7');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],totalendpoints,1,'N10');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],internalendpoints,1,'M10');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],meantortuosity,1,'M16');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],nbskeleton,1,'M22');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],connectivity,1,'M25');
else
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],results,1);
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],branchinfo,2);
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],histo,1,'J1');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],totallength,1,'M1');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],totalbranches,1,'M4');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],totaljunctions,1,'M7');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],totalendpoints,1,'N10');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],internalendpoints,1,'M10');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],meantortuosity,1,'M16');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],nbskeleton,1,'M22');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],connectivity,1,'M25');
end

% Save Global Results in one excel file (only for series processing)
if handles.timeseries_checkbox == 1
    
    position=[];
    position.filename= [xlscol(progress+1),'1'];
    position.totallength= [xlscol(progress+1),'2'];
    position.totalbranches= [xlscol(progress+1),'3'];
    position.totaljunctions= [xlscol(progress+1),'4'];
    position.totalendpoints= [xlscol(progress+1),'5'];
    position.internalendpoints= [xlscol(progress+1),'6'];
    position.meantortuosity= [xlscol(progress+1),'7'];
    position.nbskeleton= [xlscol(progress+1),'10'];
    position.connectivity= [xlscol(progress+1),'11'];
    
    if ismac
        xlwrite([outputfolder,'/Results_Global.xlsx'],{'Filename'},1,'A1');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_totallength,1,'A2');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_totalbranches,1,'A3');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_totaljunctions,1,'A4');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_totalendpoints,1,'A5');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_internalendpoints,1,'A6');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_meantortuosity,1,'A7');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_nbskeleton,1,'A10');
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_connectivity,1,'A11');
        
        xlwrite([outputfolder,'/Results_Global.xlsx'],{FileName(1:end-4)},1,position.filename);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.totallength,1,position.totallength);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.totalbranches,1,position.totalbranches);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.totaljunctions,1,position.totaljunctions);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.totalendpoints,1,position.totalendpoints);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.internalendpoints,1,position.internalendpoints);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.meantortuosity,1,position.meantortuosity);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.nbskeleton,1,position.nbskeleton);
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.connectivity,1,position.connectivity);
    else
        xlswrite([outputfolder,'\Results_Global.xlsx'],{'Filename'},1,'A1');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_totallength,1,'A2');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_totalbranches,1,'A3');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_totaljunctions,1,'A4');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_totalendpoints,1,'A5');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_internalendpoints,1,'A6');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_meantortuosity,1,'A7');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_nbskeleton,1,'A10');
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_connectivity,1,'A11');
        
        xlswrite([outputfolder,'\Results_Global.xlsx'],{FileName(1:end-4)},1,position.filename);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.totallength,1,position.totallength);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.totalbranches,1,position.totalbranches);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.totaljunctions,1,position.totaljunctions);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.internalendpoints,1,position.internalendpoints);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.meantortuosity,1,position.meantortuosity);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.nbskeleton,1,position.nbskeleton);
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.connectivity,1,position.connectivity);   
    end
end

% Results ListBox
listresults = [handles.listresults;{FileName}];
handles.listresults= listresults;
set(handles.ResultsListbox,'String',listresults(2:end,1));

% Status
disp('Done.');
StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Done',[0 0.8 0]);
if ~isempty(handles.mask_process)
    StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Ready',[0.2 0.6 1]);
end

guidata(hObject,handles)



%----------------------- CAPILLARY DIAMETER ------------------------------%
% Calculate Mean Capillary Diameter

% --- Executes on button press in CapillaryDiameter.
function [diameter_mean]=CapillaryDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to CapillaryDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global outputfolder;
global listfolder; listfolder=0;
global progress;
StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Wait',[1 0.6 0]);
[handles.mask_process]= OpenMask(handles.mask_process);
set(handles.FileName, 'String', FileName);
a=1; b=1;
c= ceil(size(handles.mask_process,3).*handles.parameters.voxelwidth.Z./20); %substack of 20µm

%Make Z-substack of 20µm width (mask and skel)
mask_process_substack= RegionizeStack(handles.mask_process,a,b,c,0);
skel_process_substack= RegionizeStack(handles.skel_process,a,b,c,0);

diameter_mean_final=0;
diameter_SD_final=0;
diametermap=[];
diameter=[];
inc=0; inc2=0;
start=1;
exit=0;
for z=1:c
    for y=1:b
        for x=1:a
            %clc;
            inc2=inc2+1;
            fprintf('Step %1d/%1d\n',inc2,a*b*c);
            if inc2==(a*b*c)
                exit=1;
            end
            MIP_mask_process_substack= max(mask_process_substack{x,y,z},[],3);
            MIP_skel_process_substack= max(skel_process_substack{x,y,z},[],3);
            [diameter] = CapillaryDiameter(MIP_skel_process_substack,MIP_mask_process_substack,handles.parameters,start,exit);
            start=0;
            if ~isempty(diameter)
                inc= inc+1;
                diametermap=cat(1,diametermap,diameter);
            end
        end
    end
end
% Calculate and Display Mean Diameter in a table in GUI3
diameter_mean= mean(diametermap);
diameter_SD= std(diametermap,1);
handles.diameter_mean= diameter_mean;
handles.diameter_SD= diameter_SD;
meandiameter=[];
meandiameter= num2cell(handles.diameter_mean);
SDdiameter= num2cell(handles.diameter_SD);
header_meandiameter= {'Mean diameter (um)'};
header_SDdiameter= {'SD diameter'};
meandiameter= cat(1,header_meandiameter,meandiameter);
SDdiameter= cat(1,header_SDdiameter,SDdiameter);
diameter_mean= handles.diameter_mean;
diameter_SD= handles.diameter_SD;
if handles.timeseries_checkbox == 0
    obj = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    h1 = findobj(obj,'Tag','MeanDiameter');
    h2 = findobj(obj,'Tag','SDDiameter');
    set(h1, 'String', handles.diameter_mean);
    set(h2, 'String', handles.diameter_SD);
end
% Save diameter value in Excel
if ismac
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],meandiameter,1,'M13');
    xlwrite([outputfolder,'/Results_',FileName(1:end-4),'.xlsx'],SDdiameter,1,'N13');
else
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],meandiameter,1,'M13');
    xlswrite([outputfolder,'\Results_',FileName(1:end-4),'.xlsx'],SDdiameter,1,'N13');
end

% Save Diameter in Global Results (only for series processing)
if handles.timeseries_checkbox == 1
    
    position=[];
    position.diameter_mean= [xlscol(progress+1),'12'];
    position.diameter_SD= [xlscol(progress+1),'13'];
      
    if ismac
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_meandiameter,1,'A12');
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.diameter_mean,1,position.diameter_mean);
        xlwrite([outputfolder,'/Results_Global.xlsx'],header_SDdiameter,1,'A13');
        xlwrite([outputfolder,'/Results_Global.xlsx'],handles.diameter_SD,1,position.diameter_SD);
    else
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_meandiameter,1,'A12');
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.diameter_mean,1,position.diameter_mean);
        xlswrite([outputfolder,'\Results_Global.xlsx'],header_SDdiameter,1,'A13');
        xlswrite([outputfolder,'\Results_Global.xlsx'],handles.diameter_SD,1,position.diameter_SD);
    end
end

% Status
disp('Done.');
StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Done',[0 0.8 0]);
guidata(hObject,handles)


%------------------ PROCESSING ALL (selected process)---------------------%
% Execute all selected process

% --- Executes on button press in ProcessingAll.
function ProcessingAll_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FileName;
global outputfolder;
global listfolder; listfolder=0;
global progress; progress=0;

if handles.timeseries_checkbox == 1
    if ismac
        [FileName,PathName,FilterIndex] = uigetfile('../../*.','Select File Series');
    else
        [FileName,PathName,FilterIndex] = uigetfile('..\..\*','Select File Series');
    end
    if FileName==0
        return
    end
    FileList= dir (PathName) ;
    truefileindex = [FileList.isdir]==0;
    handles.list = {FileList(truefileindex).name}';
    
    for i=1:length(handles.list)
        
        FileName = handles.list{i};
        handles.image= [PathName, handles.list{i}];
        handles.mask= [PathName, handles.list{i}];
        handles.mask_process= [PathName, handles.list{i}];
        handles.skel= [PathName, handles.list{i}];
        handles.skel_process= [PathName, handles.list{i}];
        progress = i;
        
        if strcmp(FileName,'.DS_Store') % Do not process ".DS_Store" file
        else

            % Creating mask with ImageJ (filters+threshold)
            if handles.CreateMask_checkbox
                [handles.mask_process, handles.mask] = CreateMask_Callback(hObject, eventdata, handles);
            end
            
%             % Processing mask with ImageJ (gaussian filtering)
%             if handles.ProcessingMask_checkbox
%                 [handles.mask_process, handles.mask] = ProcessingMask_Callback(hObject, eventdata, handles);
%             end
            
            % Create the skeleton from the mask with ImageJ (Skeletonize 2D/3D)
            if handles.CreateSkeleton_checkbox
                [handles.skel, handles.mask_process] = CreateSkeleton_Callback(hObject, eventdata, handles);
            end
            
            % Process (branch length thresholding) and display 3D skeleton with MATLAB
            if handles.ProcessingSkeleton_checkbox
                [handles.skel_process, handles.skel, handles.node] = ProcessingSkeleton_Callback(hObject, eventdata, handles);
            end
            
            % Analyze the skeleton with ImageJ (Analayze Skeleton 2D/3D)
            if handles.AnalyzeSkeleton_checkbox
                [handles.skel_process, handles.listresults] = AnalyzeSkeleton_Callback(hObject, eventdata, handles);
            end
            
            % Calculate the mean capillary diameter with ImageJ (Local Thickness)
            if handles.CapillaryDiameter_checkbox
                [handles.diameter] = CapillaryDiameter_Callback(hObject, eventdata, handles);
            end
        end
    end
    
else
    
    % Creating mask with ImageJ (filters+threshold)
    if handles.CreateMask_checkbox
        [handles.mask_process, handles.mask] = CreateMask_Callback(hObject, eventdata, handles);
    end
    
%     % Processing mask with ImageJ
%     if handles.ProcessingMask_checkbox
%         [handles.mask_process, handles.mask] = ProcessingMask_Callback(hObject, eventdata, handles);
%     end
    
    % Create Skeleton with ImageJ (Skeletonize 2D/3D)
    if handles.CreateSkeleton_checkbox
        [handles.skel, handles.mask_process] = CreateSkeleton_Callback(hObject, eventdata, handles);
    end
    
    % Process (branch length thresholding) and display 3D skeleton with MATLAB
    if handles.ProcessingSkeleton_checkbox
        [handles.skel_process, handles.skel, handles.node] = ProcessingSkeleton_Callback(hObject, eventdata, handles);
    end
    
    % Analyze the skeleton with ImageJ (Analayze Skeleton 2D/3D)
    if handles.AnalyzeSkeleton_checkbox
        [handles.skel_process, handles.listresults] = AnalyzeSkeleton_Callback(hObject, eventdata, handles);
    end
    
    % Calculate the mean capillary diameter with ImageJ (Local Thickness)
    if handles.CapillaryDiameter_checkbox
        [handles.diameter] = CapillaryDiameter_Callback(hObject, eventdata, handles);
    end
end
guidata(hObject,handles)


% --- Executes on button press in CreateMaskCheckbox.
function CreateMaskCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMaskCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of CreateMaskCheckbox
checkbox= get(hObject,'Value');
handles.CreateMask_checkbox= checkbox;
guidata(hObject,handles)

% % --- Executes on button press in ProcessingMaskCheckbox.
% function ProcessingMaskCheckbox_Callback(hObject, eventdata, handles)
% % hObject    handle to ProcessingMaskCheckbox (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % Hint: get(hObject,'Value') returns toggle state of ProcessingMaskCheckbox
% checkbox= get(hObject,'Value');
% handles.ProcessingMask_checkbox= checkbox;
% guidata(hObject,handles)

% --- Executes on button press in CreateSkeletonCheckbox.
function CreateSkeletonCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to CreateSkeletonCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of CreateSkeletonCheckbox
checkbox= get(hObject,'Value');
handles.CreateSkeleton_checkbox= checkbox;
guidata(hObject,handles)

% --- Executes on button press in ProcessingSkeletonCheckbox.
function ProcessingSkeletonCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingSkeletonCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of ProcessingSkeletonCheckbox
checkbox= get(hObject,'Value');
handles.ProcessingSkeleton_checkbox= checkbox;
guidata(hObject,handles)

% --- Executes on button press in AnalyzeSkeletonCheckbox.
function AnalyzeSkeletonCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyzeSkeletonCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of AnalyzeSkeletonCheckbox
checkbox= get(hObject,'Value');
handles.AnalyzeSkeleton_checkbox= checkbox;
guidata(hObject,handles)

% --- Executes on button press in CapillaryDiameterCheckbox.
function CapillaryDiameterCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to CapillaryDiameterCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of CapillaryDiameterCheckbox
checkbox= get(hObject,'Value');
handles.CapillaryDiameter_checkbox= checkbox;
guidata(hObject,handles)


% --- Executes on button press in SelectAllCheckbox.
function SelectAllCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectAllCheckbox
checkbox= get(hObject,'Value');
if (checkbox ~= handles.SelectAll_checkbox)
    
    handles.SelectAll_checkbox= checkbox;
    handles.CreateMask_checkbox = checkbox;
%     handles.ProcessingMask_checkbox = checkbox;
    handles.CreateSkeleton_checkbox = checkbox;
    handles.ProcessingSkeleton_checkbox = checkbox;
    handles.AnalyzeSkeleton_checkbox = checkbox;
    handles.CapillaryDiameter_checkbox = checkbox;
    
    set(handles.CreateMaskCheckbox, 'Value', checkbox);
%     set(handles.ProcessingMaskCheckbox, 'Value', checkbox);
    set(handles.CreateSkeletonCheckbox, 'Value', checkbox);
    set(handles.ProcessingSkeletonCheckbox, 'Value', checkbox);
    set(handles.AnalyzeSkeletonCheckbox, 'Value', checkbox);
    set(handles.CapillaryDiameterCheckbox, 'Value', checkbox);
    
end
guidata(hObject,handles)




%% RESET

% --- Executes on button press in ResetAll.
function ResetAll_Callback(hObject, eventdata, handles)
% hObject    handle to ResetAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName
FileName=0;
handles.image=[];
handles.mask=[];
handles.mask_process=[];
handles.skel=[];
handles.skel_process=[];
handles.results=[];
handles.results.data=[];
handles.branchinfo=[];
handles.branchinfo.data=[];
handles.status=[];

set(handles.FileName, 'String', handles.filename,'foregroundcolor',[1 0 0]);

StatusProcess(hObject,handles,handles.CreateMaskStatus,'Not done',[1 0 0]);
% StatusProcess(hObject,handles,handles.ProcessingMaskStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.CreateSkeletonStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.ProcessingSkeletonStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Not done',[1 0 0]);
guidata(hObject,handles)

% --- Executes on button press in ProcessingMaskReset.
function CreateMaskReset_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingMaskReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image=[];
handles.mask=[];
handles.mask_process=[];
handles.status.CreateMask = 'Not done';
set(handles.CreateMaskStatus, 'String', handles.status.CreateMask,'foregroundcolor',[1 0 0]);
guidata(hObject,handles)

% % --- Executes on button press in ProcessingMaskReset.
% function ProcessingMaskReset_Callback(hObject, eventdata, handles)
% % hObject    handle to ProcessingMaskReset (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles.mask=[];
% %handles.mask_process=[];
% handles.status.ProcessingMask = 'Not done';
% set(handles.ProcessingMaskStatus, 'String', handles.status.ProcessingMask,'foregroundcolor',[1 0 0]);
% guidata(hObject,handles)

% --- Executes on button press in CreateSkeletonReset.
function CreateSkeletonReset_Callback(hObject, eventdata, handles)
% hObject    handle to CreateSkeletonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mask=[];
handles.mask_process=[];
handles.skel=[];
StatusProcess(hObject,handles,handles.CreateSkeletonStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Not done',[1 0 0]);
guidata(hObject,handles)

% --- Executes on button press in ProcessingSkeletonReset.
function ProcessingSkeletonReset_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessingSkeletonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.skel_process=[];
StatusProcess(hObject,handles,handles.ProcessingSkeletonStatus,'Ready',[0.2 0.6 1]);
StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Not done',[1 0 0]);
StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Not done',[1 0 0]);
guidata(hObject,handles)

% --- Executes on button press in AnalyzeSkeletonReset.
function AnalyzeSkeletonReset_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyzeSkeletonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.skel_process=[];
handles.results=[];
handles.branchinfo=[];
if isempty(handles.skel_process)
    StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Not done',[1 0 0]);
else
    StatusProcess(hObject,handles,handles.AnalyzeSkeletonStatus,'Ready',[0.2 0.6 1]);
end
guidata(hObject,handles)

% --- Executes on button press in CapillaryDiameterReset.
function CapillaryDiameterReset_Callback(hObject, eventdata, handles)
% hObject    handle to CapillaryDiameterReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.diameter=[];
if isempty(handles.skel_process) && isempty(handles.mask_process)
    StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Not done',[1 0 0]);
else
    StatusProcess(hObject,handles,handles.CapillaryDiameterStatus,'Ready',[0.2 0.6 1]);
end
guidata(hObject,handles)




%% DISPLAY SKELETON (FIGURE)

% --- Executes on button press in DisplaySkeleton.
function DisplaySkeleton_Callback(hObject, eventdata, handles)
% hObject    handle to DisplaySkeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%run DisplaySkeleton;
global outputfolder;
global FileName;
global listfolder;

if listfolder==0
    folder = outputfolder;
else
    folder = listfolder;
end

if FileName==0;
    [file,handles.PathName.fig,FilterIndex] = uigetfile([handles.PathName.fig,'/*.fig'],'Select FIGURE (.fig)');
    if handles.PathName.fig==0
        return;
    end
    if ismac
        openfig([handles.PathName.fig,file],'reuse');
    else
        openfig([handles.PathName.fig,file],'reuse');
    end
else
    if ismac
        openfig([folder,'/',FileName(1:end-4),'.fig'],'reuse');
    else
        openfig([folder,'\',FileName(1:end-4),'.fig'],'reuse');
    end
end
%openfig('Results/fig2.fig','reuse');
guidata(hObject,handles)

% --- Executes on button press in CloseSkeleton.
function CloseSkeleton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseSkeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 1; %close(2);
guidata(hObject,handles)


%% DISPLAY RESULTS TABLES (GUI3)

% --- Executes on button press in DisplayResults.
function DisplayResults_Callback(hObject, eventdata, handles)
% hObject    handle to DisplayResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run DisplayResultsTable;
global FileName
global outputfolder
global listfolder

if listfolder==0
    folder = outputfolder;
else
    folder = listfolder;
end

if ismac
    currentFolderResults= [folder,'/Results_',FileName(1:end-4),'.csv'];
    currentFolderBranchInfo= [folder,'/Branchinfo_',FileName(1:end-4),'.csv'];
    currentFolderResultsXLSX= [folder,'/Results_',FileName(1:end-4),'.xlsx'];
else
    currentFolderResults= [folder,'\Results_',FileName(1:end-4),'.csv'];
    currentFolderBranchInfo= [folder,'\Branchinfo_',FileName(1:end-4),'.csv'];
    currentFolderResultsXLSX= [folder,'\Results_',FileName(1:end-4),'.xlsx'];
end
a= exist(currentFolderResults,'file');
b= exist(currentFolderBranchInfo,'file');
if a==2 && b==2
    handles.results= importdata(currentFolderResults);
    handles.branchinfo= importdata(currentFolderBranchInfo);
    % Calculate #Branches and junctions after thresholding
    threshold = handles.parameters.THR_pixel.*handles.parameters.voxelwidth.resizemaskX;
    corrections(:,1:4) = getrealbranches(handles.branchinfo.data,handles.results.data,threshold);
    %handles.totalbranches = sum(corrections(:,2));
    %handles.totaljunctions = sum(corrections(:,4));
    handles.totalendpoints = sum(handles.results.data(:,4));
    
    % Calculate the tortuosity
    tortuosity = handles.branchinfo.data(:,10)./handles.branchinfo.data(:,3);
    %handles.meantortuosity = (sum(tortuosity)-sum(corrections(:,3)))/sum(handles.branchinfo.data(:,10)>(handles.parameters.THR_pixel.*handles.parameters.voxelwidth.resizemaskX));
    
    % Calculate the total length
    handles.totallength = sum(handles.branchinfo.data(:,3));
    
    % Display results in a table in GUI3
    handles.results.data2= [handles.results.data(:,1) corrections(:,1:4) handles.results.data(:,4) handles.results.data(:,8:9)];
    handles.branchinfo.data2= [handles.branchinfo.data(:,1:3) handles.branchinfo.data(:,10) tortuosity];
    
    %Read info from .xlsx (excel tab)
    handles.totalbranches= xlsread(currentFolderResultsXLSX,1,'M5');
    handles.totaljunctions= xlsread(currentFolderResultsXLSX,1,'M8');
    handles.internalendpoints= xlsread(currentFolderResultsXLSX,1,'M11');
    handles.diameter_mean= xlsread(currentFolderResultsXLSX,1,'M14');
    handles.diameter_SD= xlsread(currentFolderResultsXLSX,1,'N14');
    handles.volume= xlsread(currentFolderResultsXLSX,1,'M20');
    handles.compactness= xlsread(currentFolderResultsXLSX,1,'N20');
    handles.nbskeleton= xlsread(currentFolderResultsXLSX,1,'M23');
    handles.connectivity= xlsread(currentFolderResultsXLSX,1,'M26');
    handles.meantortuosity= xlsread(currentFolderResultsXLSX,1,'M17');
end

if ~isempty(handles.branchinfo.data)
    obj1 = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    axes1 = findobj(obj1,'Tag','histogram');
    cla(axes1);
    threshold = handles.parameters.THR_pixel.*handles.parameters.voxelwidth.resizemaskX;
    [~,~,~,h] = histbranchlength(handles.branchinfo.data,threshold,'on');
    axes_handle1 = findobj(h, 'Type', 'Axes'); % find handle to axes in figure
    axes_children_handle1 = get(axes_handle1, 'Children');
    copyobj(axes_children_handle1,axes1);
    
    % Display results in table
    obj = findobj(0, 'Type', 'figure', 'Tag', 'GUI3');
    h1 = findobj(obj,'Tag','ResultsTable');
    h2 = findobj(obj,'Tag','BranchInfoTable');
    h3 = findobj(obj,'Tag','TotalLength');
    h4 = findobj(obj,'Tag','TotalBranches');
    h5 = findobj(obj,'Tag','TotalBranchPoints');
    h6 = findobj(obj,'Tag','InternalEndPoints');
    h7 = findobj(obj,'Tag','TotalEndPoints');
    h8 = findobj(obj,'Tag','MeanTortuosity');
    h9 = findobj(obj,'Tag','Volume');
    h10 = findobj(obj,'Tag','Compactness');
    h11 = findobj(obj,'Tag','MeanDiameter');
    h12 = findobj(obj,'Tag','SDDiameter');
    h13 = findobj(obj,'Tag','Connectivity');
    h14 = findobj(obj,'Tag','NbSkeleton');
    set(h1, 'data', handles.results.data2);
    set(h2, 'data', handles.branchinfo.data2);
    set(h3, 'String', handles.totallength);
    set(h4, 'String', handles.totalbranches);
    set(h5, 'String', handles.totaljunctions);
    set(h6, 'String', handles.internalendpoints);
    set(h7, 'String', handles.totalendpoints);
    set(h8, 'String', handles.meantortuosity);
    set(h9, 'String', handles.volume);
    set(h10, 'String', handles.compactness);
    set(h11, 'String', handles.diameter_mean);
    set(h12, 'String', handles.diameter_SD);
    set(h13, 'String', handles.connectivity);
    set(h14, 'String', handles.nbskeleton);
end
guidata(hObject,handles)



%% LISTBOX RESULTS

% --- Executes on selection change in ResultsListbox.
function ResultsListbox_Callback(hObject, eventdata, handles)
% hObject    handle to ResultsListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ResultsListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ResultsListbox
%global FileNameList
global FileName
if strcmp(get(handles.GUI1,'SelectionType'),'open')
    contents=[];
    contents = cellstr(get(hObject,'String'));
    FileName=contents{get(hObject,'Value')};
    if ~isempty(FileName)
        DisplayResults_Callback(hObject, eventdata, handles);
        %close histo;
    else
        FileName=0;
    end
    
else
    contents=[];
    contents = cellstr(get(hObject,'String'));
    FileName=contents{get(hObject,'Value')};
    if isempty(FileName)
        FileName=0;
    end
end
guidata(hObject,handles)

% --- Executes on button press in LoadList.
function LoadList_Callback(hObject, eventdata, handles)
% hObject    handle to LoadList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global listfolder
if ismac
    [FileName,listfolder,FilterIndex] = uigetfile('../../*.*','Select Results Series');
else
    [FileName,listfolder,FilterIndex] = uigetfile('../../*.*','Select Results Series');
end
if listfolder==0
    return;
end
FileList= dir (listfolder) ;
location=strfind({FileList.name},'.fig');
if isempty([location{:}])
    listresults={''};
else
    truefileindex = not(cellfun('isempty', location));
    listresults = {FileList(truefileindex).name}';
end
set(handles.ResultsListbox,'Value',1);
set(handles.ResultsListbox,'String',listresults);
guidata(hObject,handles)

% --- Executes on button press in ClearList.
function ClearList_Callback(hObject, eventdata, handles)
% hObject    handle to ClearList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName
FileName=0;
handles.listresults= {''};
set(handles.ResultsListbox,'Value',1);
set(handles.ResultsListbox,'String',handles.listresults);
guidata(hObject,handles)


%% STATUS
function StatusProcess(hObject,handles,tag,status,color)
%status = 'Wait';
set(tag, 'String', status,'foregroundcolor',color);
guidata(hObject,handles)


%% OUTPUT FOLDER
% --- Executes on button press in OutputFolder.
function OutputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to OutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outputfolder
if ismac
    PathName = uigetdir('../..','Select the Output Folder');
else
    PathName = uigetdir('..\..','Select the Output Folder');
end
if PathName==0
    return
end
FileList= dir (PathName) ;
truedirindex = [FileList.isdir]==1;
listdir = {FileList(truedirindex).name}';
a=strcmpi(listdir,'output');
if sum(a)>=1
    if ismac
        outputfolder = [PathName,'/',listdir{a}];
    else
        outputfolder = [PathName,'\',listdir{a}];
    end
else
    if ismac
        outputfolder = [PathName,'/Output'];
    else
        outputfolder = [PathName,'\Output'];
    end
    mkdir(outputfolder);
end

set(handles.OutputFolderText, 'String', outputfolder,'foregroundcolor',[0.2 0.6 1]);
guidata(hObject,handles)



%% HELP
% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ismac
    open('../HELP/3DSkel_help.pdf');
else
    open('..\HELP\3DSkel_help.pdf');
end
guidata(hObject,handles)

% --------------------------------------------------------------------
function AboutMIJI_Callback(hObject, eventdata, handles)
% hObject    handle to AboutMIJI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ismac
    open('../MIJI/Poster-MIJ-Daniel-Sage.pdf');
else
    open('..\MIJI\Poster-MIJ-Daniel-Sage.pdf');
end
guidata(hObject,handles)



%% EXIT
% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
%delete(handles.GUI1)



%% QUANTIF Nuclei into capillaries
% --- Executes on button press in CountNuclei.
function CountNuclei_Callback(hObject, eventdata, handles)
% hObject    handle to CountNuclei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CountNuclei();

guidata(hObject,handles)

% --- Executes on button press in AnalyzeNuclei.
function AnalyzeNuclei_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyzeNuclei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AnalyzeNuclei();

guidata(hObject,handles)

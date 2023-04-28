function varargout = DisplaySkeleton(varargin)
% DISPLAYRESULTS MATLAB code for DisplayResults.fig
%      DISPLAYRESULTS, by itself, creates a new DISPLAYRESULTS or raises the existing
%      singleton*.
%
%      H = DISPLAYRESULTS returns the handle to a new DISPLAYRESULTS or the handle to
%      the existing singleton*.
%
%      DISPLAYRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAYRESULTS.M with the given input arguments.
%
%      DISPLAYRESULTS('Property','Value',...) creates a new DISPLAYRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DisplayResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DisplayResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DisplayResults

% Last Modified by GUIDE v2.5 09-Jan-2017 13:22:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DisplayResults_OpeningFcn, ...
                   'gui_OutputFcn',  @DisplayResults_OutputFcn, ...
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


% --- Executes just before DisplayResults is made visible.
function DisplayResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DisplayResults (see VARARGIN)

% Choose default command line output for DisplayResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DisplayResults wait for user response (see UIRESUME)
% uiwait(handles.GUI2);


% --- Outputs from this function are returned to the command line.
function varargout = DisplayResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function initialize_gui(fig_handle, handles, isreset)
clc;

%addpath(pwd);
%path= [pwd,'\skel2graph3d']
%addpath(path);
%run DisplayResults

% Update handles structure=,;hgn
guidata(handles.GUI2, handles);

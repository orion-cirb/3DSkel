% MIJI demo ( MATLAB <--> ImageJ )
clear all; close all; clc;

javaaddpath('C:\Program Files\MATLAB\R2011a\java\mij.jar');
javaaddpath('C:\Program Files\MATLAB\R2011a\java\ij.jar');
addpath('C:\Users\Yoann\Documents\Logiciels\Fiji\Fiji.app\scripts');

%image= mijread('C:\\Users\\Yoann\\Desktop\\Test Cell Live Marker 231116\\5j\\MAX_CM1,5_5min.czi - C=1-1.jpg');
%image= mijread();

%% Start MIJI (and ImageJ)

MIJ.start('C:\Users\Yoann\Documents\Logiciels\Fiji\Fiji.app');

%% How to open an image in ImageJ from Matlab using MIJI
MIJ.run('Open...');     %Without specifying the access path
MIJ.run('Open...', 'path=[C:\\Users\\Yoann\\Desktop\\Test Cell Live Marker 231116\\5j\\MAX_CM1,5_5min.czi - C=1-1.jpg]');   %With the access path

MIJ.getCurrentImage();      %Add the image in the Matlab Workspace

%% How to run a ImageJ macro from Matlab using MIJI
macro_path='C:\Users\Yoann\Documents\These\Macro ImageJ\PSF_measurement.ijm';
ij.IJ.runMacroFile(macro_path);
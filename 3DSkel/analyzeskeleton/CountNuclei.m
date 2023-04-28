function [] = CountNuclei()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Start MIJI (and ImageJ)
inter = ij.macro.Interpreter;
inter.batchMode = true;
if ismac
    MIJ.start([pwd,'/Fiji.app']);  %Location of Fiji.app on the machine
else
    MIJ.start([pwd,'\Fiji.app']);  %Location of Fiji.app on the machine
end

%% Count nuclei inside capillaries

macro_path=pwd;
if ismac
    ij.IJ.runMacroFile([macro_path,'/macro/nuclei_into_capillaries.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\macro\nuclei_into_capillaries.ijm']);
end


%% Exit MIJI
if ismac
    ij.IJ.runMacroFile([macro_path,'/garbagecollector/garbagecollector.ijm']);
else
    ij.IJ.runMacroFile([macro_path,'\garbagecollector\garbagecollector.ijm']);
end
MIJ.exit();

end


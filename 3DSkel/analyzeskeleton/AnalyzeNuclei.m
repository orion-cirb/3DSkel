function [] = AnalyzeNuclei()
%AnalyzeNuclei Summary of this function goes here
%   Detailed explanation goes here


%% Analyze raw data from "CounNuclei"

% Read data files (.csv only)
if ismac
    [FileName,PathName,FilterIndex] = uigetfile('*.csv','Select Data');
else
    [FileName,PathName,FilterIndex] = uigetfile('*.csv','Select Data');
end
if FileName==0
    return
end
FileList= dir (PathName) ;
truefileindex= [FileList.isdir]==0;
list= {FileList(truefileindex).name}';
outputfolder= PathName;

pathparts=regexp(PathName,filesep,'split');
name= pathparts{end-1};
%% Analyze data

j=0;
k=1;
threshold=0;
step=1;
count=[];

header_volume.text= {'Volume (µm3)'};
header_nb_nuclei.text= {'Nb nuclei'};

for i=1:length(list)
    
    FileName = list{i};
    if strfind(FileName,'.csv')
        
        j=j+1;
        
        results= importdata([PathName,FileName]);
        
        %Find 'Volume' column
        volume_column=strfind(results.textdata,'Volume');
        volume_column_idx= ~cellfun('isempty', volume_column);
        volume.data= results.data(:,volume_column_idx);
        
        filename.position= [xlscol(j),'1'];
        header_volume.position= [xlscol(j),'2'];
        volume.position= [xlscol(j),'3'];
        
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],{FileName},1,filename.position);
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],header_volume.text,1,header_volume.position);
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],volume.data,1,volume.position);
        
        j=j+1;
        
        %Find 'Nuclei' column
        nuclei_column=strfind(results.textdata,'IntDen');
        nuclei_column_idx= ~cellfun('isempty', nuclei_column);
        nb_nuclei.data= ceil(results.data(:,nuclei_column_idx)./(21*255));
        
        filename.position= [xlscol(j),'1'];
        header_nb_nuclei.position= [xlscol(j),'2'];
        nb_nuclei.position= [xlscol(j),'3'];
        
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],header_nb_nuclei.text,1,header_nb_nuclei.position);
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],nb_nuclei.data,1,nb_nuclei.position);
        
        k=k+1;
        
        count6_plus= [];
        count2_5= [];
        count1= [];
        count2= [];
        count3= [];
        count4= [];
        count5= [];
        nuclei= [];
        positive_value_idx= [];
        edges= [];
        count_total= [];
        bins= [];
        count_total2= [];
        
        positive_value_idx= nb_nuclei.data(:)>threshold;
        nuclei= nb_nuclei.data(positive_value_idx);
        max_nuclei= max(nuclei);
        edges= 1:step:max_nuclei+1;
        [count_total,bins]= histcounts(nuclei,edges);
        
        complete_vect1=zeros(6-length(count_total),1)';
        count_total_corrected=[count_total complete_vect1];
        
        complete_vect2=zeros(7-length(bins),1)';
        bins_corrected=[bins complete_vect2];
        
        count_total2= count_total_corrected.*bins_corrected(1:end-1);
        count6_plus= sum(count_total2(6:end));
        count2_5= sum(count_total2(2:5));
        count1= count_total2(1);
        count2= count_total2(2);
        count3= count_total2(3);
        count4= count_total2(4);
        count5= count_total2(5);
        
        %histo
        count.data1(:,k-1)= [count1 ;count2_5 ;count6_plus];
        count.data2(:,k-1)= [count1 ;count2 ;count3 ;count4 ;count5 ;count6_plus];
        
        filename.position= [xlscol(k),'1'];
        count.position1= [xlscol(k),'2'];
        count.position2= [xlscol(k),'6'];
        
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],{FileName},2,filename.position);
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.data1(:,k-1),2,count.position1);
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.data2(:,k-1),2,count.position2);
        
        xlwrite([outputfolder,'/Results_',name,'.xlsx'],{FileName},'% of nuclei',filename.position);
        
    end
end



%% MEANS & Standard Deviation (SD)


%Mean count nuclei
header_mean.text= 'MEAN';
header_mean.position= [xlscol(size(count.data1,2)+2),'1'];

count.mean.data1= mean(count.data1,2);
count.mean.data2= mean(count.data2,2);

count.mean.position1= [xlscol(size(count.data1,2)+2),'2'];
count.mean.position2= [xlscol(size(count.data2,2)+2),'6'];

%Std Deviation count nuclei
header_SD.text= 'SD';
header_SD.position= [xlscol(size(count.data2,2)+3),'1'];

count.SD.data1= std(count.data1,0,2);
count.SD.data2= std(count.data2,0,2);

count.SD.position1= [xlscol(size(count.data1,2)+3),'2'];
count.SD.position2= [xlscol(size(count.data2,2)+3),'6'];

%Percentage count nuclei
count.percentage.data1= count.data1./repmat(sum(count.data1,1),3,1);
count.percentage.data2= count.data2./repmat(sum(count.data2,1),6,1);

count.percentage.position1= 'B2';
count.percentage.position2= 'B6';

%Mean percentage count nuclei
count.mean.data3= mean(count.percentage.data1,2);
count.mean.data4= mean(count.percentage.data2,2);

count.mean.position3= [xlscol(size(count.data1,2)+2),'2'];
count.mean.position4= [xlscol(size(count.data2,2)+2),'6'];

%Std Deviation percentage count nuclei
count.SD.data3= std(count.percentage.data1,0,2);
count.SD.data4= std(count.percentage.data2,0,2);

count.SD.position3= [xlscol(size(count.data1,2)+3),'2'];
count.SD.position4= [xlscol(size(count.data2,2)+3),'6'];

%% Writing data in .xlsx

interval={};
interval.data1={'1';'2-5';'6+'};
interval.data2={'1';'2';'3';'4';'5';'6+'};
interval.position1='A2';
interval.position2='A6';

%SHEET 2
xlwrite([outputfolder,'/Results_',name,'.xlsx'],header_nb_nuclei.text,2,'A1');

xlwrite([outputfolder,'/Results_',name,'.xlsx'],{header_mean.text},2,header_mean.position);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],{header_SD.text},2,header_SD.position);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.SD.data1,2,count.SD.position1);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.SD.data2,2,count.SD.position2);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.mean.data1,2,count.mean.position1);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.mean.data2,2,count.mean.position2);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],interval.data1,2,interval.position1);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],interval.data2,2,interval.position2);



%SHEET 3
xlwrite([outputfolder,'/Results_',name,'.xlsx'],{'% of nuclei'},'% of nuclei','A1');

xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.percentage.data1,'% of nuclei',count.percentage.position1);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.percentage.data2,'% of nuclei',count.percentage.position2);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],{header_mean.text},'% of nuclei',header_mean.position);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],{header_SD.text},'% of nuclei',header_SD.position);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.mean.data3,'% of nuclei',count.mean.position3);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.mean.data4,'% of nuclei',count.mean.position4);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.SD.data3,'% of nuclei',count.SD.position3);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],count.SD.data4,'% of nuclei',count.SD.position4);

xlwrite([outputfolder,'/Results_',name,'.xlsx'],interval.data1,'% of nuclei',interval.position1);
xlwrite([outputfolder,'/Results_',name,'.xlsx'],interval.data2,'% of nuclei',interval.position2);

%% Functions

    function [b] = xlscol(a)
        
        %XLSCOL Convert Excel column letters to numbers or vice versa.
        %   B = XLSCOL(A) takes input A, and converts to corresponding output B.
        %   The input may be a number, a string, an array or matrix, an Excel
        %   range, a cell, or a combination of each within a cell, including nested
        %   cells and arrays. The output maintains the shape of the input and
        %   attempts to "flatten" the cell to remove nesting.  Numbers and symbols
        %   within strings or Excel ranges are ignored.
        %
        %   Examples
        %   --------
        %       xlscol(256)   % returns 'IV'
        %
        %       xlscol('IV')  % returns 256
        %
        %       xlscol([405 892])  % returns {'OO' 'AHH'}
        %
        %       xlscol('A1:IV65536')  % returns [1 256]
        %
        %       xlscol({8838 2430; 253 'XFD'}) % returns {'MAX' 'COL'; 'IS' 16384}
        %
        %       xlscol(xlscol({8838 2430; 253 'XFD'})) % returns same as input
        %
        %       b = xlscol({'A10' {'IV' 'ALL34:XFC66'} {'!@#$%^&*()'} '@#$' ...
        %         {[2 3]} [5 7] 11})
        %       % returns {1 [1x3 double] 'B' 'C' 'E' 'G' 'K'}
        %       %   with b{2} = [256 1000 16383]
        %
        %   Notes
        %   -----
        %       CELLFUN and ARRAYFUN allow the program to recursively handle
        %       multiple inputs.  An interesting side effect is that mixed input,
        %       nested cells, and matrix shapes can be processed.
        %
        %   See also XLSREAD, XLSWRITE.
        %
        %   Version 1.1 - Kevin Crosby
        
        % DATE      VER  NAME          DESCRIPTION
        % 07-30-10  1.0  K. Crosby     First Release
        % 08-02-10  1.1  K. Crosby     Vectorized loop for numerics.
        
        % Contact: Kevin.L.Crosby@gmail.com
        
        base = 26;
        if iscell(a)
            b = cellfun(@xlscol, a, 'UniformOutput', false); % handles mixed case too
        elseif ischar(a)
            if ~isempty(strfind(a, ':')) % i.e. if is a range
                b = cellfun(@xlscol, regexp(a, ':', 'split'));
            else % if isempty(strfind(a, ':')) % i.e. if not a range
                b = a(isletter(a));        % get rid of numbers and symbols
                if isempty(b)
                    b = {[]};
                else % if ~isempty(a);
                    b = double(upper(b)) - 64; % convert ASCII to number from 1 to 26
                    n = length(b);             % number of characters
                    b = b * base.^((n-1):-1:0)';
                end % if isempty(a)
            end % if ~isempty(strfind(a, ':')) % i.e. if is a range
        elseif isnumeric(a) && numel(a) ~= 1
            b = arrayfun(@xlscol, a, 'UniformOutput', false);
        else % if isnumeric(a) && numel(a) == 1
            n = ceil(log(a)/log(base));  % estimate number of digits
            d = cumsum(base.^(0:n+1));   % offset
            n = find(a >= d, 1, 'last'); % actual number of digits
            d = d(n:-1:1);               % reverse and shorten
            r = mod(floor((a-d)./base.^(n-1:-1:0)), base) + 1;  % modulus
            b = char(r+64);  % convert number to ASCII
        end % if iscell(a)
        
        % attempt to "flatten" cell, by removing nesting
        if iscell(b) && (iscell([b{:}]) || isnumeric([b{:}]))
            b = [b{:}];
        end % if iscell(b) && (iscell([b{:}]) || isnumeric([ba{:}]))
        
        
        
        
        
        
    end



end


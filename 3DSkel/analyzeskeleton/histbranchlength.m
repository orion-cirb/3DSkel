function [count,interval,fig1,h] = histbranchlength(branchinfo,threshold,display)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% bins : intervals of branch length
% values : #Branches

global FileName
global outputfolder
step=20;
h=[];
fig1=[];
branchlength_idx= branchinfo(:,3)>threshold;
branchlength= branchinfo(branchlength_idx,3);
maxlength= max(branchlength);
edges= 0:step:maxlength+step;
[count,bins]=histc(branchlength,edges);

for i=1:length(edges)-1
    interval{i,:}=['[',num2str(edges(i)),' ',num2str(edges(i+1)),']'];
end
%cla reset;



if strcmpi(display,'on')
    h=bar(edges(1:end-1),count(1:end-1));
    xlim([-step/2 edges(end-1)+step/2]);
    set(gca, 'XTickLabel', interval, 'XTick',edges(1:end-1),'FontSize',6);
    xlabel('Branch Length (µm)','FontSize',8);
    ylabel('# Branches','FontSize',8);
    
%     fig1 = figure(2);
%     set(fig1,'Name','histo');
%     cla(fig1);
%     bar(edges(1:end-1),count(1:end-1));
%     xlim([-step/2 edges(end-1)+step/2]);
%     set(gca, 'XTickLabel', interval, 'XTick',edges(1:end-1),'FontSize',6);
%     xlabel('Branch Length (µm)','FontSize',8);
%     ylabel('# Branches','FontSize',8);
%     if ismac
%         saveas(fig1,[pwd,'/temp/histo.fig']);
%         saveas(fig1,[outputfolder,'/','HISTO_',FileName(1:end-4),'.fig']);
%     else
%         saveas(fig1,[pwd,'\temp\histo.fig']);
%         saveas(fig1,[outputfolder,'\','HISTO_',FileName(1:end-4),'.fig']);
%     end
end


count= count(1:end-1);

end


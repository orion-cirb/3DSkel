function [] = DisplaySkeleton(skel, skel2, node2, link2, parameters)
%DISPLAYSKELETON Display skeleton and nodes
%   Save the figures in the "Results" folder
global outputfolder
global FileName
skel_rejected= skel2-skel;
%% 
disp('Display Skeleton...');

%fig1 = figure('Visible', 'on');
fig1 = figure(1);
set(fig1,'Name','1');
cla(fig1);

axis on;
lighting phong;
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
hold on;
w=size(skel2,1);
l=size(skel2,2);
h=size(skel2,3);
[x,y,z]=ind2sub([w,l,h],find(skel2(:)));
[x2,y2,z2]=ind2sub([w,l,h],find(skel_rejected(:)));
hold on
plot3(y.*parameters.voxelwidth.resizemaskY,x.*parameters.voxelwidth.resizemaskX,z.*parameters.voxelwidth.Z,'square','Markersize',1.5,'MarkerFaceColor','r','Color','r');
plot3(y2.*parameters.voxelwidth.resizemaskY,x2.*parameters.voxelwidth.resizemaskX,z2.*parameters.voxelwidth.Z,'square','Markersize',2,'MarkerFaceColor','b','Color','b');
hold off
set(gcf,'Color','white');
view(45,45)

%% display result (nodes & links)

hold on;
for i=1:length(node2)
    x1 = node2(i).comx;
    y1 = node2(i).comy;
    z1 = node2(i).comz;
    
    if(node2(i).ep==1)
        ncol = 'c';
    else
        ncol = 'y';
    end;
    
    plot3(y1.*parameters.voxelwidth.resizemaskY,x1.*parameters.voxelwidth.resizemaskX,z1.*parameters.voxelwidth.Z,'o','Markersize',9,...
        'MarkerFaceColor',ncol,...
        'Color','k');
end;
hold off
view(45,45)
if ismac
    %saveas(fig1,[pwd,'/temp/fig1.fig']);
    saveas(fig1,[outputfolder,'/',FileName(1:end-4),'.fig']);
else
    %saveas(fig1,[pwd,'\temp\fig1.fig']);
    saveas(fig1,[outputfolder,'\',FileName(1:end-4),'.fig']);
end

end


function [skel2, skel, node2, link2] = ProcessingSkeleton(skel,parameters)
% Process skeleton using Skel2Graph3D
%
% Calculate the network graph of a 3D voxel skeleton
%   Downloaded at :
%   https://fr.mathworks.com/matlabcentral/fileexchange/43527-skel2graph-3d
%
%[skel2,results] = ProcessingSkeleton(skel, parameters)
%
%Input : 
%   - skel (type char or logical or []) : skeleton or file path
%   - parameters (type struct) : pixel_width (width of a pixel in µm), 
%                                THR (threshold length for the skeleton analysis)
%Output :
%   - skel2 (type logical) : new skeleton after branch length thresholding
%   - results (type struct) : node
%clc;
global FileName

%% Analyze the skeleton (Graph structure)

disp('Processing Skeleton...');

%Stack size (width, length, height)
w = size(skel,1);   
l = size(skel,2);
h = size(skel,3);

% initial step: condense, convert to voxels and back, detect cells
[~,node,link] = Skel2Graph3D(skel,parameters.THR_pixel);

% total length of network
wl = sum(cellfun('length',{node.links}));

skel2 = Graph2Skel3D(node,link,w,l,h);
[A2,node2,link2] = Skel2Graph3D(skel2,parameters.THR_pixel);

% calculate new total length of network
wl_new = sum(cellfun('length',{node2.links}));
i=1;
% iterate the same steps until network length changed by less than 0.5%
while(wl_new~=wl)
    i=i+1;
    fprintf('Iteration %1d...\n',i);
    wl = wl_new;   
    skel2 = Graph2Skel3D(node2,link2,w,l,h);
    [A2,node2,link2] = Skel2Graph3D(skel2,parameters.THR_pixel);
    wl_new = sum(cellfun('length',{node2.links}));
    if i>10
        disp('WARNING : too many iteratitions... aborted');
        break;
    end
end;

disp('Done.');
%% Skeleton Analysis
% %Skeleton length (µm)
% skeleton_length= full(sum(A2(:)))*parameters.voxel_width.XY/2;  
% fprintf('skeleton length = %6.1f µm \n', skeleton_length);
% 
% % endpoint_idx= find([node.ep]);
% nb_branchpoints= length(find([node2.ep]==0));
% nb_branches= length(link2);
% 
% % [n,m,branch]=find(A2);
% % U2 = triu(A2)
% % [n2,m2,branch2]=find(U2);
% % 
% % A2_temp=A2;
% % newtotal=1;
% % for i=1:length(A2)
% %     for j=1:i
% %         if full(A2_temp(i,j))~=0
% %             diff=1;
% %             newtotal= sum(sum(A2(:,j)))+sum(sum(A2(i,:)))-sum(sum((A2(i,j))));
% %             while diff~= 0
% %                 total= newtotal;
% %                 j2_tmp=[];
% %                 i2_tmp=[];
% %                 j1_tmp=[];
% %                 i1_tmp=[];
% %                 for k=1:length(i)
% %                     tmp1= find(n==i(k));
% %                     j1= m(tmp1);
% %                     j1_tmp= vertcat(j1_tmp,j1);
% %                     i1_tmp= vertcat(i1_tmp, i(k).*ones(length(j1),1));
% %                 end
% %                 for k=1:length(j)
% %                     tmp2= find(m==j(k));
% %                     i2= n(tmp2);
% %                     i2_tmp= vertcat(i2_tmp,i2);
% %                     j2_tmp= vertcat(j2_tmp, j(k)*ones(length(i2),1));
% %                 end
% %                 i=i2_tmp;
% %                 j=j1_tmp;
% %                 XY1= unique([i1_tmp j1_tmp],'rows')
% %                 XY2= unique([i2_tmp j2_tmp],'rows')
% %                 newtotal= sum(sum(A2(XY1(:,1),XY1(:,2)))) + sum(sum(A2(XY2(:,1),XY2(:,2))));
% %                 %newtotal= branch(n==XY2(:,1)) + branch(XY2(:,1))
% %                 diff= newtotal - total;
% %             end
% %             
% %             S=0;
% %             for k=1:length(XY1)
% %                 S= S+ A2(XY1(k,1),XY1(k,2)) %Sum of each branch length of 1 independant skeleton
% %             end
% %             
% %             
% %             A2_temp(:,XY1(:,1))=0;
% %             A2_temp(:,XY1(:,2))=0;
% %             A2_temp(XY1(:,1),:)=0;
% %             A2_temp(XY1(:,2),:)=0;
% %             
% %         end
% %     end
% % end
% %     
%  
% 
% 
% 
% 
% 
% % endpoint= node(endpoint_idx);
% 
% results.total_length= skeleton_length;

%results.branch_length= A2;
%results.node= node2;
%results.link= link2;



end


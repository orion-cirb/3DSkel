function [corrected] = getrealbranches(branchinfo,results,threshold)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
threshold
idx= branchinfo(:,3)>threshold;
data2=branchinfo(idx,:);
nb_skel= data2(end,2);
%for i=1:nb_skel
for i=1:branchinfo(end,2)
    idx_length = branchinfo(:,2)==i;
    skellength(i,:)= sum(branchinfo(idx_length,3));
    nbbranches(i,:)= length(find(branchinfo(:,2)==i));
    nbrealbranches(i,:)= length(find(data2(:,2)==i));
end
nbbranches
nbrealbranches
results(:,3)
nbrejectedbranches= (nbbranches(:)-nbrealbranches(:))
nbrealjunctions= results(:,3) - nbrejectedbranches;
corrected = cat(2,skellength,nbrealbranches,nbrejectedbranches,nbrealjunctions);
end


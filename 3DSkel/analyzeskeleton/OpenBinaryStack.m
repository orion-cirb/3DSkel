function stack = OpenBinaryStack(FileTif)
%Open a stack from single images
%   input : FileTif (dim 1, type string)
%   output : stack (dim 3, type uint16)
%   Concatenate all the images into a stack

disp(' 1) Load images ...');
disp(FileTif);
if nargin == 0
    
end
InfoImage= imfinfo(FileTif);
mImage= InfoImage(1).Width;
nImage= InfoImage(1).Height;
NumberImages= length(InfoImage);
stack= false(nImage,mImage,NumberImages);

for i=1:NumberImages
    temp= imread(FileTif,'Index',i,'Info',InfoImage); %Open a stack
    stack(:,:,i)= logical(temp);
end

end


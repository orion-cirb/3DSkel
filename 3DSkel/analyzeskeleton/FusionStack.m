function unistack = FusionStack(stack,nbXregions,nbYregions,nbZregions,margin)
%Regionize a stack into substacks
%   input : stack (dim 3, type unit16)
%           nbXregions (dim 1, type integer)
%           nbYregions (dim 1, type integer)
%           nbZregions (dim 1, type integer)
%   output : multistack (dim 3, type cell)
%   Create a stack composed of substacks

global nb_pixel_x nb_pixel_y nb_slice_z

multistack={};  %Initialisation of the cell

for k=1:nbZregions
    for j= 1:nbXregions
        for i= 1:nbYregions
            
            stack2= stack{j,i,k};
            ImgWidth= size(stack2,2);
            ImgHeight = size(stack2,1);
            ImgDepth = size(stack2,3);
            
            if nbXregions==1
                increment_x= 1 : ImgHeight;
            elseif j==1
                increment_x= 1 : ImgHeight - margin ;
            elseif 1<j && j<nbXregions
                increment_x= 1 + margin +1 : ImgHeight - margin ;
            elseif j==nbXregions
                increment_x= 1 + margin  : ImgHeight ;
            end
            
            if nbYregions==1
                increment_y= 1 : ImgWidth;
            elseif i==1
                increment_y= 1 : ImgWidth - margin ;
            elseif 1<i && i<nbYregions
               increment_y= 1 + margin +1 : ImgWidth - margin ;
            elseif i==nbYregions
                increment_y= 1 + margin : ImgWidth ;
            end
            
            increment_z= (k-1)*nb_slice_z +1 : k*nb_slice_z;
                        
            multistack{j,i,k}= stack2(increment_x,increment_y,increment_z);
      
        end
    end
end

unistack= cell2mat(multistack);

end


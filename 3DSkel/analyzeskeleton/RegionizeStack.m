function multistack = RegionizeStack(stack,nbXregions,nbYregions,nbZregions,margin)
%Regionize a stack into substacks
%   input : stack (dim 3, type unit16)
%           nbXregions (dim 1, type integer)
%           nbYregions (dim 1, type integer)
%           nbZregions (dim 1, type integer)
%   output : multistack (dim 3, type cell)
%   Create a stack composed of substacks
global nb_pixel_x nb_pixel_y nb_slice_z

ImgWidth= size(stack,2);
ImgHeight = size(stack,1);
ImgDepth = size(stack,3);

multistack={};  %Initialisation of the cell

for k=1:nbZregions
    for j= 1:nbXregions
        for i= 1:nbYregions
            
            nb_pixel_x= ImgHeight/nbXregions;    %Nb of pixels along x-axis for each substack
            nb_pixel_y= ImgWidth/nbYregions;     %Nb of pixels along y-axis for each substack
            nb_slice_z= floor(ImgDepth/nbZregions);     %Nb of pixels along z-axis for each substack
            
            if nbXregions==1
                increment_x= (j-1)*floor(nb_pixel_x) + 1 : j*floor(nb_pixel_x);
            elseif j==1
                increment_x= (j-1)*floor(nb_pixel_x) + 1 : j*floor(nb_pixel_x) + margin;
            elseif 1<j && j<nbXregions
                increment_x= (j-1)*floor(nb_pixel_x) - margin : j*floor(nb_pixel_x) + margin;
            elseif j==nbXregions
                increment_x= (j-1)*floor(nb_pixel_x) - margin +1 : ImgHeight;%j*floor(nb_pixel_x);
            end
            
            if nbYregions==1
                increment_y= (i-1)*floor(nb_pixel_y) + 1 : i*floor(nb_pixel_y);
            elseif i==1
                increment_y= (i-1)*floor(nb_pixel_y) + 1 : i*floor(nb_pixel_y) + margin;
            elseif 1<i && i<nbYregions
                increment_y= (i-1)*floor(nb_pixel_y) - margin : i*floor(nb_pixel_y) + margin;
            elseif i==nbYregions
                increment_y= (i-1)*floor(nb_pixel_y) - margin +1 : ImgWidth;%i*floor(nb_pixel_y);
            end
            
            increment_z= (k-1)*nb_slice_z +1 : k*nb_slice_z;
            
            multistack(j,i,k)= {stack(increment_x,increment_y,increment_z)};   
            
        end
    end
end

end


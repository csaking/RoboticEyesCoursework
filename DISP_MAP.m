function [outImage] = disp_map(file1path, file2path, filex, filey, patchx, patchy, test)

%reference filepaths to the images from parameters%
file1path = dir(file1path);
file2path = dir(file2path);

%Reads in images based on specified paths%
File1 = imread(strcat(file1path(1).folder, '\', file1path(1).name));
File2 = imread(strcat(file2path(1).folder, '\', file2path(1).name));

%greyscale
try
    File1 = rgb2gray(File1);

    File2 = rgb2gray(File2);
catch
    disp("image is already gray");
end
 
%image flipped after grayscale
imagey = filex - patchy*3;
imagex = filey - patchx*3;

pixremaining = imagex*imagey;
outImage = [filex,filey];

if test == 0
    for(i = patchy*3+1:imagey)
        for(j = patchx*3+1:imagex)
            disp(pixremaining + " pixels remaining for Disparity Map")
           [out1,out2,dispVec]=PIXEL_DISP(File1,File2,filex,filey,j,i,patchx,patchy)
           pixremaining = pixremaining-1;       
           outImage(j,i) = dispVec;
        end
    end
    for i = imagey:filex
        for j = imagex:filey
            outImage(j, i) = 0;
        end
    end
else
    outImage = disparity(File1,File2)*5;
end

disparityRange = [0,40];
figure
        
       imshow(outImage, disparityRange);
       title('Disparity Map')
       colormap('gray')
       colorbar
       
disp('Done')

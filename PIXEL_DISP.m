function [OutputCoord, MinValue, DispVal] = pixel_disp(File1, File2, filex, filey, pixx, pixy, patchx, patchy)

%Variables Needed to determine patch around pixel
halfPatchX = (patchx-1)/2;
halfPatchY = (patchy-1)/2;

%Creation of a patch
Patch = File1((pixx - halfPatchX):(pixx + halfPatchX), (pixy - halfPatchY):(pixy + halfPatchY));

%Variables needed for a search area
SearchAreaLength = patchx * 3;

%Creation of the search area
%If else used to shrink or expand area depending on how close to edge
%search area is
SearchArea = File2(pixx-SearchAreaLength:pixx+SearchAreaLength,(pixy - SearchAreaLength):(pixy + SearchAreaLength));

%Recursivley Find values for search area
for j = halfPatchY+1:(SearchAreaLength)-halfPatchY
    for i = halfPatchX+1:(SearchAreaLength)-halfPatchX
        OutValues(i-halfPatchX, j-halfPatchY) = SUPPORT_CMP(Patch, SearchArea(i-halfPatchX:i+halfPatchX,j-halfPatchY:j+halfPatchY), patchx, patchy);
    end
end

%Find minimum Support_cmp value and iteration index(i value in for loop) it occured at
[MinValues, Indexes] = min(OutValues);
[MinValue,OutX] = min(MinValues);
[OutX, OutY] = find(OutValues == MinValue);

OutX = pixx + OutX;
OutY = pixy + OutY;

DispVal=abs(pdist2([OutX(1), OutY(1)],[pixx, pixy],'euclidean'));
        
OutputCoord = [pixx,pixy];
    





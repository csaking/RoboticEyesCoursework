function [model] = triangulate(patchx, patchy, test)

lengthx = 256;
lengthy = 256;

baseOffset = 1000;
cameraFocalLength = 0.5;
heightConstant = 1000;

if test == 2
    dispMapExamplePath = dir('C:\Users\craig\Desktop\RobotEyes\Test');
    disparityMap = imread(strcat(dispMapExamplePath(3).folder, '\', dispMapExamplePath(3).name));
else
    disparityMap = DISP_MAP('C:\Users\craig\Desktop\RobotEyes\Test\pentagon_left.bmp', 'C:\Users\craig\Desktop\RobotEyes\Test\pentagon_right.bmp', lengthx, lengthy, patchx, patchy, test);
end

lengthadjy = lengthx - (patchx*5)-1;
lengthadjx = lengthy - (patchy*5)-1;

remaining = lengthadjy*lengthadjx;

for (i = 10:lengthadjx)
    for (j = 10:lengthadjy)
        dispValue = disparityMap(i,j);
        disp(remaining + " pixels remaining for Depth Map");
        if dispValue > 0
            D = (baseOffset*cameraFocalLength)/dispValue;
        else
            D = 0;
        end
        remaining = remaining-1;
        model(i,j) = D;
    end
end

figure
mesh(model)
title('Depth Map')
colormap('gray')



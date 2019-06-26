function SUPPORT_CMP = support_cmp(File1, File2, height, width)


%SSD difference Between images
ssd=0;
for i = 1:height
    for j = 1:width
        diff = File1(i,j) - File2(i,j);
        square = diff*diff;
        ssd = double(ssd)+double(square);
    end
end

SUPPORT_CMP = ssd;

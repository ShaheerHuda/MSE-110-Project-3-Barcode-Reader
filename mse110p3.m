clc
close all


%M = noisy_C(1100,:);
datalog = datalog111(:,2);
arraydatalog = table2array(datalog);
arrayM = transpose(arraydatalog);
M = uint8(arrayM);

% Convert the image to grayscale
if size(M, 3) == 3 % Check if the image is colored
    M = rgb2gray(M);
end

img_length = length(M);


% Give each pixel a 1=white or 0=black
for i = 1:img_length
    if M(i) > 30
        M(i) = 0;
    else
        M(i) = 1;
    end
end

% Find first black line in code
startValue = 1;
for i = 1:img_length
    if M(i) == 1 && M(i+1) == 1
        startValue = i;
        break
    end
end

% Find last black line

endValue = 1;
j = img_length;
while(true)
    if M(j) == 1 && M(j-1) == 1
        endValue = j;
        break
    end
    j = j-1;
end

disp(startValue)
disp(endValue)
lengthBarcode = endValue - startValue;
lengthThreshold = lengthBarcode / 9;
binaryBar = zeros(1,9);


i = startValue;
j = 1;
k = 1;

while(i < endValue)
    while(M(i) == 1)
        if(i >= endValue)
            break
        end
        j = j+1;
        i = i + 1;
    end
    

    if(j > lengthThreshold)
        binaryBar(k) = 1;
        binaryBar(k + 1) = 1;
        k = k + 2;
    else
        binaryBar(k) = 1;
        k = k+1;
    end
    j = 1;

    
    %
    while(M(i) == 0)
        if(i >= endValue)
            break
        end
        j = j+1;
        i = i + 1;
    end

    if(j > lengthThreshold)
        binaryBar(k) = 0;
        binaryBar(k + 1) = 0;
        k = k + 2;
    else
        binaryBar(k) = 0;
        k = k + 1;
    end
    j = 1;

end

binaryBar(13) = [];
disp(binaryBar); 
singleCellBinary = str2double(sprintf('%d', binaryBar));

% Import the Lookup table
LookupTable = readtable('LookupTable.xlsx');
Characters = table2array(LookupTable(:,1));

letterC = LookupTable{13, 2};
disp(letterC)


for i = 1:44
    % Check if binaryBar matches the current cell
    if singleCellBinary == LookupTable{i, 2}
        break; 
    end
end

disp(Characters{i});





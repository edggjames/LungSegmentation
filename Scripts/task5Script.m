clear % To clear out memory
close all %To close all active figures
opengl software %To avoid MATLAB crashing due to low-level graphics errors

%To read in the baseline CT image (using example function from lecture) as
%per code from task 1
%NB - again img_dims is not needed here
[V, vox_dims]=readNiftiImage('baseline_CT.nii');

%to convert V to logical array by using element wise comparison 
%thresholding:
%1)a voxel is true if it satisfies both conditions of having an intensity
%larger than the lower threshold of -900 AND smaller than the upper
%threshold of -500
%2) false otherwise (i.e. less than -900 OR more than -500)
V = V>-900 & V<-500;

%To plot coronal slice 256 of binary image as per code used in task 1
figure(7)
imagesc(squeeze(V(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1])
colormap(gray)
%to turn off x and y axis labelling as per example in question
set(gca, 'XTick',[],'YTick',[]);

%To identify the connected components 'CC' of the binary image with a
%3D connectivity of 6
CC = bwconncomp(V,6);

clear V %To clear unnecessary data from workspace and free up memory

%Then to pick out and label the two largest connected components:
%First form a structure called 'measure' which details the size of all the
%different areas of connected components using the region properties 
%function
measure = regionprops(CC, 'Area');
%convert the data in the area field of measure structure into a vector
area=[measure.Area];
area_desc=sort(area,'descend');% sort this vector into descending order
area_desc=area_desc(1:2); %extract the first two elements only
%The areas of the right and left lung will then correspond to the two
%components of 'area_desc'
%Then create a label matrix to label all the connected groups of voxels 
%in CC with a unique integer identifier
label = labelmatrix(CC);
%Then find the element of area which is equal to the largest element of
%area_desc
element = find(area == area_desc(1));
%All the voxels labelled with this element then belong to the largest lung
V_largest = ismember(label,element);
%Then find the element of area which is equal to the second largest element
%of area_desc
element = find(area == area_desc(2));
%All the voxels labelled with this element then belong to the second 
%largest lung
V_second_largest = ismember(label,element);

%To clear unnecessary data from workspace and free up memory
clear area area_desc CC label measure element

figure(8) %To plot the largest connected component (the right lung)
imagesc(squeeze(V_largest(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray)
%to turn off x and y axis labelling as per example in question
set(gca, 'XTick',[],'YTick',[])

figure(9) %To plot the second largest connected component (the left lung)
imagesc(squeeze(V_second_largest(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray)
%to turn off x and y axis labelling as per example in question
set(gca, 'XTick',[],'YTick',[])

%To perform morphological closing:
%First produce 3D ball structuring element 'SE' with a radius of 10 using
%function from task 4
SE = produce3DballSE(10);
%Then apply this to the two binary images of the lungs using the 'imclose'
%function
V_largest_closed = imclose(V_largest,SE);
V_second_largest_closed = imclose(V_second_largest,SE);

%To clear unnecessary data from workspace and free up memory
clear V_largest V_second_largest

%To plot the largest connected component (the right lung) having been
%morphologically closed
figure(10)
imagesc(squeeze(V_largest_closed(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray)
set(gca, 'XTick',[],'YTick',[])

%To plot the second largest connected component (the left lung) having been
%morphologically closed
figure(11)
imagesc(squeeze(V_second_largest_closed(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray)
set(gca, 'XTick',[],'YTick',[])

clear vox_dims %To clear unnecessary data from workspace and free up memory

%To check results match data from task 2:
%To load the baseline lung image data from task 2 for both lungs
load lung_masks.mat
clear followup_left_lung followup_right_lung
%To compare in if else statements
if isequal(V_largest_closed,baseline_right_lung)
    disp('Results for right baseline lung DO match data from task 2');
else
    disp('Results for right baseline lung DO NOT match data from task 2');
end
if isequal(V_second_largest_closed,baseline_left_lung)
    disp('Results for left baseline lung DO match data from task 2');
else
    disp('Results for left baseline lung DO NOT match data from task 2');
end


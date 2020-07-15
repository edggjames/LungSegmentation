%To clear out memory and close active figures
close all
clear

opengl software %To avoid MATLAB crashing due to low-level graphics errors

%To read in the baseline CT image (using example function from lecture) and
%storing 2 variables in the memory:
%V = a 3D array containing the image data
%vox_dims = a 3 element vector containing the voxel dimensions in mm
%terms of number of voxels/slices
%NB - img_dims is not imported into workspace as it is not needed in this
%script
[V, vox_dims]=readNiftiImage('baseline_CT.nii');

%To display coronal slice 256 from baseline CT scan
figure(1);
%Select slice 256 from the second dimension of V data
%Obtain a 2D slice use the squeeze command to remove singular dimensions 
%from the array and plot using the 'image scale' function to display image 
%with scaled colours
%The transpose operator is used to flip the axes so that the first 
%dimension of the image is shown on the x-axis
imagesc(squeeze(V(:,256,:))');
%To invert the y axis so that it runs in correct orientation (i.e. inferior
%at the bottom, and superior at the top)
axis xy
%Use the 'data aspect ratio' function to scale the axes correctly -
%the first voxel dimension is horizontal so goes first (i.e. 'left-right')
%and the third voxel dimension is vertical so goes second here 
%(i.e.'superior-inferior')
%The third aspect is simply scaled to 1 as this is a 2D image
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray); %To display the image in grey scale and add a title
title('Baseline CT');

%To read in the follow up CT scan (using example function from lecture)
%and replace data in workspace memory with new image data:
[V, vox_dims]=readNiftiImage('followup_CT.nii');

%To display coronal slice 256 from follow up CT scan
%As before, but create new figure, change variable names and change title
figure(2);
imagesc(squeeze(V(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray);
title('Follow Up CT');

%to save voxel dimension data for further tasks 
clear V
save vox_dims.mat vox_dims
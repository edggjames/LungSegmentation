clear % To clear out memory
close all %To close all active figures
opengl software %To avoid MATLAB crashing due to low-level graphics errors

% To read in the followup CT image (using example function from lecture),
% NB 'img_dims' is required here
[V,vox_dims,img_dims]=readNiftiImage('followup_CT.nii');

%To run lung segmentation function on followup lung data with a structuring
%element of radius 10, display the output as figures 12 & 13, and time how
%long this function takes using 'tic toc', and storing this as 'time_10'.
%'V1_10' will represent the largest connected component, and 'V2_10' will
%represent the second largest connected component
tic
[V1_10, V2_10] = lungSEG(V,-900,-500,10,vox_dims,12,13);
time_10=toc;

%To check results match data from task 2:
%Load the followup lung image data from task 2 for both lungs
load lung_masks.mat
clear baseline_left_lung baseline_right_lung
%To compare in if else statements (this time the left lung is the largest
%connected component, and the right lung is the second largest connectecd
%component)
if isequal(V2_10,followup_right_lung)
    disp('Results for right follow up lung DO match data from task 2');
else
    disp('Results for right follow up lung DO NOT match data from task 2');
end
if isequal(V1_10,followup_left_lung)
    disp('Results for left follow up lung DO match data from task 2');
else
    disp('Results for left follow up lung DO NOT match data from task 2');
end

%To clear unnecessary data from workspace and free up memory
clear followup_left_lung followup_right_lung

%To run lung segmentation function on followup lung data with a structuring
%element of radius 5, display the output as figures 14 & 15, and time how 
%long this function takes (time_5), outputing results as 'V1_5' & 'V2_5'
tic
[V1_5,V2_5] = lungSEG(V,-900,-500,5,vox_dims,14,15);
time_5=toc;

%To display the results of timing the two above functions on screen using
%formatted text to two decimal places (%.2f)and inserting new lines where 
%appropriate (\n)
fprintf(['\nThe lung segmentation function takes %.2fs to run using a', ...
    ' radius of 10.\nThe lung segmentation function takes %.2fs  to run', ...
    ' using a radius of 5.'],time_10,time_5)

%To clear unnecessary data from workspace and free up memory
clear time_10 time_5

% To loop through all the coronal slices of the image and display in
% sequence with lung segmentations from above functions overlaid
for n = 1:img_dims(2)
%clear contents of current figure without closing it (apart from during 
%first loop), to speed up sequence of displaying slices
if n > 1 
    clf
end
%To acquire coronal slice n from follow up scan as per task 1
figure(16)
V_slice=squeeze(V(:,n,:))';
imagesc(V_slice);
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray);
set(gca, 'XTick',[],'YTick',[])
hold on
%Then select the nth slices from V1_10 and V2_10
V1_10_slice=squeeze(V1_10(:,n,:))';
V2_10_slice=squeeze(V2_10(:,n,:))';
%And then select the nth slices from V1_5 and V2_5
V1_5_slice=squeeze(V1_5(:,n,:))';
V2_5_slice=squeeze(V2_5(:,n,:))';
%To convert these four slices to outlines of lung segmentation and
%superimpose them onto V_slice:
%First create a cell array called 'B' which contains the boundary
%coordinates of all objects in the slice V1_10_slice (searching for only
%object boundaries (not hole boundaries too) as this will provide better
%performance and a better aesthetic outcome)
B = bwboundaries(V1_10_slice,'noholes');
%Then loop through all the matrices in each cell of B and plot each matrix
%in cyan with a linewith of 0.5
for m = 1:length(B) %use 'm' as counter
   boundary = B{m}; %to extract data from each cell into matrix form
   plot(boundary(:,2), boundary(:,1), 'cyan', 'LineWidth', 0.5)
%(NB - the number of lines plotted in this loop corresponds to the number
%of matrices in B, this can be zero or more than 1 (depending on the slice
%and lung anatomy)
end
%Repeat this for the second radius 10 result
B = bwboundaries(V2_10_slice,'noholes');
for m = 1:length(B)
   boundary = B{m};
   plot(boundary(:,2), boundary(:,1), 'cyan', 'LineWidth', 0.5)
end
%Repeat for the radius 5 results using magenta
B = bwboundaries(V1_5_slice,'noholes');
for m = 1:length(B)
   boundary = B{m};
   plot(boundary(:,2), boundary(:,1), 'magenta', 'LineWidth', 0.5)
end
B = bwboundaries(V2_5_slice,'noholes'); %repeat for 'V2_5'
for m = 1:length(B)
   boundary = B{m};
   plot(boundary(:,2), boundary(:,1), 'magenta', 'LineWidth', 0.5)
end
% Pause for 0.1 seconds bewtween slices to allow visualisation of results
pause(0.1)
hold off
end


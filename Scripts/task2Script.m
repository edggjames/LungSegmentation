clear % To clear out memory
close all %To close all active figures
opengl software %To avoid MATLAB crashing due to low-level graphics errors
load lung_masks.mat % To load the data file containing the lung image data
load vox_dims.mat% To load voxel dimension data from task 1

%To display the left baseline lung
figure(3)
%to smooth the 3D data
baseline_left_lung_smooth = smooth3(baseline_left_lung);
%to apply a handle to the patch object
baseline_left_lung_h = patch(isosurface(baseline_left_lung_smooth,0.5));
%then use the isonormals function to compute isosurface isonormals to the
%smoothed volume (using the smoothed volume as the volume data, and the 
%handle as a patch) - this will create a nicer looking visualisation
isonormals(baseline_left_lung_smooth,baseline_left_lung_h);
%to set the edgecolour to none, and plot the lung in green when calling
%patch function
set(baseline_left_lung_h,'edgecolor','none','facecolor',[0 1 0]);
%setup view suitable for 3D visualisation, setting light
%object to a useful position and setting lighting to gouraud
camlight(-20,-60);
lighting gouraud
axis vis3d
%To scale the axes to account for the voxel dimensions
daspect(1./[vox_dims(2) vox_dims(1) vox_dims(3)]);
%To set appropriate axis limits
img_dims=size(baseline_left_lung);
axis([0 img_dims(2) 0 img_dims(1) 0 img_dims(3)])
view(-90,0); %to set the viewing angle appropriately

hold on %To display the right baseline lung in the same figure
baseline_right_lung_smooth = smooth3(baseline_right_lung);
baseline_right_lung_h = patch(isosurface(baseline_right_lung_smooth,0.5));
isonormals(baseline_right_lung_smooth,baseline_right_lung_h);
%to plot the lung in red
set(baseline_right_lung_h,'edgecolor','none','facecolor',[1 0 0]);
title('Baseline CT');
hold off

%To clear unnecessary data from workspace and free up memory
clear baseline_right_lung_smooth baseline_right_lung_h ... 
    baseline_left_lung_smooth baseline_left_lung_h

figure(4) %To display the left follow up lung in a new figure
followup_left_lung_smooth = smooth3(followup_left_lung);
followup_left_lung_h = patch(isosurface(followup_left_lung_smooth,0.5));
isonormals(followup_left_lung_smooth,followup_left_lung_h);
% to plot the left lung in green
set(followup_left_lung_h,'edgecolor','none','facecolor',[0 1 0]);
camlight(-20,-60);
lighting gouraud
axis vis3d
daspect(1./[vox_dims(2) vox_dims(1) vox_dims(3)]);
%to use the same axis limits for all figures
axis([0 img_dims(2) 0 img_dims(1) 0 img_dims(3)])
view(-90,0)

hold on %To display the right follow up lung in the same figure
followup_right_lung_smooth = smooth3(followup_right_lung);
followup_right_lung_h = patch(isosurface(followup_right_lung_smooth,0.5));
isonormals(followup_right_lung_smooth,followup_right_lung_h);
%to plot the right lung in red
set(followup_right_lung_h,'edgecolor','none','facecolor',[1 0 0]);
title('Follow Up CT');
hold off

%To clear unnecessary data from workspace and free up memory
clear followup_right_lung_smooth followup_right_lung_h ... 
    followup_left_lung_smooth followup_left_lung_h

%To repeat the above procedure, but using a 9x9x9 box filter and swapping
%dimensions 1 and 2
figure(5)
%to swap dimensions 1 and 2 using the permute function
baseline_left_lung = permute(baseline_left_lung,[2 1 3]);
%to smooth the 3D data in a 9 x 9 x 9 box filter
baseline_left_lung_smooth = smooth3(baseline_left_lung,'box',9);
baseline_left_lung_h = patch(isosurface(baseline_left_lung_smooth,0.5));
isonormals(baseline_left_lung_smooth,baseline_left_lung_h);
%to plot the lung in green
set(baseline_left_lung_h,'edgecolor','none','facecolor',[0 1 0]);
camlight(-20,-60);
lighting gouraud
axis vis3d
%To scale the axes to account for the voxel dimensions, dimensions 1 and 2
%can now be reversed in daspect and also in axis limits
daspect(1./[vox_dims(1) vox_dims(2) vox_dims(3)]);
axis([0 img_dims(1) 0 img_dims(2) 0 img_dims(3)])
%to set the viewing angle appropriately to account for swapping dimensions 
%1 and 2
view(0,0)

hold on %To display the right baseline lung in the same figure
baseline_right_lung = permute(baseline_right_lung,[2 1 3]);
baseline_right_lung_smooth = smooth3(baseline_right_lung,'box',9);
baseline_right_lung_h = patch(isosurface(baseline_right_lung_smooth,0.5));
isonormals(baseline_right_lung_smooth,baseline_right_lung_h);
%to plot the lung in red
set(baseline_right_lung_h,'edgecolor','none','facecolor',[1 0 0]);
title('Baseline CT');
hold off

%To clear unnecessary data from workspace and free up memory
clear baseline_right_lung_smooth baseline_right_lung_h ... 
    baseline_left_lung_smooth baseline_left_lung_h

figure(6) %To display the left follow up lung in a new figure
followup_left_lung = permute(followup_left_lung,[2 1 3]);
followup_left_lung_smooth = smooth3(followup_left_lung,'box',9);
followup_left_lung_h = patch(isosurface(followup_left_lung_smooth,0.5));
isonormals(followup_left_lung_smooth,followup_left_lung_h);
% to plot the left lung in green
set(followup_left_lung_h,'edgecolor','none','facecolor',[0 1 0]);
camlight(-20,-60);
lighting gouraud
axis vis3d
daspect(1./[vox_dims(1) vox_dims(2) vox_dims(3)]);
axis([0 img_dims(1) 0 img_dims(2) 0 img_dims(3)])
view(0,0)

hold on %To display the right follow up lung in the same figure
followup_right_lung = permute(followup_right_lung,[2 1 3]);
followup_right_lung_smooth = smooth3(followup_right_lung,'box',9);
followup_right_lung_h = patch(isosurface(followup_right_lung_smooth,0.5));
isonormals(followup_right_lung_smooth,followup_right_lung_h);
%to plot the right lung in red
set(followup_right_lung_h,'edgecolor','none','facecolor',[1 0 0]);
title('Follow Up CT');
hold off

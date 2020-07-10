clear % To clear out memory
close all %To close all active figures
load lung_masks.mat % To load the data file containing the lung image data
load vox_dims.mat % To load voxel dimension data from task 1

%To calculate the volume of a voxel in mm3, multiple the three voxel
%dimensions together
vox_vol=prod(vox_dims);
%To convert this volume to litres divide by 1,000,000
vox_vol=vox_vol*1e-6;

%To calculate the number of voxels in the baseline left lung, sum across
%all dimensions of the 3D logical array
bl_left_lung_vol=sum(baseline_left_lung(:));
%Multiply this by the volume of a voxel to arrive at volume of the baseline
%left lung in litres
bl_left_lung_vol=bl_left_lung_vol*vox_vol;

%Repeat the above for the other three lung volumes:
%baseline right lung volume
bl_right_lung_vol=sum(baseline_right_lung(:));
bl_right_lung_vol=bl_right_lung_vol*vox_vol;
%follow up left lung volume
fu_left_lung_vol=sum(followup_left_lung(:));
fu_left_lung_vol=fu_left_lung_vol*vox_vol;
%follow up right lung volume
fu_right_lung_vol=sum(followup_right_lung(:));
fu_right_lung_vol=fu_right_lung_vol*vox_vol;

%To clear unnecessary data from workspace and free up memory
clear baseline_left_lung baseline_right_lung ...
    followup_left_lung followup_right_lung vox_dims vox_vol
 
%To display the results on screen using formatted text to two decimal
%places (%.2f) inserting new lines where appropriate (\n)
fprintf(['\nVolume of lungs (in litres):\nBaseline:   left = %.2f,   ', ...
    'right = %.2f\nFollow Up:  left = %.2f,   right = %.2f'] ...
    ,bl_left_lung_vol,bl_right_lung_vol,fu_left_lung_vol,fu_right_lung_vol)

%To calculate the relative percentages of the baseline lung volumes
bl_total_lung_volume=bl_left_lung_vol+bl_right_lung_vol;
bl_left_lung_percent=100*bl_left_lung_vol/bl_total_lung_volume;
bl_right_lung_percent=100*bl_right_lung_vol/bl_total_lung_volume;

%To calculate the relative percentages of the follow up lung volumes
fu_total_lung_volume=fu_left_lung_vol+fu_right_lung_vol;
fu_left_lung_percent=100*fu_left_lung_vol/fu_total_lung_volume;
fu_right_lung_percent=100*fu_right_lung_vol/fu_total_lung_volume;

%To clear unnecessary data from workspace and free up memory
clear bl_left_lung_vol bl_right_lung_vol bl_total_lung_volume ...
 fu_left_lung_vol fu_right_lung_vol fu_total_lung_volume
 
%To display the lung volume percentages (%%) on screen using formatted text
%to the nearest integer (%.0f) inserting new lines where appropriate (\n)
fprintf(['\n\nVolume of each lung as %% of total lung volume:\n',...
    'Baseline:   left = %.0f%%,    ', ...
    'right = %.0f%%\nFollow Up:  left = %.0f%%,    right = %.0f%%\n\n'] ...
    ,bl_left_lung_percent,bl_right_lung_percent,fu_left_lung_percent,...
    fu_right_lung_percent)

function[V1,V2] = lungSEG(V,T_low, T_up, R, vox_dims, fig_1_num, fig_2_num)
%This function is based on the code from the script in task 5, which
%performs a lung segmentation on an image 'V'. 
%The image is first thresholded between upper and lower limits, and 
%the two largest connected components are then extracted (with a 3D 
%connectivity of 6).
%A 3D ball strucuturing element of radius R is then produced, which is used
%to morpholigcally close these two largest connected components. Coronal
%slice 256 of each of these images is then plotted.
%
%INPUTS 1) V = image to be segmented
%       2) T_low = lower threshold
%       3) T_up = upper threshold
%       4) R = radius of 3D ball structuring element
%       5) vox_dims = voxel dimensions (used to scale images correctly)
%       6) fig_1_num = figure number that largest connected component is
%       plotted in
%       7) fig_2_num = figure number that second largest connected
%       component is plotted in
%
%OUTPUTS 1) V1 = logical 3D matrix containing data for lung with largest
%        connected component, having been thresholded and morpholigcally
%        closed
%        2) V2 = logical 3D matrix containing data for lung with second 
%        largest connected component, having been thresholded and 
%        morpholigcally closed

V = V>T_low & V<T_up; %threshold V between lower and upper thresholds
CC = bwconncomp(V,6); %determine connected components
clear V %clear data from function workspace
measure = regionprops(CC, 'Area'); %measure areas in CC
area=[measure.Area]; %extract areas into a vector
area_desc=sort(area,'descend'); %sort into descending order 
area_desc=area_desc(1:2); %pick out biggest two areas
label = labelmatrix(CC); %label all voxels in CC with an identifier
element = find(area == area_desc(1)); %find position of largest area
V_largest = ismember(label,element); %allocate these to largest area
element = find(area == area_desc(2)); %find position of 2nd largest area
V_second_largest = ismember(label,element); % allocate this area
clear area area_desc CC label measure element % clear memory
SE = produce3DballSE(R); %produce structuring element with radius R
V1 = imclose(V_largest,SE); %perform morphological closing on both lungs 
V2 = imclose(V_second_largest,SE);
clear V_largest V_second_largest % clear memory
figure(fig_1_num) % plot largest lung in fig_1_num
imagesc(squeeze(V1(:,256,:))'); %plot coronal slice 256
axis xy %flip xy axis
daspect(1./[vox_dims(1) vox_dims(3) 1]); %scale axes correctly
colormap(gray) %this will effectively be black & white in binary image
set(gca, 'XTick',[],'YTick',[]) %remove numbers from both axes
figure(fig_2_num) % plot second largest lung in fig_2_num
imagesc(squeeze(V2(:,256,:))');
axis xy
daspect(1./[vox_dims(1) vox_dims(3) 1]);
colormap(gray)
set(gca, 'XTick',[],'YTick',[])
end


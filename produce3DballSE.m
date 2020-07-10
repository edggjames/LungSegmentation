function [SE] = produce3DballSE(R)
%A function which produces a 3D ball structuring element, which is a 3D
%logical array of dimension (2*R)+1 (i.e. always an odd number).
%The voxels of the structuring element are true if a voxel is within R 
%voxels of the central voxel,or they are false otherwise.
%   INPUT - "R" = radius of the ball.
%   OUTPUT - "SE" = 3D ball structuring element of radius R.

%Create a vector n representing the diameter of the sphere, going from
%negative radius to positive radius in increments of 1
n=-R:R;
%Use the meshgrid function to a create 3 3D arrays of dimension n for
%comparison, representing the three cartesian dimensions of the sphere
[X,Y,Z]=meshgrid(n,n,n);
clear n %as no longer required in function workspace
%use element wise arithmetic to set true the voxels which are within a 
%sphere of radius R, centred around the central voxel.
%The resultant 3D logical array is then the structuring element
SE = sqrt(X.^2+Y.^2+Z.^2) <= R;
end


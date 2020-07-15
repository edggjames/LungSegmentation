function [V, vox_dims, img_dims] = readNiftiImage(nifti_name)
%readNiftiImage: a function for reading a nifti image file
%
%INPUTS:    nifti_name - the name of the nifti file
%OUTPUTS:   V - a multi-dimensional array containing the image data
%           vox_dims - the dimensions of a voxel in mm
%           img_dims - the dimensions of the image

%open the file and return a file identifier% open the file and return a
%file identifier
fid = fopen(nifti_name);

%read the image dimensions which are stored as 8 short integers 40 bytes
%from the beginning of the file
fseek(fid,40,'bof');
img_dims = fread(fid,8,'short');

%read the datatype code which is stored as a single short integer 70 bytes
%from the beginning of the file
fseek(fid,70,'bof');
datatype_code = fread(fid,1,'short');

%create a string which contains the datatype
switch datatype_code
    case 2
        datatype_string = 'uint8';
    case 4
        datatype_string = 'int16';
    case 8
        datatype_string = 'int32';
    case 16
        datatype_string = 'float';
    case 64
        datatype_string = 'double';
    otherwise
        error('This datatype is not supported');
end

%read the voxel dimensions which are stored as 8 floating point numbers
%(single precision) 76 bytes from the beginning of the file
fseek(fid,76,'bof');
vox_dims = fread(fid,8,'float');

%remove the unnused dimensions from vox_dims and img_dims
%note - the first value in img_dims tells us how many dimensions are used
vox_dims = vox_dims(2:img_dims(1)+1);
img_dims = img_dims(2:img_dims(1)+1);

%now read the actual image data - this starts 352 bytes from the beginning
%of the file.
%Note - fread can only return a column vector or a 2D matrix - as the image
%could have 3 or more dimensions we will first read it into a column vector
%(of size prod(img_dims)) and then reshape it to have the correct size and
%shape
fseek(fid,352,'bof');
V = fread(fid,prod(img_dims),datatype_string);
V = reshape(V,img_dims');

%everything we need has been read so close the file
fclose(fid);
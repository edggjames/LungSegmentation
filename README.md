# LungSegmentation

This repository describes code that I have written to study changes in CT scans
of lungs before and after implementation of a treatment protocol. These changes
include size, shape and volume of the lungs.

Image_Stack_1.pdf contains the following output:
1) Coronal slices of baseline and follow up CT images (pages 1 and 2).
2) 3D visualisations of the lungs (red = right, green = left), with volume
   smoothing (pages 3,4,5 and 6).
3) A segmentation pipeline is then implemented by:
  3a) thresholding between 2 voxel intensity values (page 7 - baseline CT).
  3b) connected component analysis (pages 8 and 9 - baseline CT).
  3c) morphological closing using a 3D spherical structuring element, with a
     radius of:
      3ci)  10 voxels (pages 10 and 11 - baseline CT; pages 12 and 13 - follow up
          CT),
      3cii) 5 voxels (pages 14 and 15 - follow up CT).

Image_Stack_2.pdf contains coronal for the follow up images, but with the
outline of segmentation results overlaid on each slice (where cyan corresponds
to the radius 10 results, and magenta corresponds to the radius 5 results).

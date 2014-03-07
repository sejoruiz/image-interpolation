% Author: Sergio Ruiz
% Date: 07/03/2014
%   This file is part of imageInterpolations.

%    imageInterpolations is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.

%    imageInterpolations is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

%    You should have received a copy of the GNU General Public License
%    along with imageInterpolations.  If not, see <http://www.gnu.org/licenses/>.

function [ scaled_image ] = resizeBilinear( img, scale, gray )
%RESIZEBILINEAR Resizes a picture using bilinear interpolation
%   The function will take two args:
% img: Path to picture to be resized
% scale: The scaling factor that will be applied.
%   If the scaling factor is less than 1, the function will exit.
%   If the scaling factor is not an integer value, it will be rounded.
% gray: specifies if the incoming picture has to be converted to grayscale
% As output, it will return the variable that holds the new picture, and 
% will plot the original picture and the scaled one.
if scale <1
    error('scale parameter should be greater or equal than 1');
end
if gray==0
    image = im2double(imread(img));
else
    image = im2double(rgb2gray(imread(img)));
end

scale = round(scale);
im_size=size(image);
if size(im_size)== [1 2] %Grayscale picture compatible
    scaled_image = zeros(scale*im_size(1)-scale+1,scale*im_size(2)-scale+1,1);
    image = reshape(image,[im_size 1]);
else
    scaled_image = zeros(scale*im_size(1)-scale+1,scale*im_size(2)-scale+1,im_size(3));
end
scaledim_size=size(scaled_image);
% First, we set the original values to the new positions
    for i=1:im_size(1)
        for j=1:im_size(2)
            scaled_image(scale*i-scale+1,scale*j-scale+1,:)=image(i,j,:);     
        end
    end

% Then we interpolate the points inside each cell leaving the borders of
% the cell to the next step. First in x:
for i=1:scale:scaledim_size(1)
    for j=1:scaledim_size(2)
    pos=mod(j-1,scale);
    if pos~=0 %We are not in the existing pixels
        scaled_image(i,j,:)=(pos*scaled_image(i,j-pos+scale,:) +(scale-pos)*scaled_image(i,j-pos,:))/scale;
    end
    end
end
%Now let's interpolate in y:
for i=1:scaledim_size(1)
    for j=1:scaledim_size(2)
    pos=mod(i-1,scale);
    if pos~=0 %We are not in the existing pixels
        scaled_image(i,j,:)=(pos*scaled_image(i-pos+scale,j,:) +(scale-pos)*scaled_image(i-pos,j,:))/scale;
    end
    end
end
figure;
if size(im_size)== 2
    imshow(scaled_image(:,:,1));
else
    imshow(scaled_image);
end
title('Bilinear Interpolation');
figure;
imshow(imresize(image,scale,'nearest'));
title('Original');
figure;
imshow(imresize(image,scale,'bicubic'));
title('MATLAB Bilinear');

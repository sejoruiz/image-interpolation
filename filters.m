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

function [ neighbour, bilinear ] = filters( picture, scale, rgbtogray )
%FILTERS Script to execute the implemented filters 
%  This function allows to execute a comparaison between to techniques when
%  resizing a picture:
%  Input arguments:
%  picture: Path to the picture to be resized
%  scale: Scale to resize the picture
%  rgbtogray: If this flag is set to one, the algorithms will be applied on
%  a grayscale version of the given picture 

%  Output args:
%  neighbour: Returns the image resized using nearest neighbour
%  interpolation
%  bilinear: Returns the image resized using bilinear interpolation
neighbour=resizeNearest(picture,scale,rgbtogray);
bilinear=resizeBilinear(picture,scale,rgbtogray);
end


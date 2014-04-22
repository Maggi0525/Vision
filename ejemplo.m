% Read in standard MATLAB demo image
originalImage = imread('coins.png'); 
imshow(originalImage);
figure;

% Maximize the figure window.
% set(gcf, 'Position', get(0, 'ScreenSize'));
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;


caption = sprintf('Original "coins" image showing\n6 nickels (the larger coins) and 4 dimes (the smaller coins).');
title(caption); 
axis square; % Make sure image is not artificially stretched because of screen's aspect ratio.
[pixelCount grayLevels] = imhist(originalImage); 
bar(pixelCount); title('Histogram of original image');

  thresholdValue = 100;
  hold on;
  
maxYValue = ylim;
hStemLines = stem(thresholdValue, maxYValue(2), 'r');
children = get(hStemLines, 'children');
set(children(2),'visible', 'off');
% Place a text label on the bar chart showing the threshold.
annotationText = sprintf('Thresholded at %d gray levels', thresholdValue);
% For text(), the x and y need to be of the data class "double" so let's cast both to double.
text(double(thresholdValue + 5), double(0.5 * maxYValue(2)), annotationText, 'FontSize', 10, 'Color', [0 .5 0]);
text(double(thresholdValue - 70), double(0.94 * maxYValue(2)), 'Background', 'FontSize', 10, 'Color', [0 0 .5]);
text(double(thresholdValue + 50), double(0.94 * maxYValue(2)), 'Foreground', 'FontSize', 10, 'Color', [0 0 .5]);
figure;
binaryImage = originalImage > thresholdValue; % Bright objects will be the chosen if you use >.
%   binaryImage = originalImage < thresholdValue; % Dark objects will be the chosen if you use <.
imshow(binaryImage);
figure;

binaryImage = imfill(binaryImage, 'holes');
imshow(binaryImage); colormap(gray(256)); title('Binary Image, obtained by thresholding'); axis square;
figure;

labeledImage = bwlabel(binaryImage, 8);     % Label each blob so we can make measurements of it
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels


imshow(labeledImage, []);
title('Labeled Image, from bwlabel()'); 
axis square;
figure;

imagesc(coloredLabels);
axis square;
caption = sprintf('Pseudo colored labels, from label2rgb().\nBlobs are numbered from top to bottom, then from left to right.');
title(caption);
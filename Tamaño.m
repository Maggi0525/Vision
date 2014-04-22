limon = imread('Limón.jpg');
gray = rgb2gray (limon);
imhist(gray);
bw = gray < 215;
[L,num] = bwlabel(bw);
for i=1:num
    area(i)=bwarea(L==i);
end

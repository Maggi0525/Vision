limon = imread('Limón.jpg');
imtool(limon);
gray = rgb2gray (limon);
imtool(gray);
imhist(gray);
bw = gray < 215;
imtool(bw);
[L,num] = bwlabel(bw);
for i=1:num
    area(i)=bwarea(L==i);
end
if (area <=  8.0333e+003)
    s=serial('com4'); % el del arduino
    fopen(s);
    fwrite(s,'a');
    fclose(s);
end

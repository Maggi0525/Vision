a=arduino('COM3')
pinMode(a,8,'output');
im=imread('Lima.jpg');
imR=im(:,:,1);
imtool(imR);
imG=im(:,:,2);
imtool(imG);
imB=im(:,:,3);
imtool(imB);
imR1=(imR>=70) & (imR<=170);
imtool(imR1);
imG1=(imG>=70) & (imG<=195);
imtool(imG1);
imB1=(imB>=20) & (imB<=105);
imtool(imB1);
green=(imR1 & imG1 & imB1);
imtool(green);
media = mean(mean(green));
dv = 0;
if (media < 0.2695)
    dv = 1;
    digitalWrite(a,8,dv);
else
    digitalWrite(a,13,dv-dv);
end 
delete(a)

    

s=serial('com8');
fopen(s);
while (1)
    a = fscanf(s,'%c.%c')';
    if (a == 1)
        im=imread('Limón.jpg');
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
        if (media < 0.2695)
            %s=serial('com7'); % el del arduino
            %fopen(s);
            fwrite(s,'a');
            %fclose(s);
        end
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
            %s=serial('com8'); % el del arduino
            %fopen(s);
            fwrite(s,'b');
            %fclose(s);
        end
    end
end
fclose(s);
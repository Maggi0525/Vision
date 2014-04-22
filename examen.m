clear   
disp(' ');   
disp('          Bienvenido al primer examen parcial');
  imagen=input('Escribe la imagen que quieres combinar: ','s');
   imagen_1=imread(imagen);
   [ren,col,dim]=size(imagen_1);
   opcion=input('quieres la transicion en imagenes a colores o bw: ','s');
   TF = strcmp(opcion,'colores');
   if TF == 1
       disp('Haremos la transicion en colores');
       opcion=input('quieres la transicion entre imagenes de diferentes tamaños?: ','s');
       diapositivas=input('Cuantas imagenes quieres que te muestre?: ');
       TF = strcmp(opcion,'yes');
       if TF == 0
           TF = strcmp(opcion,'si');
       end
       if TF==1
       imagen_2=imread('pinkfloyd.jpg');
       imagen_3=imread('jimmy_gold.jpg');
       imagen_4=imread('yeah.jpg');
       imagen_5=imread('portada.jpg');
       [ren(2),col(2),dim(2)]=size(imagen_2);
       [ren(3),col(3),dim(3)]=size(imagen_3);
       [ren(4),col(4),dim(4)]=size(imagen_4);
       [ren(5),col(5),dim(5)]=size(imagen_5);
       transicion=zeros(max(ren), max(col), max(dim));
       transicion=uint8(transicion);
      

for z=1:diapositivas
     if z==2
        figura=imagen_2;
    else if z==3
            figura=imagen_3;
        else if z==1
                figura=imagen_1;
            else if z==4
            figura=imagen_4;
                else if z==5
                        figura=imagen_5;
                    end
                end
            end
        end
     end

       ajuste_ren=floor((max(ren)-ren(z))/2);
       ajuste_col=floor((max(col)-col(z))/2);

       efecto=transicion;
       
for k=1:max(dim)
for i=1:max(ren)
for j=1:max(col)
    efecto(i,j,k)=0;
end
end
end

for k=1:dim(z)
for i=1:ren(z)
    for j=1:col(z)
        ii=i+ajuste_ren;
        jj=j+ajuste_col;
        efecto(ii,jj,k)=(figura(i,j,k));
    end
end
end
   
for a=1:0.25:2
    for k=1:max(dim)
    for i=1:max(ren)
        for j=1:max(col)
           transicion(i,j,k)=(2-a)*transicion(i,j,k)+((a-1))*efecto(i,j,k);
        end
    end
    end
    imtool(transicion);
end

end   
       end
              TF = strcmp(opcion,'no');
       if TF==1  %% empieza lo de colores, mismo tamaño

           disp('empezare lo de colores mismo tamaño');
           
       imagen_2=imread('2_c_same.jpg');
       imagen_3=imread('3_c_same.jpg');
       imagen_4=imread('4_c_same.jpg');
       imagen_5=imread('5_c_same.jpg');
       [ren(2),col(2),dim(2)]=size(imagen_2);
       [ren(3),col(3),dim(3)]=size(imagen_3);
       [ren(4),col(4),dim(4)]=size(imagen_4);
       [ren(5),col(5),dim(5)]=size(imagen_5);
       transicion=zeros(max(ren), max(col), max(dim));
       transicion=uint8(transicion);
      

for z=1:diapositivas
     if z==2
        figura=imagen_2;
    else if z==3
            figura=imagen_3;
        else if z==1
                figura=imagen_1;
            else if z==4
            figura=imagen_4;
                else if z==5
                        figura=imagen_5;
                    end
                end
            end
        end
     end
       efecto=transicion;
       
for k=1:max(dim)
for i=1:max(ren)
for j=1:max(col)
    efecto(i,j,k)=0;
end
end
end

for k=1:dim(z)
for i=1:ren(z)
    for j=1:col(z)
        efecto(i,j,k)=(figura(i,j,k));
    end
end
end
   
for a=1:0.25:2
    for k=1:max(dim)
    for i=1:max(ren)
        for j=1:max(col)
           transicion(i,j,k)=(2-a)*transicion(i,j,k)+((a-1))*efecto(i,j,k);
        end
    end
    end
    imtool(transicion);
end

end

              
       end
   end
       
       
   
   
   TF = strcmp(opcion,'bw');
   if TF == 1
       disp('Haremos la transicion en blanco y negro');
       opcion=input('quieres la transicion entre imagenes de diferentes tamaños?: ','s');
              diapositivas=input('Cuantas imagenes quieres que te muestre?: ');
       TF = strcmp(opcion,'yes');
       if TF == 0
           TF = strcmp(opcion,'si');
       end
       
       if TF == 1
       imagen_2=imread('1_gris.jpg');
       imagen_3=imread('2_gris.jpg');
       imagen_4=imread('3_gris.jpg');
       imagen_5=imread('4_gris.jpg');
       [ren(2),col(2),dim(2)]=size(imagen_2);
       [ren(3),col(3),dim(3)]=size(imagen_3);
       [ren(4),col(4),dim(4)]=size(imagen_4);
       [ren(5),col(5),dim(5)]=size(imagen_5);
       transicion=zeros(max(ren), max(col), max(dim));
       transicion=uint8(transicion);
      

for z=1:diapositivas
     if z==2
        figura=imagen_2;
    else if z==3
            figura=imagen_3;
        else if z==1
                figura=imagen_1;
            else if z==4
            figura=imagen_4;
                else if z==5
                        figura=imagen_5;
                    end
                end
            end
        end
     end

       ajuste_ren=floor((max(ren)-ren(z))/2);
       ajuste_col=floor((max(col)-col(z))/2);

       efecto=transicion;
for i=1:max(ren)
for j=1:max(col)
    efecto(i,j)=0;
end
end

for i=1:ren(z)
    for j=1:col(z)
        ii=i+ajuste_ren;
        jj=j+ajuste_col;
        efecto(ii,jj)=(figura(i,j));
    end
end
   
for a=1:0.25:2
    for i=1:max(ren)
        for j=1:max(col)
            transicion(i,j)=(2-a)*transicion(i,j)+((a-1))*efecto(i,j);
        end
    end
    imtool(transicion);
end

end   
       

       end
                 TF = strcmp(opcion,'no');
       if TF==1  %% empieza lo de blanco y negro mismos tamaños
      disp('empezare blanco y negro mismo tamaño');
            
       imagen_2=imread('2_gris_same.jpg');
       imagen_3=imread('3_gris_same.jpg');
       imagen_4=imread('4_gris_same.jpg');
       imagen_5=imread('5_gris_same.jpg');
       [ren(2),col(2),dim(2)]=size(imagen_2);
       [ren(3),col(3),dim(3)]=size(imagen_3);
       [ren(4),col(4),dim(4)]=size(imagen_4);
       [ren(5),col(5),dim(5)]=size(imagen_5);
       transicion=zeros(max(ren), max(col), max(dim));
       transicion=uint8(transicion);
      

for z=1:diapositivas
     if z==2
        figura=imagen_2;
    else if z==3
            figura=imagen_3;
        else if z==1
                figura=imagen_1;
            else if z==4
            figura=imagen_4;
                else if z==5
                        figura=imagen_5;
                    end
                end
            end
        end
     end

       efecto=transicion;
for i=1:max(ren)
for j=1:max(col)
    efecto(i,j)=0;
end
end

for i=1:ren(z)
    for j=1:col(z)
        efecto(i,j)=(figura(i,j));
    end
end
   
for a=1:0.25:2
    for i=1:max(ren)
        for j=1:max(col)
            transicion(i,j)=(2-a)*transicion(i,j)+((a-1))*efecto(i,j);
        end
    end
    imtool(transicion);
end

end   
       

       
       end
   end
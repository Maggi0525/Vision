clear   
disp(' ');   
disp('            Bienvenido al detector de formas');
   imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
   TF = strcmp(imagen,'0');
   if TF == 1
       original=imread('triangulos_1.jpg');
   else
       original=imread(imagen);
   end
   
   [ren,col,dim]=size(original);
   
   if dim==3
            Rojo=original(:,:,1)*0.2989;
            Verde=original(:,:,2)*0.5870;
            Azul=original(:,:,3)*0.1140;
            gris=Rojo+Verde+Azul;
   end
   
   if dim==1
       gris=original;
   end
      
   histograma=0:1:255;
for k=1:256
    histograma(k)=0;
end

    for i=1:ren
        for j=1:col
            valor=gris(i,j)+1;
            histograma(valor)=histograma(valor)+1;
        end
    end

    histograma_modificado=histograma;
      max_valor=0;
    min_valor=ren*col;
    
    for k=1:256
        
        valor=histograma(k);
        
           if valor<min_valor
                min_valor=valor;
                ubicacion_minimo=k;
            end

            if valor>max_valor
                max_valor=valor;
                ubicacion_maximo=k;
            end
    end
    
  tamano=ren*col;
  porcentaje=(max_valor-min_valor)*100/tamano;
  
  while porcentaje > 90
    max_valor=0;
    min_valor=ren*col;
     histograma_modificado(ubicacion_maximo)=0;
     for k=1:255
        
        valor=histograma_modificado(k);
        
           if valor<min_valor
                min_valor=valor;
                ubicacion_minimo=k;
            end

        
    
            if valor>max_valor
                max_valor=valor;
                ubicacion_maximo=k;
            end

               
     end
      tamano=ren*col;
  porcentaje=(max_valor-min_valor)*100/tamano;  
  end
  
  
 media=porcentaje*256/100;
  
    grisbinario=im2bw(gris,media/255);
    grisbinario=~grisbinario;

   grisbinario = imfill(grisbinario, 'holes');
    info=bwconncomp(grisbinario,4);
    
        maximo=0;
        min=col*ren;
    for i=1:length(info.PixelIdxList)
        L=length(info.PixelIdxList{i});
        
        if maximo<L
            maximo=L;
        end
        
        if min>L
            min=L;
        end
    end
    
  
    
         prueba=1:1:info.NumObjects;
         
     grisbinario_final=gris;
     
   for num_objetos=1:info.NumObjects
      
       
    for j=1:ren
        for k=1:col
                grisbinario_final(j,k)=0;
        end
    end
    
        for j=1:length(info.PixelIdxList{num_objetos}) 

                grisbinario_final(info.PixelIdxList{num_objetos}(j))=255;
        
        end
       
     info_final=bwconncomp(grisbinario_final,4);
     
     [I,J] = find(grisbinario_final);
     
     c_i = sum(I)/length(I); %coord.CG filas
     c_j = sum(J)/length(J); %coord.CG columnas
     
     C = corner(grisbinario_final,'SensitivityFactor',0.1,'QualityLevel',0.4);
     
     [x,y]=size(C);
     prueba(1,num_objetos)=x;
     prueba(2,num_objetos)=c_i;
     prueba(3,num_objetos)=c_j;
     s  = regionprops(grisbinario_final, 'Area');
     centroids = cat(1, s.Area);
     prueba(4,num_objetos)=max(centroids(:,1));
     Lado=(prueba(4,num_objetos))^(0.5);
     s  = regionprops(grisbinario_final, 'Perimeter');
     centroids = cat(1, s.Perimeter);
     Lado_2=max(centroids(:,1));
     Lado_2=(Lado_2)/4;
     prueba(5,num_objetos)=abs(Lado-Lado_2);
        
   end
   
 %%ploteo
    [x,h]=size(prueba);
    imshow(original);
    circulos=0;
    cuadrados=0;
    triangulos=0;
    pentagonos=0;
    hexagonos=0;
    paralelogramos=0;
        Area_promedio=0;

    
    for i=1:h
        if prueba(1,i)>9
            circulos=circulos+1;
            Area_promedio=Area_promedio+prueba(4,i);
        end  
            
         if prueba(1,i)==3
             Area_promedio=Area_promedio+prueba(4,i);
             triangulos=triangulos+1;
         end
         
         if prueba(1,i)==4
             Area_promedio=Area_promedio+prueba(4,i);
             if prueba(5,i)>2
                 paralelogramos=paralelogramos+1;
             else 
                 cuadrados=cuadrados+1;
             end
             
         end
         
         if prueba(1,i)==5
             Area_promedio=Area_promedio+prueba(4,i);
             pentagonos=pentagonos+1;
         end
             

         if prueba(1,i)==6
             Area_promedio=Area_promedio+prueba(4,i);
             hexagonos=hexagonos+1;
         end
         
         if prueba(1,i)<3
            circulos=circulos+1;
            Area_promedio=Area_promedio+prueba(4,i);
        end  
             
        
        
    end
    
    hold on
    
    for i=1:h
        switch prueba(1,i)
            case 3
            plot(prueba(3,i), prueba(2,i),'^','color','green', 'MarkerSize',10);
            case 4
             if prueba(5,i)>2
              plot(prueba(3,i), prueba(2,i),'d','color','red', 'MarkerSize',10);
             else 
                 plot(prueba(3,i), prueba(2,i),'s','color','red', 'MarkerSize',10);
             end                
             case 5
            plot(prueba(3,i), prueba(2,i),'x','color','cyan', 'MarkerSize',10);        
            case 6
            plot(prueba(3,i), prueba(2,i),'*','color','yellow', 'MarkerSize',10);
               
            otherwise
                
             plot(prueba(3,i), prueba(2,i),'o','color','blue', 'MarkerSize',10);
               
        end
    end
    
    Area_promedio=Area_promedio/h;
    
    disp('El numero de triangulos que pude contar fue: ');
    disp(triangulos);
    disp('El numero de cuadrados que pude contar fue: ');
    disp(cuadrados);
     disp('El numero de paralelogramos que pude contar fue: ');
    disp(paralelogramos);
    disp('El numero de pentagonos que pude contar fue: ');
    disp(pentagonos);
    disp('El numero de hexagonos que pude contar fue: ');
    disp(hexagonos);    
    disp('El numero de circulos que pude contar fue: ');
    disp(circulos);
    disp('El area promedio fue: ');
    disp(Area_promedio);
 
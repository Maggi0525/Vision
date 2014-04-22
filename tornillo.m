clear   
disp(' ');   
disp('            Bienvenido al detector de tuercas y tornillos');
   imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
   TF = strcmp(imagen,'0');
   if TF == 1
       original=imread('tuercas_6.jpg');
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
  
  while porcentaje > 70
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
  
  
 media=porcentaje*260/100;
  
    grisbinario=gris;
    for j=1:ren
        for k=1:col
            v=gris(j,k);
            if v<media
                grisbinario(j,k)=255;
            end
            
            if v>media
                grisbinario(j,k)=0;
            end
        end
    end
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
    
    for j=1:ren                                         %%lo cambie
        for k=1:col
                grisbinario(j,k)=255-grisbinario(j,k);
            
        end
    end
    
for a=1:info.NumObjects
    L=length(info.PixelIdxList{a});
    if L< maximo*0.19
        for h=1:L
            ubi=info.PixelIdxList{a}(h);
            grisbinario(ubi)=255;                       %%0
        end
    end
    
end
    for j=1:ren                                         %%lo cambie
        for k=1:col
                grisbinario(j,k)=255-grisbinario(j,k);
            
        end
    end
    info=bwconncomp(grisbinario,4);
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
     s  = regionprops(grisbinario_final, 'Eccentricity');
     centroids = cat(1, s.Eccentricity);
     
     prueba(1,num_objetos)=max(centroids(:,1));
     
     prueba(2,num_objetos)=c_i;
     prueba(3,num_objetos)=c_j;
     s  = regionprops(grisbinario_final, 'Area');
     centroids = cat(1, s.Area);
     
     prueba(4,num_objetos)=max(centroids(:,1));
        
   end

 %%ploteo
    h=length(prueba);
    imshow(gris);
    tuercas=0;
    tornillos=0;
        Area_promedio=0;
    tornillo_mayor=0;
    ubi_tornillo=0;
    tuerca_mayor=0;
    ubi_tuerca=0;
    
    for i=1:h
        if prueba(1,i)>0.90
            tornillos=tornillos+1;
            Area_promedio=Area_promedio+prueba(4,i);
            
            if prueba(4,i)> tornillo_mayor
                tornillo_mayor=prueba(4,i);
                ubi_tornillo=i;
               
            end
        else
             Area_promedio=Area_promedio+prueba(4,i);
             tuercas=tuercas+1;
             
            if prueba(4,i)> tuerca_mayor
                tuerca_mayor=prueba(4,i);
                ubi_tuerca=i;
            end
             
        end
        
    end
    
    hold on
    
    for i=1:h
            plot(prueba(3,i), prueba(2,i),'x','color','red', 'MarkerSize',10);
            
            if ubi_tuerca==i
            plot(prueba(3,i), prueba(2,i),'o','color','blue', 'MarkerSize',25,'LineWidth',4);    
            end
            
            if ubi_tornillo==i
            plot(prueba(3,i), prueba(2,i),'p','color','green', 'MarkerSize',25,'LineWidth',4);    
            end
            
    end
    
    Area_promedio=Area_promedio/h;
    
    disp('El numero de tuercas que pude contar fue: ');
    disp(tuercas);
    disp('El numero de tornillos que pude contar fue: ');
    disp(tornillos);
    disp('El area promedio fue: ');
    disp(Area_promedio);



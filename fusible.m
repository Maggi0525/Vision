clear   
disp(' ');   
disp('            Bienvenido al detector de fusible');
   imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
   TF = strcmp(imagen,'0');
   if TF == 1
       original=imread('fusibles.png');
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
  
  if porcentaje > 85
    max_valor=0;
    min_valor=ren*col;
     histograma_modificado(ubicacion_maximo)=0;
     last_point=0;
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
            
            if valor>0
                last_point=k;
            end
     end
      tamano=ren*col;
  porcentaje=(max_valor-min_valor)*100/tamano;  
  end
  
media=250;    

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
    
    info=bwconncomp(grisbinario,4);
for a=1:info.NumObjects
    L=length(info.PixelIdxList{a});
    if L<100
        for h=1:L
            ubi=info.PixelIdxList{a}(h);
            grisbinario(ubi)=0;
        end
    end
    
end
    info=bwconncomp(grisbinario,4);
    
most_dark=80;

   grisbinario_final_1=gris;
   grisbinario_final_2=gris;
   grisbinario_final_3=gris;
   grisbinario_final_4=gris;
   grisbinario_final_5=gris;
   
   prueba = 1:1:info.NumObjects;
   
   for num_objetos=1:info.NumObjects
       if num_objetos==1
           grisbinario_final=grisbinario_final_1;
       else if num_objetos==2
               grisbinario_final=grisbinario_final_2;
           else
               grisbinario_final=grisbinario_final_3;
           end
       end
       
    for j=1:ren
        for k=1:col
                grisbinario_final(j,k)=0;
        end
    end
    
        for j=1:length(info.PixelIdxList{num_objetos}) 

                grisbinario_final(info.PixelIdxList{num_objetos}(j))=255;
        
         end
       

    for j=1:length(info.PixelIdxList{num_objetos}) 
            v=gris(info.PixelIdxList{num_objetos}(j));
            if v>most_dark
                grisbinario_final(info.PixelIdxList{num_objetos}(j))=0;
            end
            if v<most_dark
                grisbinario_final(info.PixelIdxList{num_objetos}(j))=255;
            end
        
    end
    
    
    info_final=bwconncomp(grisbinario_final,4);
    
    for a=1:info_final.NumObjects
        L=length(info_final.PixelIdxList{a});
    if L<100
        for h=1:L
            ubi=info_final.PixelIdxList{a}(h);
            grisbinario_final(ubi)=0;
        end
    end
    
    end
    info_final=bwconncomp(grisbinario_final,4);
     s  = regionprops(grisbinario_final, 'Area');
     centroids = cat(1, s.Area);
     
     prueba(4,num_objetos)=max(centroids(:,1));
     [I,J] = find(grisbinario_final);
     
     c_i = sum(I)/length(I); %coord.CG filas
     c_j = sum(J)/length(J); %coord.CG columnas
     
     prueba(1,num_objetos)=info_final.NumObjects;
     
     prueba(2,num_objetos)=c_i;
     prueba(3,num_objetos)=c_j;
    


      if num_objetos==1
           grisbinario_final_1=grisbinario_final;
       else if num_objetos==2
               grisbinario_final_2=grisbinario_final;
           else
               grisbinario_final_3=grisbinario_final;
           end
       end
        
   end
   
   
    %%ploteo
    [ren,col,dim]=size(prueba);
    imshow(gris);
    hold on
    for i=1:col
        fize=(prueba(4,i)^0.5)*2;
        if prueba(1,i)==1
            plot(prueba(3,i), prueba(2,i),'o','color','green', 'MarkerSize',fize,'LineWidth',3);
        end
        if prueba(1,i)==2
            plot(prueba(3,i), prueba(2,i),'o','color','red', 'MarkerSize',fize,'LineWidth',3);
        end
    end
    
    
    
    

    
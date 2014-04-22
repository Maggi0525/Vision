clear   
disp(' ');   
disp('            Bienvenido al Laboratorio dos A');
   imagen=input('Escribe la imagen que quieres correr: ','s');
   gris=imread(imagen);
   [ren,col,dim]=size(gris);
   opcion=input('quieres convertirla a grises o  binaria o rotarla o inverso: ','s');
   TF = strcmp(opcion,'grises');
   if TF == 1
             if dim==3
            imtool(gris);
            Rojo=gris(:,:,1)*0.2989;
            Verde=gris(:,:,2)*0.5870;
            Azul=gris(:,:,3)*0.1140;
            grisbien=Rojo+Verde+Azul;
            imtool(grisbien);
            disp('es a colores');
             end
   
     if dim ~= 3
      
            disp('es blanco y negro');
            imtool(gris);
     end
     
   end

   TF = strcmp(opcion,'binaria');
if TF == 1
    opcion_media=input('Dame un valor menor a 255 o escribe 0 para ocupar promedio: ');

    if dim==3
        disp('Es una imagen a colores la convertire a blanco y negro');
        Rojo=gris(:,:,1)*0.2989;
        Verde=gris(:,:,2)*0.5870;
        Azul=gris(:,:,3)*0.1140;
        grisbien=Rojo+Verde+Azul;
    end
    
    if dim==1
       grisbien=gris;
    end
    
    if opcion_media~=0
      media=opcion_media;
    else
            media=sum(mean(grisbien))/length(mean(grisbien));
    end
    

    grisbinario=grisbien;
    for j=1:ren
        for k=1:col
            v=grisbien(j,k);
            if v<media
                grisbinario(j,k)=0;
            end
            if v>media
                grisbinario(j,k)=255;
            end
        end
    end
    imtool(gris);
    imtool(grisbinario);
end

   TF = strcmp(opcion,'rotarla');
if TF == 1
    if dim==1
        disp('Es una imagen en grises por lo que solo gire una matriz');
        grisbien=gris;
        giro=grisbien;
        for i=1:ren
            for j=1:col
                a=ren-i+1;
                b=j;
                giro(a,b)=gris(i,j);
            end
        end
        
    end
    if dim==3
         disp('Es una imagen en colores por lo que gire tres matriz');
        giro=gris;
    
        for k=1:dim
            for i=1:ren
                for j=1:col
                    a=ren-i+1;
                    b=j;
                    giro(a,b,k)=gris(i,j,k);
                end
            end
        end
    end
    imtool(gris);
    imtool(giro);
end

TF = strcmp(opcion,'inverso');
if TF==1
    if dim==1
        inverso=gris;
        for i=1:ren 
            for j=1:col
                inverso(i,j)=255-gris(i,j);
            end
        end
    end
    if dim==3
        inverso=gris;
        for i=1:dim
            for j=1:ren
                for k=1:col
                    inverso(j,k,i)=255-gris(j,k,i);
                end
            end
        end
    end
    imtool(inverso);
    imtool(gris);
end


            
  
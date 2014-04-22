clear;
disp(' ');   
disp(' Selecciona la opcion que deseas visualizar');
fprintf('\n a)Operación de suavizado\n b)Suavizados direccionales\n c)Aplicación de suavizado\n d)Efecto de niebla\n e)Mejoramiento de radiografía\n');

   opcion=input('\n Dame el tipo de filtro que quieres que haga: ','s');
switch opcion

    case 'a'%Operacion de suavizado
        disp('Operacion de suavizado');
           imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
           TF = strcmp(imagen,'0');
           if TF == 1
            original=imread('suavizado.jpg');
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
           
           dimension=input('Dame el tamaño de tu kernel: ');
           h = ones(dimension) / (dimension^2);
           suavizado = imfilter(gris,h);
           imshow(gris), title('Original Image');
           figure, imshow(suavizado), title('Filtered Image')


            

    case 'b' %Suavizado direccional
        disp('Suavizado direccional');
        
        imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
           TF = strcmp(imagen,'0');
           if TF == 1
            original=imread('suavizado.jpg');
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
           
           dimension=input('Dame  tamaño de tu kernel: ');
           tipo=input('Que tipo de suavizado deseas?: ','s');
           
           TF = strcmp(tipo,'horizontal');
           if TF == 1
           h = ones(1,dimension) / (dimension);
           suavizado = imfilter(gris,h);
           imtool(gris);
           imtool(suavizado);
           end
           
           
           TF = strcmp(tipo,'vertical');
            if TF == 1
           h = ones(dimension,1) / (dimension);
           suavizado = imfilter(gris,h);
           imtool(gris);
           imtool(suavizado);
            end
            
           TF = strcmp(tipo,'diagonal');
            if TF == 1
            h = eye(dimension) / (dimension);
           suavizado = imfilter(gris,h);
           imtool(gris);
           imtool(suavizado);
            end
           
           TF = strcmp(tipo,'diag_inversa');
            if TF == 1
           h = rot90(eye(dimension)) / (dimension);
           suavizado = imfilter(gris,h);
           imtool(gris);
           imtool(suavizado);
            end

        
    case 'c'%Aplicacion de suavizado
        disp('Aplicacion de suavizado');
         imagen=input('Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
           TF = strcmp(imagen,'0');
           if TF == 1
            original=imread('interferencia.jpg');
           else
            original=imread(imagen);
           end
            [ren,col,dim]=size(original);
           gris=original;
            h = ones(1,7) / (7);
           suavizado = imfilter(gris,h);
           imtool(gris);
           imtool(suavizado);
           
        
    case 'd'%Efecto de niebla
        disp('Efecto de niebla');
         imagen=input('\n Escribe la imagen que quieres correr o escribe 0 si quieres usar la imagen por default: ','s');
           TF = strcmp(imagen,'0');
           if TF == 1
            original=imread('opera_house_2.jpg');
           else
            original=imread(imagen);
           end
            [ren,col,dim]=size(original);
           G = fspecial('gaussian',[40,40],((col+ren)/250));
           suavizado = imfilter(original,G);
           gris=suavizado*0.7+original*0.3;
           imtool(gris);
           imtool(suavizado);
           imtool(original);
        
    case 'e'%Mejoramiento de radiografia
        disp('Mejoramiento de radiografia');
        
    otherwise
        disp('La opcion seleccionada no existe');
        disp('Hasta luego');

end

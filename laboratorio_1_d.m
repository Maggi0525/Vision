disp('      Bienvenido al laboratorio 1 parte d')
disp('1.- Matriz de 256x256');
disp('2.- Matriz de 256x256 con circulo en blanco');
disp('3.- Matriz de 256x256 con circulo difuminado');
disp('4.- Matriz de diferentes colores');
disp('5.- Salir');
opcion=input('Que opcion deseas ver?: ');


switch opcion
    
    case 1
        matriz=ones(256);
        [ren,col,dim]=size(matriz);
        for i=1:col
            matriz(:,i)=((i-1)/256);
        end
        imtool(matriz);
        
    case 2
        matriz=ones(255);
        [ren,col,dim]=size(matriz);
        for i=1:ren
            for j=1:col
                a=(i-128)^2;
                b=(j-128)^2;
                a=a+b;
                a=a^(1/2);
                if a<80
                    matriz(i,j)=1;
                else
                    matriz(i,j)=0;
                end
                
            end
        end
        imtool(matriz);
    
    case 3
        
                matriz=ones(255);
        [ren,col,dim]=size(matriz);
        for i=1:ren
            for j=1:col
                a=(i-128)^2;
                b=(j-128)^2;
                a=a+b;
                a=a^(1/2);
                if a<80
                    matriz(i,j)=1;
                else
                    matriz(i,j)=0;
                end
                
            end
        end
        for i=1:ren
            for j=1:col
                valor=matriz(i,j);
                if valor==1
                    matriz(i,j)=(j-48)/160;
                end
            end
        end
        imtool(matriz);
        
    case 4
  matriz=rand(255);
  matriz(:,:,2)=rand(255);
  matriz(:,:,3)=rand(255);
    matriz=im2double(matriz);
  [ren,col,dim]=size(matriz);
  for i=1:ren
if i<32
    k=1;
else if i<64
        k=2;
    else if i<96
            k=3;
        else if i<128
            k=4;
            else if i<160
                    k=5;
                else if i<192;
                        k=6;
                    else if i <224
                            k=7;
                        else 
                            k=8;
                        end
                    end
                end
            end
        end
    end
    
end
switch k
    case 1
        matriz(:,i,1)=255;
        matriz(:,i,2)=0;
        matriz(:,i,3)=0;
        
    case 2
        matriz(:,i,1)=250;
        matriz(:,i,2)=140;
        matriz(:,i,3)=0;
        
    case 3
        matriz(:,i,1)=245;
        matriz(:,i,2)=250;
        matriz(:,i,3)=0;  
        
    case 4
        matriz(:,i,1)=70;
        matriz(:,i,2)=244;
        matriz(:,i,3)=0;
        
    case 5
        matriz(:,i,1)=45;
        matriz(:,i,2)=224;
        matriz(:,i,3)=193;
        
    case 6
        matriz(:,i,1)=0;
        matriz(:,i,2)=0;
        matriz(:,i,3)=255;
        
    case 7
        matriz(:,i,1)=176;
        matriz(:,i,2)=0;
        matriz(:,i,3)=255;
        
    case 8
        matriz(:,i,1)=247;
        matriz(:,i,2)=0;
        matriz(:,i,3)=143;    
end
  end
  matriz=uint8(matriz);
  imtool(matriz);
        
        


end

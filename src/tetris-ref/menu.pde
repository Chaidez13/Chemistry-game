class Menu {
    var activo;
    PImage[] img;

    Menu() {
        this.img = new PImage[7];
        //Default menu
        this.img[0] = loadImage("src/menu/default.png");
        this.img[1] = loadImage("src/menu/continuar.png");
        this.img[2] = loadImage("src/menu/salir.png");
        this.img[3] = loadImage("src/menu/ayuda.png");
        this.img[4] = loadImage("src/menu/replayDef.png");
        this.img[5] = loadImage("src/menu/replay.png");
        this.img[6] = loadImage("src/menu/rp.png");
        this.activo = false;
    }

    void mostrar(x, y, mensaje) {
       if((x>350 && x<507)&& (y>478&&y<634)){
           textSize(50);
           if(mensaje == "Has perdido"){
            image(img[5],0,0);
           }
           else
            image(img[1],0,0);

       }else if((x>555 && x<709)&& (y>478&&y<634)){
           if(mensaje == "Has perdido"){
             image(img[2],0,0);
             image(img[6],0,0);
            }else{
               image(img[2],0,0); 
            }
          
       }else if((x>751&&x<911)&&(y>478&&y<634)){
           if(mensaje == "Has perdido"){
             image(img[3],0,0);
             image(img[6],0,0);
            }else{
               image(img[3],0,0); 
            }
       }else{
           if(mensaje == "Has perdido")
            image(img[4],0,0);
           else
            image(img[0],0,0);
       }
        textAlign(CENTER);
        if(mensaje.length<10)
            textSize(105);
        else
            textSize(95);

        fill(150);
        text(mensaje,635,405);
        fill(0);
        text(mensaje,630,400);
    }

    int opcion(x, y) {
         if((x>350 && x<507)&& (y>478&&y<634))
            return 0;
        else if((x>555 && x<709)&& (y>478&&y<634))
            return 1;
        else if((x>751&&x<911)&&(y>478&&y<634))
            return 2;
        else 
            return -1;
    }

}
class Logro {
	PImage[] img = new PImage[5];
	var tipo, x, y, w, h, dx, limit, time, delay, sound,opac;

	Logro(tipo, x, y, w, h, dx, limit, delay) {

		this.img[0] = loadImage("src/logro/00.png");
		this.img[1] = loadImage("src/logro/60.png");
		this.img[2] = loadImage("src/logro/limit.png");
		this.img[3] = loadImage("src/logro/camarada.png");
		this.img[4] = loadImage("src/logro/pump.png");
		this.tipo = tipo;
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.dx = dx;
		this.limit = limit;
		this.time = 0;
		this.delay = delay;
		this.sound = false;
		this.opac = 255;
	}

	void show() {
		if (this.delay++ > 30) {
			if (!sound) {
				archivementSound();
				sound = !sound;
			}
			if (!end()) {
				image(img[tipo], x, y, w / 2, h / 2);
				if (time++ >150) {
					this.move();
				}

			}
		}
	}
	boolean end() {
		return x >= limit
	}
	void move() {
		if (x <= limit)
			x += dx;
	}




}
class Elemento {
	let h, x, y, dy, dx, nombre, simbolo, numero, visible, agregado, nivel, jugable;

	Elemento(numero, simbolo, nombre, bloque, x, y, h, dx, dy, jugable, nivel) {
		this.numero = numero;
		this.simbolo = simbolo;
		this.nombre = nombre;
		this.bloque = bloque;
		this.x = x;
		this.y = y;
		this.h = h;
		this.dx = dx;
		this.dy = dy;
		this.visible = false;
		this.agregado = false;
		this.jugable = jugable;
		this.nivel = nivel;
	}
	Elemento(numero, simbolo, nombre, bloque, x, y, h, dx, dy, nivel) {
		this.numero = numero;
		this.simbolo = simbolo;
		this.nombre = nombre;
		this.bloque = bloque;
		this.x = x;
		this.y = y;
		this.h = h;
		this.dx = dx;
		this.dy = dy;
		this.visible = false;
		this.agregado = false;
		this.nivel = nivel;
		this.jugable = false;
	}

	void paint() {
		textSize(this.h / 2.75);
		if (nivel != 5 || this.jugable) {
			if (this.bloque == "nonmetal") {
				fill(58, 193, 248);
			} else if (this.bloque == "noble gas") {
				fill(143, 119, 181)
			} else if (this.bloque == "alkali metal") {
				fill(243, 55, 132)
			} else if (this.bloque == "alkaline earth metal") {
				fill(245, 109, 71)
			} else if (this.bloque == "metalloid") {
				fill(91, 193, 171)
			} else if (this.bloque == "halogen") {
				fill(122, 132, 191)
			} else if (this.bloque == "metal" || this.bloque == "post-transition metal") {
				fill(103, 191, 71);
			} else if (this.bloque == "transition metal") {
				fill(253, 197, 40);
			} else if (this.numero >= 57 && this.numero <= 71) {
				fill(235, 233, 71);
			} else {
				fill(151, 203, 66)
			}
		} else {
			fill(219,232,255)
		}
		stroke(0);
		strokeWeight(1.5);
		strokeCap(ROUND);
		if (!this.jugable) {
		rect(this.x + this.dx, this.y, this.h, this.h, 3);
			if (this.visible) {
				rect(this.x + this.dx, this.y, this.h, this.h, 3);
				fill(0)
				textAlign(CENTER);
				if (this.nivel != 4) {
					if (this.nivel < 3) {
						text(this.simbolo, (this.h / 2) + this.dx + this.x, (this.y) + this.h / 2);
						textSize(this.h / 5.5);
						text(this.numero, this.x + 13 + this.dx, this.y + 15);
					}
					if (this.nombre.length >= 9)
						textSize(this.h / 6.35);
					else
						textSize(this.h / 4.5);
					text(this.nombre, (this.h / 2) + this.dx + this.x, (this.y) + this.h - 10);
				}
			}
		} else {
			rect(this.x + this.dx, this.y, this.h, this.h, 3);
			fill(0)
			textAlign(CENTER);
			text(this.simbolo, (this.h / 2) + this.dx + this.x, (this.y) + this.h / 2);
			textSize(this.h / 5);
			if (this.nivel < 3) {
				if (this.nivel != 2)
					text(this.numero, this.x + 13 + this.dx, this.y + 15);
				if (this.nombre.length >= 9)
					textSize(this.h / 6.35);
				else
					textSize(this.h / 4.5);

				text(this.nombre, (this.h / 2) + this.dx + this.x, (this.y) + this.h - 10);
			}
		}
	}

	void agregar() {
		this.agregado = true;
	}

	void setVisible() {
		this.visible = true;
	}

	void move() {
		if (this.y < 1000)
			this.y += this.dy;
		else {
			this.x = 350
			this.y = 50
		}
	}

}
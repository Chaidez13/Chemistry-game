var tabla = [];
var logros = [];
var data = obtenerElementos();
var progreso = 0,
	contadorDePiezas = 0;
var piezas = [];
var puntos = 0,
	puntosGuardados = 0,
	banderaPuntos = 0;
var salud = 250,
	damage = 25;
PImage fondo, instrucciones;
Logro logro, logroPuntos, logroActual;
Elemento actual;
Menu menu;
var altoTabla = 9;
var opcion = -1;
var created = false;
var nivel = cargarNivel(); //Carga el nivel del juego
var typed = '';
var confirmar;
var continuar = false,
	musicOn = false,
	activarMenu = false,
	mute = false,
	ganar = false,
	perder = false,
	mostrarInstrucciones = false,
	logoOtorgado = false,
	oldLogro = false,
	nowLogro = false,
	sovLogro = false,
	pumpLogro = false;
var tablero = [
	["0", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "1"],
	["2", "3", "", "", "", "", "", "", "", "", "", "", "4", "5", "6", "7", "8", "9"],
	["10", "11", "", "", "", "", "", "", "", "", "", "", "12", "13", "14", "15", "16", "17"],
	["18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35"],
	["36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53"],
	["54", "55", "", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85"],
	["86", "87", "", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117"],
	["", "", "", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", ""],
	["", "", "", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", ""],
];

void setup() {
	size(1261, 1000);
	crearMatriz();
	menu = new Menu();
	menu.activo = true;
	setUpMusic();

	instrucciones = loadImage("src/instrucciones.png");

	banderaPuntos = cargarPuntos(nivel);
	frameRate(30);
}

void draw() {

	if (instrucciones.width != 0 && instrucciones.width != -1) {
		background(245, 245, 245);
		if (!created) {
			guardarPartida(puntos, nivel);
			llenarMatriz();
			actual = elementoNivel(nivel);
			puntosGuardados = banderaPuntos;
			created = true;
		}
		if (actual != null) {
			if (nivel > 5) nivel = 1;
			progreso = Math.trunc((contadorDePiezas / 118) * 100);
			if (actual.y >= 1000 && salud > 0) {
				salud -= damage;
				if (puntos > 0)
					puntos -= 5;
			}
			pintarTabla();
			actual.paint();
			if (!menu.activo)
				actual.move();
			actual.setVisible();
		} else {
			menu.activo = true;
			ganar = true;
		}
		textSize(16);
		vidas(10, 5, salud);
		if (!continuar) {
			menu.activo = true;
			menu.mostrar(mouseX, mouseY, "Pause");
		}
		if (ganar) {
			menu.mostrar(mouseX, mouseY, "¡Ganaste!");
			if (opcion != -1) {
				actualizarPuntos(puntos, 100, puntosGuardados, nivel, 1);
				nextLevel();
			}
		}
		if (perder) {
			menu.mostrar(mouseX, mouseY, "Has perdido");
			if (opcion != -1) {
				actualizarPuntos(puntos, progreso, puntosGuardados, nivel, 0);
				puntosGuardados = cargarPuntos(nivel);
				reset();
			}
		}
		if (!logoOtorgado && (puntos > puntosGuardados) && (puntosGuardados > 0||banderaPuntos==0)) {
			var h = 900;
			if (logros.length > 0) {
				h = 800;
				logros.push(new Logro(2, 910, h, 683, 171, 25, width, 0));
			} else {
				logros.push(new Logro(2, 910, 900, 683, 171, 25, width, 40));
			}

			actualizarPuntos(puntos, progreso, puntosGuardados, nivel, 0);
			puntosGuardados = puntos;
			logoOtorgado = !logoOtorgado;
		}
		for (var i = 0; i < logros.length; i++) {
			if (logros[i] != null) {
				logros[i].show();
				if (logros[i].end()) {
					logros[i] = null;
				}
			} else
				logros.shift();
		}
		if (mostrarInstrucciones)
			image(instrucciones, 0, 0);
	} else {
		background(255);
		textSize(32);
		fill(0);
		text("CARGANDO...", 500, 500);
	}
}

void actualizarPuntos(puntos, progreso, puntosGuardados, nivel, estado) {
	if (puntos > puntosGuardados + 1 || banderaPuntos==0) {
		actualizarPartida(puntos, progreso, nivel, estado);
	}
}

void mouseClicked() {
	var option = -1;
	if (menu.activo) {
		option = menu.opcion(mouseX, mouseY);
		switch (option) {
			case 0:
				menu.activo = false;
				continuar = true;
				opcion = 1;
				if (!musicOn)
					gameMusic(nivel);
				musicOn = true;
				break;
			case 1:
				window.location.replace("/");
				break;
			case 2:
				mostrarInstrucciones = true;
				break;
			default:
				opcion = -1;
				break;
		}
	}

}

void keyPressed() {
	if ((key == 'p' || key == 'P') && (!perder || !ganar)) {
		menu.activo = !menu.activo;
		continuar = !continuar;
	}
	if ((key == 'Q' || key == 'q') && (!perder || !ganar)) {
		mostrarInstrucciones = !mostrarInstrucciones;
	}
	if ((key == 'M' || key == 'm')) {
		mute = !mute;
		if(mute)
		 	pauseGameMusic();
		 else
		 	gameMusic(nivel);
	}

	if (!menu.activo && actual != null) {
		if (keyCode == LEFT)
			if ((actual.x - actual.h) >= 0)
				actual.x -= actual.h;

		if (keyCode == RIGHT)
			if ((actual.x + actual.h * 2) <= width)
				actual.x += actual.h;

		if (keyCode == DOWN) {
			downSound();
			if (down.currentTime <= 0)
				actual.y += actual.h;
		}
		if (key == ' ') {
			opcion = -1;
			let simbol = actual.simbolo;
			if (encontrado((actual.x) + actual.h, actual.y, simbol)) {
				++contadorDePiezas;
				matchSound();
				actual.agregar();
				actual = elementoNivel(nivel);
				puntos += damage;
			} else {
				errorSound();
				if (salud > 5)
					salud -= damage;
				else {
					perder = true;
					menu.activo = true;
				}
				if (puntos > 0)
					puntos -= 5;
				actual.x = 350;
				actual.y = 50;
			}
			if(banderaPuntos==0)
				puntosGuardados = puntos;
		}
	}
}

void keyTyped() {
	typed += String.fromCharCode(key);
	var match = typed.match(/old|now|end|soviet|foster/g);
	if (match == 'old' || match == 'now' || match == 'soviet' || match == 'foster') {
		if (match == 'old') {
			oldMusic();
			if (!oldLogro) {
				puntos += 100;
				logros.push(new Logro(1, 910, 900, 683, 171, 25, width, 40));
				oldLogro = !oldLogro;
			}
		} else if (match == 'now') {
			nowMusic();
			if (!nowLogro) {
				puntos += 100;
				logros.push(new Logro(0, 910, 900, 683, 171, 25, width, 40));
				nowLogro = !nowLogro;
			}
		} else if (match == 'soviet') {
			soviet();
			if (!sovLogro) {
				puntos += 100;
				logros.push(new Logro(3, 910, 900, 683, 171, 25, width, 40));
				sovLogro = !sovLogro;
			}
		} else {
			pumped();
			if (!pumpLogro) {
				puntos += 100;
				logros.push(new Logro(4, 910, 900, 683, 171, 25, width, 40));
				pumpLogro = !pumpLogro;
			}
		}
		typed = '';
	} else if (match == 'end') {
		stopAll();
		gameMusic(nivel);
		typed = '';
	}
}

void reset() {
	piezas = [];
	tabla = [];
	salud = 250;
	puntos = 0;
	ganar = false;
	perder = false;
	created = false;
	continuar = true;
	menu.activo = false;
	logoOtorgado = false;
	contadorDePiezas = 0;
	musicOn = false;
	banderaPuntos = cargarPuntos(nivel);
	mostrarInstrucciones = false;
	opcion = -1;
	crearMatriz();
}


void crearMatriz() {
	for (var i = 0; i < altoTabla; i++) {
		tabla[i] = new Array(18);
	}

}

void pintarTabla() {
	for (var i = 0; i < altoTabla; i++) {
		for (var j = 0; j < 18; j++) {
			if (tablero[i][j] != "") {
				tabla[i][j].paint();
			}
		}
	}
}

void llenarMatriz() {
	var desfaseX = 0,
		desfaseY = 0,
		espacio = 369,
		h = 70;
	let x = 350,
		y = 50;
	for (var i = 0; i < altoTabla; i++) {
		desfaseY = (i * h);
		for (var j = 0; j < 18; j++) {
			if (tablero[i][j] != "") {
				piezas.push(new Elemento(parseInt(tablero[i][j]) + 1, data[tablero[i][j]].simbolo, data[tablero[i][j]].nombre,
					data[tablero[i][j]].bloque, x, y, h, 0, 1, true, nivel));
				tabla[i][j] = new Elemento(parseInt(tablero[i][j]) + 1, data[tablero[i][j]].simbolo, data[tablero[i][j]].nombre,
					data[tablero[i][j]].bloque, (j * h), desfaseY + espacio, h, 0, 0, nivel);
				if (nivel == 3)
					tabla[i][j].setVisible();
			}
		}
	}
}

function elementoRandom() {
	var index, length = piezas.length
	for (var i = 0; i < length; i++) {
		index = int(random(length) - 1);
		Elemento element = piezas[index];
		if (!element.agregado)
			return piezas[index];
		else
			continue;
	}
	return null;
}

function vidas(x, y, vida) {
		noStroke();
		fill(227, 227, 227);
		rect(x, y, 250*4.95, 15, 8);
		rect(x, y + 20, 250*4.95, 15, 8);
	if (vida >= 50 && vida <= 100)
		fill(229, 101, 13);
	else if (vida <= 50) {
		fill(229, 36, 13);
	} else
	fill(56, 142, 60);
	rect(x, y, vida*4.95, 15, 8);
	fill(25,118,210);
	rect(x, y + 20, (progreso * 2.5)*4.95, 15, 8);
	fill(0);
	
	textSize(20);
	textAlign(LEFT);
	text(puntos + " / " + puntosGuardados,x, y+60);
	text(progreso + "% / 100%",x, y+85);
	if(!mute)
		text("Música: On",x,975);
	else 
		text("Música: Off",x,975);
	textFont(createFont("Comic sans ms", 20));
}

function marcador(points, x, y) {
	textFont(createFont("Comic sans ms", 32));
	text(points, x, y);
}



function elementoNivel(nivel) {
	switch (nivel) {
		case 1:
		case 2:
			return piezas.shift();
		case 3:
		case 4:
		case 5:
			return elementoRandom();
		default:
			break;
	}
}
void nextLevel() {
	if (nivel < 5) {
		nivel++;
		reset();
	}
}

function encontrado(x, y, simbolo) {
	for (var i = 0; i < altoTabla; i++) {
		for (var j = 0; j < 18; j++) {
			if (tablero[i][j] != "") {
				Elemento elemento = tabla[i][j];
				if ((x >= elemento.x && x <= (elemento.x + elemento.h)) && ((y >= elemento.y && y <= (elemento.y + elemento.h)) ||
						(y + elemento.h >= elemento.y && y + elemento.h <= (elemento.y + elemento.h))) && (elemento.simbolo == simbolo)) {
					elemento.nivel = 1;
					elemento.setVisible();
					return true;
				}
			}
		}
	}
	return false;
}
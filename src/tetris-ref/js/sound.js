<<<<<<< HEAD

var down = new Audio('../src/Audio/phaserUp6.ogg');
var match = new Audio('../src/Audio/threeTone2.ogg');
var fail = new Audio('../src/Audio/lowRandom.ogg');
var old = new Audio('../src/Audio/old.ogg');
var now = new Audio('../src/Audio/now.ogg');
var archivement = new Audio('../src/Audio/logro.ogg');
var sov = new Audio('../src/Audio/soviet.ogg');
var pump = new Audio('../src/Audio/pumped.ogg');
var levelMusic = [];
levelMusic[0] = new Audio('../src/Audio/1.ogg');
levelMusic[1] = new Audio('../src/Audio/5.ogg');
levelMusic[2] = new Audio('../src/Audio/3.ogg');
levelMusic[3] = new Audio('../src/Audio/4.ogg');
levelMusic[4] = new Audio('../src/Audio/2.ogg');
=======
var down = new Audio('src/Audio/phaserUp6.ogg');
var match = new Audio('src/Audio/threeTone2.ogg');
var fail = new Audio('src/Audio/lowRandom.ogg');
var old = new Audio('src/Audio/old.ogg');
var now = new Audio('src/Audio/now.ogg');
var archivement = new Audio('src/Audio/logro.ogg');
var sov = new Audio('src/Audio/soviet.ogg');
var pump = new Audio('src/Audio/pumped.ogg');
var levelMusic = [];
levelMusic[0] = new Audio('src/Audio/1.ogg');
levelMusic[1] = new Audio('src/Audio/5.ogg');
levelMusic[2] = new Audio('src/Audio/3.ogg');
levelMusic[3] = new Audio('src/Audio/4.ogg');
levelMusic[4] = new Audio('src/Audio/2.ogg');
>>>>>>> 4d9919e726ccd10d619700dc6ee3af27d2501910

function backgroundSound() {
	archivement.volume = 0.5;
	archivement.play();
}

function setUpMusic() {
	for (let i = 0; i < levelMusic.length; i++) {
		levelMusic[i].volume = 0.3;
		levelMusic[i].loop = true;
	}
}

function pauseGameMusic() {
	for (let i = 0; i < levelMusic.length; i++) {
		levelMusic[i].pause();
	}

}

function gameMusic(nivel) {
	levelMusic[nivel - 1].play();
}

function oldMusic() {
	stopAll()
	old.volume = 0.3;
	old.play();
}

function stopAll() {
	pauseGameMusic();
	old.pause();
	now.pause();
	sov.pause();
	pump.pause();
	now.currentTime = 0;
	old.currentTime = 0;
	sov.currentTime = 0;
	pump.currentTime = 0;
}

function nowMusic() {
	stopAll()
	now.volume = 0.3;
	now.play();
}

function soviet() {
	stopAll()
	sov.volume = 0.15;
	sov.play();
}

function pumped() {
	stopAll()
	pump.volume = 0.3;
	pump.play();
}

function archivementSound() {
	archivement.volume = 0.5;
	archivement.play();
}

function matchSound() {
	match.volume = 0.2;
	match.play();
}

function downSound() {
	down.volume = 0.2;
	down.play();
}

function errorSound() {
	fail.volume = 0.2;
	fail.play();
}
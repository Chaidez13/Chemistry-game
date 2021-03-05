<template>
  <v-container>
    <v-row align="center" justify="center" style="margin-top: 4%">
      <v-col cols="12" align="center" justify="center">
        <v-btn fab color="error" @click="setGameTriviaOff" class="btn-game">
          <v-icon>mdi-backspace</v-icon>
        </v-btn>
      </v-col>
      <v-col
        cols="12"
        lg="5"
        md="3"
        style="position: absolute; right: 5%"
        justify="flex-end"
        v-if="$vuetify.breakpoint.mdAndUp"
      >
        <vidas :cantVidas="lifes" />
      </v-col>
      <v-col
        cols="12"
        sm="10"
        align="center"
        justify="center"
        v-if="$vuetify.breakpoint.smAndDown"
      >
        <vidas :cantVidas="lifes" />
      </v-col>
    </v-row>
    <v-row
      align="center"
      justify="center"
      style="margin-bottom: 2%; margin-top: 1%"
    >
      <h2>{{ title }}</h2>
    </v-row>
    <time-bar :time="time" />
    <v-row align="center" justify="center" class="pa-5">
      <h3>{{ message }}</h3>
    </v-row>
    <v-row align="center" justify="center">
      <v-progress-linear
        :value="progreso"
        rounded
        height="10px"
        style="max-width: 800px"
      ></v-progress-linear>
    </v-row>
    <v-row align="center" justify="center" style="margin: 50px 0">
      <v-col
        v-for="(item, i) in answerOp"
        :key="i"
        cols="4"
        class="answer-option"
        @click="responder(pregunta, item)"
      >
        <p class="text-center" style="margin-top: 70px">{{ item.respuesta }}</p>
      </v-col>
    </v-row>
    <GameOver v-if="gameO" :points="puntos" :status="status" game="3" />
  </v-container>
</template>

<script>
import { mapMutations, mapState } from "vuex";
import Vidas from "../components/Vidas";
import TimeBar from "../components/TimeBar";
import GameOver from "../components/GameOver";

import { reportStore, triviaAnswers, updateGame } from "../utils/services";

export default {
  data() {
    return {
      title: "",
      questions: [],
      pregunta: {},
      answerOp: [],
      message: "",
      progreso: 0,
      actual: null,
      lifes: 3,
      time: 0,
      interval: null,
      gameO: false,
      status: false,
      puntos: 0,
    };
  },
  components: {
    Vidas,
    TimeBar,
    GameOver,
  },
  created() {
    this.init();
    this.getQuestion();
  },
  computed: {
    ...mapState("trivia", ["levelTrivia"]),
  },
  methods: {
    ...mapMutations("trivia", ["setGameTriviaOn", "setGameTriviaOff"]),
    init: async function () {
      await reportStore("/partida/store", {
        idJuego: 3,
        idUsuario: -1,
        nivel: this.levelTrivia,
        puntos: 0,
      });
    },
    getQuestion: function () {
      triviaAnswers()
        .get("/trivia/respuestas")
        .then((response) => {
          const perguntasLevel = response.data.filter(
            (d) => d.pregunta.nivel == this.levelTrivia
          );
          this.questions = this.shuffle(perguntasLevel);
          this.actual = 0;
          this.newQuestion();
          this.oneSecond();
        })
        .catch((error) => console.log(error));
    },
    newQuestion() {
      var i = 0;
      this.answerOp = [];
      this.pregunta = this.questions[this.actual];
      this.title = this.pregunta.pregunta.pregunta;
      this.answerOp.push({
        id: this.pregunta.pregunta.id,
        respuesta: this.pregunta.respuesta,
      });
      do {
        let aux = Math.trunc(Math.random() * this.questions.length);
        if (!this.answerOp.find((e) => e.id == this.questions[aux].id)) {
          this.answerOp.push({
            id: this.questions[aux].idPregunta,
            respuesta: this.questions[aux].respuesta,
          });
          i++;
        }
      } while (i < 3);
      this.shuffle(this.answerOp);
    },

    resetGame() {
      this.lifes = 3;
      this.progreso = 0;
      this.time = 0;
    },
    responder(question, answer) {
      if (question.idPregunta == answer.id) {
        this.next();
      } else {
        this.lifes--;
        this.message = "INCORRECTO";
      }
    },
    reset() {
      this.progreso = 0;
      this.message = "";
    },
    next() {
      this.puntos += 100 - this.time;
      this.progreso += 10;
      this.actual++;
      this.time = 0;
      this.message = "CORRECTO";
      if (this.progreso < 100) this.newQuestion();
    },
    oneSecond: function () {
      this.interval = setInterval(this.timer, 1000);
    },
    timer: function () {
      this.time += 5;
    },
    gameEnded: async function () {
      this.gameO = true;
      clearInterval(this.interval);
      await updateGame(
        {
          puntos: this.puntos,
          nivel: this.levelTrivia,
          estado: this.status,
          progreso: this.actual * 10,
        },
        3
      )
        .then(() => console.log("SUCCESS"))
        .catch(() => {
          console.log("ERROR");
        });
    },

    shuffle(a) {
      for (let i = a.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [a[i], a[j]] = [a[j], a[i]];
      }
      return a;
    },
  },
  watch: {
    progreso: function (newProgress) {
      if (newProgress >= 100) {
        this.status = true;
        this.gameEnded();
      }
    },
    time: function (newTime) {
      if (newTime >= 100) {
        this.gameEnded();
      }
    },
    lifes: function (life) {
      if (life <= 0) {
        this.gameEnded();
      }
    },
  },
};
</script>

<style scoped>
.answer-option {
  margin: 10px;
  border-radius: 5px;
  border: 1px solid darkgray;
  background-color: lightblue;
  max-width: 170px;
  min-width: 130px;
  min-height: 200px;
}
.answer-option:hover {
  background-color: yellow;
}
.btn-game {
  margin: 0 10px;
}
</style>

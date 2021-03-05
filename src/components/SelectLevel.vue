<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6" offset-sm="3">
        <v-card>
          <v-list>
            <v-subheader>Niveles:</v-subheader>
            <div v-for="(item, i) in levels" :key="i">
              <v-divider></v-divider>
              <v-list-item
                @click="beginGame(item.dificultad)"
                :disabled="!item.status"
              >
                <v-list-item-icon>
                  <v-icon v-text="item.icon"></v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>{{ item.nombre }}</v-list-item-title>
                </v-list-item-content>
                <v-progress-circular
                  :value="item.progreso"
                  rotate="260"
                  :color="item.color"
                ></v-progress-circular>
              </v-list-item>
            </div>
          </v-list>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapMutations, mapActions, mapState } from "vuex";
import { tetrisLevel } from "../utils/services";

export default {
  props: ["game"],
  data() {
    return {
      levels: [],
    };
  },
  created() {
    switch (this.game) {
      case "2":
        this.updateLevelDataMM();
        this.levels = this.nivelesMM;
        break;
      case "3":
        this.updateLevelDataTR();
        this.levels = this.nivelesTR;
        break;
      case "1":
        this.updateLevelDataTT();
        this.levels = this.nivelesTT;
        break;
    }
  },
  computed: {
    ...mapState("memoria", ["nivelesMM"]),
    ...mapState("trivia", ["nivelesTR"]),
    ...mapState("tetris", ["nivelesTT"]),
  },
  methods: {
    ...mapMutations(["setGameTetrisOn"]),
    ...mapMutations("memoria", ["setGameMemoriaOn", "setLevelMemoria"]),
    ...mapActions("memoria", ["updateLevelDataMM"]),
    ...mapMutations("trivia", ["setGameTriviaOn", "setLevelTrivia"]),
    ...mapActions("trivia", ["updateLevelDataTR"]),
    ...mapMutations("tetris", ["setGameTetrisOn", "setLevelTetris"]),
    ...mapActions("tetris", ["updateLevelDataTT"]),

    beginGame: function (dificultad) {
      switch (this.game) {
        case "2":
          this.setGameMemoriaOn();
          this.setLevelMemoria(dificultad);
          break;
        case "3":
          this.setGameTriviaOn();
          this.setLevelTrivia(dificultad);
          break;
        case "1":
          /*  this.setGameTetrisOn(); */
          tetrisLevel({
            nivel: dificultad,
          })
            .then(() => (window.location.href = "/tetris"))
            .catch(() =>
              alert("Ups, ocurrio un problema, intentalo de nuevo.")
            );
          break;
      }
    },
  },
};
</script>
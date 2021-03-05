<template>
  <v-dialog v-model="reportDialog" persistent max-width="600px">
    <v-card>
      <v-form ref="form">
        <v-card-title>
          <span class="headline">Reportar Error</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-select
                :items="games"
                label="Seleccionar Juego*"
                v-model="selectedGame"
                :rules="[() => !!selectedGame || 'Este campo es obligatorio.']"
              >
              </v-select>
            </v-row>
            <v-row>
              <v-textarea
                v-model="message"
                label="Describir error*"
                no-resize
                :rules="[() => !!message || 'Este campo es obligatorio.']"
              >
                ></v-textarea
              >
            </v-row>
          </v-container>
          <small>*Campos obligatorios</small>
        </v-card-text>
        <v-card-actions>
          <v-row>
            <v-col cols="12" sm="6">
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="changeReport()"
                >Cancelar</v-btn
              >
              <v-btn color="blue darken-1" text @click="sentReport"
                >Enviar</v-btn
              >
            </v-col>
          </v-row>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { reportStore } from "../utils/services";

export default {
  data: () => ({
    games: ["Memoría", "Tetris", "Trivia"],
    selectedGame: null,
    message: null,
  }),
  methods: {
    ...mapMutations(["changeReport"]),
    sentReport: function () {
      reportStore({
        //Usuario probicional equisde
        idUsuario: 1,
        juego: this.selectedGame,
        mensaje: this.message,
      })
        .then(() => {
          this.changeReport();
        })
        .catch((e) => console.log(e));
    },
  },
  computed: {
    ...mapState(["reportDialog"]),
  },
};
</script>
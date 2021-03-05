<template>
  <v-container>
    <v-row align="center" justify="center">
      <h1 class="display-2" style="color: #ec407a; padding: 20px 0 100px">
        ESTADÍSTICAS
      </h1>
    </v-row>
    <v-row>
      <v-col v-for="(item, i) in juegos" :key="i">
        <v-card>
          <v-card-title class="headline">{{ item.nombre }}</v-card-title>
          <v-sparkline
            v-if="carga"
            :value="item.value"
            :gradient="gradient"
            :smooth="radius || false"
            :padding="padding"
            :line-width="width"
            :stroke-linecap="lineCap"
            :gradient-direction="gradientDirection"
            :fill="fill"
            :type="type"
            :auto-line-width="autoLineWidth"
            auto-draw
          ></v-sparkline>
          <v-list v-for="(data, j) in item.value" :key="j">
            <v-divider></v-divider>
            <v-list-item>Nivel {{ j + 1 }}: {{ data }}</v-list-item>
          </v-list>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { allGame } from "../utils/services";

const gradients = [
  ["#222"],
  ["#42b3f4"],
  ["red", "orange", "yellow"],
  ["purple", "violet"],
  ["#00c6ff", "#F0F", "#FF0"],
  ["#f72047", "#ffd200", "#1feaea"],
];

export default {
  name: "Dashboard",
  data: () => ({
    width: 2,
    radius: 10,
    padding: 8,
    lineCap: "round",
    gradient: gradients[5],
    gradientDirection: "top",
    gradients,
    fill: false,
    type: "trend",
    autoLineWidth: false,
    carga: false,
    juegos: [
      {
        nombre: "Tetris",
        value: [0, 0, 0, 0, 0],
      },
      {
        nombre: "Memoria",
        value: [0, 0, 0, 0, 0],
      },
      {
        nombre: "Trivia",
        value: [0, 0, 0, 0, 0],
      },
    ],
  }),
  methods: {
    updateData: function () {
      allGame().then((d) => {
        d.data.forEach((e) => {
          this.juegos[e.idJuego - 1].value[e.nivel - 1] = e.puntos;
        });
        this.carga = true;
      });
    },
  },
  created() {
    this.updateData();
  },
};
</script>

<style scoped>
</style>
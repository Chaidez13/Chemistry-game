<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col
        v-for="(item, i) in juegos"
        :key="i"
        :class="item.color"
        class="game-container"
        md="3"
        cols="7"
      >
        <router-link :to="{name:'game', params:{id:item.ruta}}">
          <p class="text-center title white--text">{{item.name}}</p>
          <v-img :src="item.image" :alt="item.image" class="game-image"></v-img>
        </router-link>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "GamesPage",
  data() {
    return {
      juegos: [
        {
          name: "Tetris",
          image: require("../assets/tetris.jpg"),
          color: "amber lighten-2",
          ruta: "tetris"
        },
        {
          name: "Memoría",
          image: require("../assets/cartel.jpg"),
          color: "blue-grey lighten-2",
          ruta: "memoria"
        },
        {
          name: "Trivia",
          image: require("../assets/trivia.jpg"),
          color: "red lighten-2",
          ruta: "trivia"
        }
      ]
    };
  }
};
</script>

<style>
.game-container {
  margin: 40px;
  border-radius: 10px;
}
a {
  text-decoration: none;
}
.game-image {
  width: 95%;
  border-radius: 10px;
  margin: 0 auto;
}
</style>

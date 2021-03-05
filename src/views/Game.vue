<template>
  <v-container :is="gameLoaded" id="game-container"></v-container>
</template>

<script>
import Tetris from "../components/Tetris";
import Memoria from "../components/Memoria";
import Trivia from "../components/Trivia";

export default {
  name: "Game",
  components: {
    tetris: Tetris,
    memoria: Memoria,
    trivia: Trivia,
  },
  data() {
    return {
      gameLoaded: this.$route.params.id,
    };
  },
};
</script>

<style scoped>
#game-container {
  margin-top: 50px;
}
</style>

<template>
  <v-container>
    <v-row align="center" justify="center">
      <h1 class="display-2" style="color: #e57373">TRIVIA</h1>
    </v-row>

    <select-level v-if="!gameTrivia" game="3" />
    <trivia-game v-if="gameTrivia" />
  </v-container>
</template>


<script>
import SelectLevel from "../components/SelectLevel";
import TriviaGame from "../components/TriviaGame";

import { mapState } from "vuex";
export default {
  components: {
    SelectLevel,
    TriviaGame,
  },
  computed: {
    ...mapState("trivia", ["gameTrivia"]),
  },
};
</script>

<template>
  <v-container>
    <v-row align="center" justify="center">
      <h1 class="display-2" style="color: #90a4ae">TETRIS</h1>
    </v-row>
    <select-level game="1" />
    <!--  <tetris-game v-if="gameTetris" /> -->
  </v-container>
</template>

<script>
import SelectLevel from "../components/SelectLevel";

import { mapState } from "vuex";
export default {
  components: {
    SelectLevel,
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("tetris", ["gameTetris"]),
  },
};
</script>

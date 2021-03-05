<template>
  <v-container>
    <v-row align="center" justify="center">
      <h1 class="display-2" style="color: #90A4AE;">MEMORIA</h1>
    </v-row>

    <select-level v-if="!gameMemoria" game="2" />
    <memoria-game v-if="gameMemoria" />
  </v-container>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import MemoriaGame from "../components/MemoriaGame";
import SelectLevel from "../components/SelectLevel";
export default {
  data() {
    return {
      game: false,
      cantidad: 0,
    };
  },
  components: {
    MemoriaGame,
    SelectLevel
  },
  methods: {
    ...mapMutations('memoria', ["setGameMemoriaOn", "setGameMemoriaOff"])
  },
  computed: {
    ...mapState('memoria', ["gameMemoria"])
  },
  beforeMount() {
    this.setGameMemoriaOff;
  }
};
</script>


/* async getElments() { try { let data = await axios.get(
"https://raw.githubusercontent.com/neelpatel05/periodic-table-api/master/home/neelpatel05/data.json"
); console.log(data); this.datosTabla = data; } catch (error) {
console.log(error); } }, */

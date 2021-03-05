<template>
    <v-dialog persistent v-model="dialog" max-width="400">
      <v-card class="mx-auto" max-width="400">
          <v-img class="white--text align-end" height="200px" :src="((status)?require('../assets/win.jpg'):require('../assets/gameOver.jpg'))">
          </v-img>
          <v-card-subtitle v-if="status">!Felicidades!, has superado este nivel.</v-card-subtitle>
          <v-card-subtitle v-if="!status">!Salsa tartara!, has fracasado este nivel. 😢 Inténtalo de nuevo.</v-card-subtitle>
          <v-card-text>
              Puntuación: {{points}}
          </v-card-text>
          <v-card-actions class="justify-end">
              <v-btn color="blue darken-1" text @click="getOut">Salir</v-btn>
          </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
import { mapState, mapMutations } from "vuex";

export default {
  props: ['points', 'status', 'game'],
  data: () => ({
      dialog: true,
  }),
  methods:{
    ...mapMutations(['setGameTetrisOff']),
    ...mapMutations('memoria', ['setGameMemoriaOff']),
    ...mapMutations('trivia', ['setGameTriviaOff']),
      getOut(){
        this.dialog = false;
        switch(this.game){
          case '1':
          break;
          case '2':
            this.setGameMemoriaOff()
          break;
          case '3':
            this.setGameTriviaOff()
          break;
        }
      }
  },
  computed:{
    ...mapState(['reportDialog'])
  }
};
</script>
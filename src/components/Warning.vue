<template>
  <v-dialog persistent v-model="dialog" max-width="500">
    <v-card class="mx-auto">
      <v-card-title> ¡ADVERTENCIA! </v-card-title>
      <v-card-subtitle
        >Esta acción es irreversible, ¿estas seguro?.</v-card-subtitle
      >
      <v-card-actions class="justify-end">
        <v-btn color="blue darken-1" text @click="aceptar()">Aceptar</v-btn>
        <v-btn color="blue darken-1" text @click="changeWarning()"
          >Cancelar</v-btn
        >
      </v-card-actions>
    </v-card>
    <v-snackbar v-model="snack" :timeout="2000">
      Parece que algo salio mal
    </v-snackbar>
  </v-dialog>
</template>

<script>
import axios from "axios";
import { url } from "../utils/services";
import { mapMutations } from "vuex";

export default {
  props: ["ruta"],
  data: () => ({
    dialog: true,
    snack: false,
  }),
  methods: {
    ...mapMutations(["changeWarning"]),
    aceptar: function () {
      axios
        .post(url + this.ruta.replace("/", ""))
        .then(() => {
          window.location.href = "/";
          location.reload();
        })
        .catch((this.snack = true));
    },
  },
  computed: {},
};
</script>
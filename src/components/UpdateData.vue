<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="500">
      <v-card>
        <v-form ref="form">
          <v-card-title>
            <span class="headline">Actualizad datos</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                    label="Nueva contraseña"
                    type="password"
                    v-model="passNew"
                    :rules="[
                      () =>
                        (!!passNew && passNew.length > 8) ||
                        'Ingrese una contraseña valida.',
                    ]"
                  ></v-text-field>
                </v-col>
                <v-divider></v-divider>
                <v-col cols="12">
                  <v-text-field
                    label="Contraseña actual"
                    type="password"
                    v-model="passOld"
                    :rules="[() => !!passOld || 'Este campo es obligatorio.']"
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-row>
              <v-col cols="12" sm="6">
                <v-btn color="blue darken-1" text @click="cambiarData()"
                  >Aceptar</v-btn
                >
              </v-col>
              <v-col cols="12" sm="6">
                <v-btn color="blue darken-1" text @click="changeChanges()"
                  >Cancelar</v-btn
                >
              </v-col>
            </v-row>
          </v-card-actions>
        </v-form>
      </v-card>
      <v-snackbar v-model="snack" :timeout="2000">
        Parece que algo salio mal
      </v-snackbar>
    </v-dialog>
  </v-row>
</template>

<script>
import { mapMutations } from "vuex";
import { resetPassword } from "../utils/services";

export default {
  data: () => ({
    dialog: true,
    passNew: null,
    passOld: null,
    snack: false,
  }),
  methods: {
    ...mapMutations(["changeChanges"]),
    cambiarData: function () {
      if (this.$refs.form.validate()) {
        resetPassword({
          actual: this.passOld,
          nueva: this.passNew,
        })
          .then(() => {
            this.changeChanges;
            window.location.href = "/";
            location.reload();
          })
          .catch((this.snack = true));
      }
    },
  },
  computed: {},
};
</script>

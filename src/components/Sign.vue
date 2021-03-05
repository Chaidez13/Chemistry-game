<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="620">
      <v-card max-width="616">
        <v-form ref="form">
          <v-card-title>
            <span v-if="registro" class="headline">Registrarse</span>
            <span v-if="!registro" class="headline">Iniciar Sesión</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col v-if="registro" cols="12" sm="6" md="4">
                  <v-text-field
                    label="Nombre(s)*"
                    v-model="nombre"
                    :rules="[() => !!nombre || 'Este campo es obligatorio.']"
                  ></v-text-field>
                </v-col>
                <v-col v-if="registro" cols="12" sm="6" md="4">
                  <v-text-field
                    label="Primer Apellido*"
                    v-model="primerApellido"
                    :rules="[
                      () => !!primerApellido || 'Este campo es obligatorio.',
                    ]"
                  ></v-text-field>
                </v-col>
                <v-col v-if="registro" cols="12" sm="6" md="4">
                  <v-text-field
                    label="Segundo Apellido*"
                    v-model="segundoApellido"
                    :rules="[
                      () => !!segundoApellido || 'Este campo es obligatorio.',
                    ]"
                  >
                  </v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    label="Correo*"
                    v-model="email"
                    :rules="[() => !!email || 'Este campo es obligatorio.']"
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    label="Contraseña*"
                    type="password"
                    v-model="pass"
                    v-if="registro"
                    :rules="[
                      () =>
                        (!!pass && pass.length > 8) ||
                        'Este campo es obligatorio y de 8 caracteres mínimo.',
                    ]"
                    hint="Longitud mínima de 8 caracteres"
                  ></v-text-field>
                  <v-text-field
                    label="Contraseña*"
                    type="password"
                    v-model="pass"
                    v-if="!registro"
                    :rules="[() => !!pass || 'Este campo es obligatorio.']"
                  ></v-text-field>
                </v-col>
                <v-col v-if="registro" cols="12">
                  <v-dialog
                    ref="dialog"
                    v-model="modal"
                    :return-value.sync="date"
                    persistent
                    width="290px"
                  >
                    <template v-slot:activator="{ on }">
                      <v-text-field
                        v-model="date"
                        label="Fecha de Nacimiento*"
                        :rules="[() => !!date || 'Este campo es obligatorio.']"
                        readonly
                        v-on="on"
                      ></v-text-field>
                    </template>
                    <v-date-picker v-model="date" :max="actual" scrollable>
                      <v-spacer></v-spacer>
                      <v-btn text color="primary" @click="modal = false"
                        >Cancel</v-btn
                      >
                      <v-btn
                        text
                        color="primary"
                        @click="$refs.dialog.save(date)"
                        >OK</v-btn
                      >
                    </v-date-picker>
                  </v-dialog>
                </v-col>
                <v-col cols="12">
                  <span class="red--text">{{ errorMessage }}</span>
                </v-col>
              </v-row>
            </v-container>
            <small>*Campos obligatorios</small>
          </v-card-text>
          <v-card-actions>
            <v-row>
              <v-col cols="12" sm="6">
                <v-btn
                  v-if="!registro"
                  color="blue darken-1"
                  text
                  @click="registro = true"
                  >No tengo una cuenta</v-btn
                >
                <v-btn
                  v-if="registro"
                  color="blue darken-1"
                  text
                  @click="registro = false"
                  >Ya tengo una cuenta</v-btn
                >
              </v-col>
              <v-col cols="12" sm="6">
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="$router.go(-1)"
                  >Cancelar</v-btn
                >
                <v-btn
                  v-if="registro"
                  color="blue darken-1"
                  text
                  @click="registrarse"
                  >Registrarse</v-btn
                >
                <v-btn
                  v-if="!registro"
                  color="blue darken-1"
                  text
                  @click="login"
                  >Inicar Sesión</v-btn
                >
              </v-col>
            </v-row>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { mapState, mapActions } from "vuex";
import { login, register } from "../utils/services";

export default {
  name: "Sign",
  data: () => ({
    dialog: true,
    email: null,
    pass: null,
    nombre: null,
    primerApellido: null,
    segundoApellido: null,
    registro: false,
    date: "",
    actual: new Date().toISOString().substr(0, 10),
    modal: "",
    errorMessage: "",
  }),
  methods: {
    ...mapActions(["validarSesion"]),
    login: function () {
      if (this.$refs.form.validate()) {
        login({
          email: this.email,
          password: this.pass,
        })
          .then(() => {
            this.validarSesion();
            window.location.href = "/";
          })
          .catch((e) => {
            const errorCode = e.response.status;
            if (errorCode == 422) {
              this.errorMessage = "Datos de acceso incorrectos";
            } else {
              this.errorMessage = "Ocurrio un error, intentelo de nuevo";
            }
          });
      }
    },
    registrarse: function () {
      if (this.$refs.form.validate()) {
        register({
          nombre: this.nombre,
          apellidoPaterno: this.primerApellido,
          apellidoMaterno: this.segundoApellido,
          email: this.email,
          password: this.pass,
          fecha: this.date,
        })
          .then(() => {
            console.log("Registro Exitoso");
            this.registro = false;
          })
          .catch((e) => console.log(e));
      }
    },
  },
  computed: {
    ...mapState(["sesion"]),
  },
};
</script>

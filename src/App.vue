<template>
  <v-app>
    <v-main>
      <v-row align="center" justify="center">
        <router-view />
      </v-row>
    </v-main>

    <v-navigation-drawer app>
      <v-list-item class="px-2" @click="userValidation">
        <v-list-item-content>
          <v-list-item-title v-if="sesion.status">{{
            sesion.name
          }}</v-list-item-title>
          <v-list-item-title v-if="!sesion.status"
            >Iniciar Sesión</v-list-item-title
          >
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-list>
        <v-list-item
          v-for="(item, i) in opciones"
          :key="i"
          link
          @click="changeOption(item.ruta)"
          v-show="item.show == sesion.status"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.opcion }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </v-app>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  name: "App",
  data: () => ({
    //
    drawer: null,
    opciones: [
      { opcion: "Juegos", icon: "mdi-gamepad-variant", ruta: "/", show: false },
      {
        opcion: "Enciclopedia",
        icon: "mdi-book-open-variant",
        ruta: "/encyclopedia",
        show: false,
      },
      {
        opcion: "Estadísticas",
        icon: "mdi-google-analytics",
        ruta: "/dashboard",
        show: false,
      },
      {
        opcion: "Ranking",
        icon: "mdi-format-list-numbered",
        ruta: "/ranking",
        show: false,
      },
      { opcion: "Opciones", icon: "mdi-cogs", ruta: "/options", show: false },
      {
        opcion: "Cerrar sesión",
        icon: "mdi-logout",
        ruta: "/logout",
        show: true,
      },
    ],
    // :/
  }),
  computed: {
    ...mapState(["sesion"]),
  },
  methods: {
    ...mapActions(["validarSesion"]),
    userValidation() {
      if (!this.sesion.status) this.$router.push({ name: "usuario" });
    },
    changeOption(ruta) {
      const actual = this.$route.path;
      if (ruta != actual) this.$router.push({ path: ruta });
    },
  },
  created() {
    this.validarSesion();
  },
};

//https://github.com/neelpatel05/periodic-table-api
</script>

<style scoped></style>

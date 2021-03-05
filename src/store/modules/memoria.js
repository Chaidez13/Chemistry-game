import { allGame } from "../../utils/services";

export default {
  namespaced: true,
  state: {
    gameMemoria: false,
    levelMemoria: null,
    nivelesMM: [
      {
        progreso: 0,
        nombre: "Nuevo ingreso",
        icon: "mdi-account-tie",
        color: "blue-grey lighten-3",
        dificultad: 1,
        status: true,
      },
      {
        progreso: 0,
        nombre: "Limpiador de tubos de ensayo",
        icon: "mdi-test-tube",
        color: "blue-grey lighten-2",
        dificultad: 2,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Titulador profesional",
        icon: "mdi-beaker",
        color: "blue-grey lighten-1",
        dificultad: 3,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Louis Pasteur",
        icon: "mdi-atom",
        color: "blue-grey darken-1",
        dificultad: 4,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Marie Curie",
        icon: "mdi-radioactive",
        color: "blue-grey darken-2",
        dificultad: 5,
        status: false,
      },
    ],
  },
  mutations: {
    setGameMemoriaOff(state) {
      state.gameMemoria = false;
    },
    setGameMemoriaOn(state) {
      state.gameMemoria = true;
    },
    setLevelMemoria(state, payload) {
      state.levelMemoria = payload;
    },
    setLevelData(state, payload) {
      state.nivelesMM[payload.position].progreso = payload.progreso;
      if (payload.position !== 4)
        state.nivelesMM[payload.position + 1].status = payload.estado;
    },
  },
  actions: {
    updateLevelDataMM: async function({ commit }) {
      allGame().then((d) => {
        const progress = d.data.filter((e) => e.idJuego == 2);
        for (let i = 0; i < progress.length; i++) {
          const payload = {
            position: i,
            progreso: progress[i].progreso,
            estado: progress[i].estado,
          };
          commit("setLevelData", payload);
        }
      });
    },
  },
};

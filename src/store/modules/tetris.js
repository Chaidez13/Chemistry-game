import { allGame } from "../../utils/services";

export default {
  namespaced: true,
  state: {
    gameTetris: false,
    levelTetris: null,
    nivelesTT: [
      {
        progreso: 0,
        nombre: "Nuevo ingreso",
        icon: "mdi-account-tie",
        color: "red lighten-2",
        dificultad: 1,
        status: true,
      },
      {
        progreso: 0,
        nombre: "Probador de probetas",
        icon: "mdi-test-tube",
        color: "red lighten-2",
        dificultad: 2,
        status: false,
      },
      {
        progreso: 0,
        nombre: "pH-rofesional",
        icon: "mdi-beaker",
        color: "red lighten-1",
        dificultad: 3,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Antoine Lavoisier",
        icon: "mdi-atom",
        color: "red darken-1",
        dificultad: 4,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Michael Faraday",
        icon: "mdi-radioactive",
        color: "red darken-2",
        dificultad: 5,
        status: false,
      },
    ],
  },
  mutations: {
    setGameTetrisOff(state) {
      state.gameTetris = false;
    },
    setGameTetrisOn(state) {
      state.gameTetris = true;
    },
    setLevelTetris(state, payload) {
      state.levelTetris = payload;
    },
    setLevelData(state, payload) {
      state.nivelesTT[payload.position].progreso = payload.progreso;
      if (payload.position !== 4)
        state.nivelesTT[payload.position + 1].status = payload.estado;
    },
  },
  actions: {
    updateLevelDataTT: function({ commit }) {
      allGame().then((d) => {
        const progress = d.data.filter((e) => e.idJuego == 1);
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

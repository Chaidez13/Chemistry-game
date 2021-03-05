import { allGame } from "../../utils/services";

export default {
  namespaced: true,
  state: {
    gameTrivia: false,
    levelTrivia: null,
    nivelesTR: [
      {
        progreso: 0,
        nombre: "Nuevo ingreso",
        icon: "mdi-account-tie",
        color: "amber lighten-2",
        dificultad: 1,
        status: true,
      },
      {
        progreso: 0,
        nombre: "Crisol para niños",
        icon: "mdi-test-tube",
        color: "amber lighten-2",
        dificultad: 2,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Al' Matraz",
        icon: "mdi-beaker",
        color: "amber lighten-1",
        dificultad: 3,
        status: false,
      },
      {
        progreso: 0,
        nombre: "John Dalton",
        icon: "mdi-atom",
        color: "amber darken-1",
        dificultad: 4,
        status: false,
      },
      {
        progreso: 0,
        nombre: "Ernest Rutherford",
        icon: "mdi-radioactive",
        color: "amber darken-2",
        dificultad: 5,
        status: false,
      },
    ],
  },
  mutations: {
    setGameTriviaOff(state) {
      state.gameTrivia = false;
    },
    setGameTriviaOn(state) {
      state.gameTrivia = true;
    },
    setLevelTrivia(state, payload) {
      state.levelTrivia = payload;
    },
    setLevelData(state, payload) {
      state.nivelesTR[payload.position].progreso = payload.progreso;
      if (payload.position !== 4)
        state.nivelesTR[payload.position + 1].status = payload.estado;
    },
  },
  actions: {
    updateLevelDataTR: function({ commit }) {
      allGame().then((d) => {
        const progress = d.data.filter((e) => e.idJuego == 3);
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

import axios from "axios";
import { domainDev, domainProd } from "./config";

export const url =
  process.env.NODE_ENV === "development" ? domainDev : domainProd;

export const getUserData = () => axios.get(url + "user/datos");

export const getMemoElements = () => axios.get(url + "memorama/elementos");

/**
 * Guardar Partida
 * @param {object} data
 * @param {number} data.idJuego
 * @param {number} data.idUsuario
 * @param {number} data.nivel
 * @param {number} data.puntos
 */

export const storeGame = (data) => axios.post(url + "partida/store", data);

/**
 * Actualizar Partida
 * @param {object} data
 * @param {number} data.nivel
 * @param {number} data.puntos
 * @param {number} data.progreso
 * @param {number} idPartida
 */

export const updateGame = (data, idPartida) =>
  axios.post(url + "partida/update/" + idPartida, data);

/**
 * Reportes
 * @param {object} data
 * @param {number} data.idUsuario
 * @param {number} data.juego
 * @param {string} data.mensaje
 */

export const reportStore = (data) => axios.post(url + "reporte/store", data);

/**
 * Tetris Level
 * @param {object} data
 * @param {number} data.nivel
 */

export const tetrisLevel = (data) => axios.post(url + "tetris/level", data);

/**
 * Login
 * @param {object} data
 * @param {string} data.email
 * @param {string} data.password
 */

export const login = (data) => axios.post(url + "login", data);

/**
 * Register
 * @param {object} data
 * @param {string} data.nombre
 * @param {string} data.apellidoPaterno
 * @param {string} data.apellidoMaterno
 * @param {string} data.fecha
 * @param {string} data.email
 * @param {string} data.password
 */

export const register = (data) => axios.post(url + "registro/user", data);

/**
 * Reset Password
 * @param {object} data
 * @param {string} data.actual
 * @param {string} data.nueva
 */

export const resetPassword = (data) =>
  axios.post(url + "user/resetPassword", data);

export const allGame = () => axios.get(url + "partida/all");

export const logOutService = () => axios.get(url + "logout");

export const triviaAnswers = () => axios.get(url + "trivia/respuestas");

export const getTopTen = () => axios.get(url + "partida/topTen");

export const glossary = () => axios.get(url + "glosario/elementos");

<template>
  <v-col>
    <v-card>
      <v-card-title>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          label="Buscar"
          single-line
          hide-details
        ></v-text-field>
      </v-card-title>
      <v-data-table
        :headers="headers"
        :items="elementData"
        :search="search"
        :items-per-page="20"
        class="elevation-1"
      ></v-data-table>
    </v-card>
  </v-col>
</template>

<script>
import data from "../database/data";

export default {
  name: "Encyclopedia",
  data: () => ({
    search: "",
    headers: [
      { text: "Número Atomico", value: "atomicNumber" },
      { text: "Símbolo", value: "symbol" },
      { text: "Nombre", value: "name" },
      { text: "Masa Atomica", value: "atomicMass" },
    ],
    elementData: [],
  }),
  created() {
    this.chargeTable();
  },
  methods: {
    chargeTable: function() {
      data.forEach((element) => {
        this.elementData.push({
          atomicNumber: element.atomicNumber,
          symbol: element.symbol,
          name: element.name,
          atomicMass: element.atomicMass,
        });
      });
    },
  },
};
</script>

<style></style>

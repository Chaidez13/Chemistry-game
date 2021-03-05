<template>
  <v-content>
    <!-- <v-row justify="end"> -->
      <div>
        <v-row  align="center" justify="center" >
          <h4 class="text-center">Vidas</h4>
        </v-row>
        <v-row>
          <v-col cols="4">
            <v-icon x-large v-if="cantVidas > 0" color="teal darken-2">mdi-test-tube</v-icon>
            <v-icon x-large v-else>mdi-test-tube-empty</v-icon>
          </v-col>
          <v-col cols="4">
            <v-icon x-large v-if="cantVidas > 1" color="teal darken-2">mdi-test-tube</v-icon>
            <v-icon x-large v-else>mdi-test-tube-empty</v-icon>
          </v-col>
          <v-col cols="4">
            <v-icon x-large v-if="cantVidas > 2" color="teal darken-2">mdi-test-tube</v-icon>
            <v-icon x-large v-else>mdi-test-tube-empty</v-icon>
          </v-col>
        </v-row>
      </div>
  <!--   </v-row> -->
  </v-content>
</template>

<script>
export default {
  props: ["cantVidas"],
  data() {
    return {};
  },
  created() {
    console.log(this.cantVidas);
  }
};
</script>


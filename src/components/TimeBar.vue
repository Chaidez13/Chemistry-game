<template>
  <v-row align="center" justify="center">
    <v-progress-linear
      :value="time"
      rounded
      height="10px"
      stream
      :buffer-value="time"
      style="max-width: 800px"
      :color="color"
    ></v-progress-linear>
  </v-row>
</template>

<script>
export default {
  props: ["time", "color"]
};
</script>

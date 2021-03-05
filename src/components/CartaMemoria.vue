<template>
  <div v-if="item.activa">
    <p>{{ item.info.atomicNumber }}</p>
    <p class="text-center display-1">{{ item.info.symbol }}</p>
    <p>{{ item.info.name }}</p>
    <p>{{ item.info.atomicMass }}</p>
  </div>
</template>

<script>
export default {
  props: ["item"]
};
</script>
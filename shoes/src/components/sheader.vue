<template>
  <header>
    <slot></slot>
    <p>{{ title }}</p>
  </header>
</template>

<script>
export default {
  name: "sheader",
  props: ["title"]
};
</script>

<style scoped>
header {
  width: 95%;
  height: 0.62rem;
  margin: 0 auto;
  position: relative;
}
.icon-tubiao_fanhui {
  position: absolute;
  top: 50%;
  transform: translate(0, -50%);
}
header p {
  font-size: 0.3rem;
  font-weight: bold;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
</style>
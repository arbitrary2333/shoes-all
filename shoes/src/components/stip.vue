<template>
  <div v-show="tipStatus">
      <div id="tip">{{tipMsg}}</div>
  </div>
</template>

<script>
export default {
  name: "sdialog",
  props:["tipMsg","tipStatus"]
}
</script>

<style scoped>
#tip{
    width: 100vw;
    height: 0.62rem;
    background: #64ecb6;
    text-align: center;
    line-height: 0.62rem;
    color: white;
    font-size: .4rem;
    font-weight: 600;
    position: fixed;
    top: 0;
}
</style>
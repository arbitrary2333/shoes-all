<template>
  <div id="app">
    <router-view v-if="isRouterAlive" />
  </div>
</template>

<script>
export default {
  name: "App",
  provide() {
    return {
      reload: this.reload,
    };
  },
  data() {
    return {
      isRouterAlive: true,
    };
  },
  methods: {
    reload() {
      this.isRouterAlive = false;
      this.$nextTick(() => {
        this.isRouterAlive = true;
      });
    },
  },
};
</script>

<style>
* {
  margin: 0;
  padding: 0;
}
#app {
  font-family: "苹方";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}

body {
  overflow-y: hidden;
}
/* 三行布局 */
#container {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
#container main {
  flex: 1;
  overflow-y: auto;
}

a {
  text-decoration: none;
  color: black;
}
li {
  list-style-type: none;
}
</style>

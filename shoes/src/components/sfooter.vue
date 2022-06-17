<template>
  <div>
    <slot></slot>
    <footer>
    <figure
      v-for="(item, index) in nav"
      :key="index"
      @click="selected(item.url)"
    >
      <router-link :to="item.url">
        <img :src="item.url===$route.path?item.imgtwo:item.img" alt="首页" title="首页" />
        <figcaption>{{ item.name }}</figcaption>
      </router-link>
    </figure>
  </footer>
  </div>
</template>

<script>
export default {
  name: "sfooter",
  data() {
    return {
      nav: [
        {
          name: "首页",
          url: "/",
          img: require("@/assets/imgs/home.png"),
          imgtwo: require("@/assets/imgs/home_selected.png"),
        },
        {
          name: "分类",
          url: "/classify",
          img: require("@/assets/imgs/classify.png"),
          imgtwo: require("@/assets/imgs/classify_selected.png"),
        },
        {
          name: "卖闲置",
          url: "/sale",
          img: require("@/assets/imgs/stand_idea.png"),
          imgtwo: require("@/assets/imgs/stand_idea.png"),
        },
        {
          name: "购物车",
          url: "/shopcar",
          img: require("@/assets/imgs/shopcar.png"),
          imgtwo: require("@/assets/imgs/shopcar_selected.png"),
        },
        {
          name: "我的",
          url: "/mine",
          img: require("@/assets/imgs/mine.png"),
          imgtwo: require("@/assets/imgs/mine_selected.png"),
        },
      ],
    };
  },
  methods: {
    selected(url) {
      // console.log(this.$route.path)
      if (this.$route.path !== url) {
        this.$router.push(url);
      }
    },
  },
};
</script>

<style scoped>
footer {
  width: 100vw;
  height: 0.98rem;
  background: #efefef;
  display: flex;
}
footer figure a {
  width: 20vw;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
footer figure img {
  width: 0.48rem;
  height: 0.48rem;
}
footer figure figcaption {
  font-size: 0.18rem;
  font-weight: bold;
}
footer figure span {
  font-size: 0.48rem;
  color: #333333;
}

.pay{
  width: 95%;
  height: .62rem;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
}
.pay figure{
  height: .62rem;
  display: flex;
  align-items: center;
}
.pay figure img{
  width: .32rem;
  height: .32rem;
}
.pay figure figcaption{
  font-size: .18rem;
  margin-left: .16rem;
  font-weight: bold;
}
.pay section{
  height: .62rem;
  display: flex;
  align-items: center;
}
.pay section p:nth-child(1){
  font-size: .18rem;
  font-weight: bold;
}
.pay section p:nth-child(2){
  font-size: .24rem;
  font-weight: bolder;
}
.pay section p:nth-child(3){
  width: 1.38rem;
  height: .62rem;
  text-align: center;
  line-height: .62rem;
  border-radius: .1rem;
  background: #be0000;
  font-size: .24rem;
  color: white;
}
.pay section p{
  margin-left: .2rem;
}
</style>
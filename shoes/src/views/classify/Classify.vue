<template>
  <div id="container">
    <header>
      <!-- 搜索框 -->
      <search></search>
    </header>
    <main>
      <!-- 左侧 -->
      <ul class="left">
        <li
          :class="{ active: current == index }"
          v-for="(item, index) in classify"
          :key="index"
          @click="tab(index)"
        >
          {{ item.title }}
        </li>
      </ul>
      <!-- 右侧 -->
      <div class="right">
        <!-- 分类列表 -->
        <div
          class="list"
          v-for="(item, index) in classify"
          :key="index"
          v-show="current == index"
        >
          <!-- 热门推荐 -->
          <div class="recommend">
            <h2>热门推荐</h2>
            <div class="rec_cnt">
              <figure
                v-for="(itemOne, indexOne) in item.info.recommend"
                :key="indexOne"
                @click="goRecommend(itemOne.id)"
              >
                <img :src="itemOne.img" alt="" />
                <figcaption>{{ itemOne.name }}</figcaption>
              </figure>
            </div>
          </div>
          <!-- 热卖品牌 -->
          <div class="brand">
            <h2>热卖品牌</h2>
            <div class="bra_cnt">
              <figure
                v-for="(itemTwo, indexTwo) in item.info.brand"
                :key="indexTwo"
                @click="list(itemTwo.id, itemTwo.name)"
              >
                <img :src="itemTwo.img" alt="" />
                <figcaption>{{ itemTwo.name }}</figcaption>
              </figure>
            </div>
          </div>
        </div>
      </div>
    </main>
    <sfooter></sfooter>
  </div>
</template>

<script>
import search from "@/components/search.vue";
import sfooter from "@/components/sfooter.vue";
export default {
  name: "Classify",
  components: { search, sfooter },
  data() {
    return {
      current: 0,
      classify: [],
    };
  },
  mounted() {
    this.getClassifyAllInfo();
  },
  methods: {
    tab(index) {
      this.current = index;
    },
    list(bid, name) {
      this.$router.push({ name: "classifyList", query: { bid, name } });
    },
    goRecommend(id) {
      this.$router.push({ name: "productDetail", query: { id } });
    },
    getClassifyAllInfo() {
      let self = this;
      this.$axios.get("/index/classify/classifyAllInfo").then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.classify = res.data.data;
            self.classify.forEach((item) => {
              item.info.recommend.forEach((itemr) => {
                if (itemr.img) {
                  itemr.img = "http://www.shoes.com:8081" + itemr.img;
                }
              });
              item.info.brand.forEach((itemb) => {
                if (itemb.img) {
                  itemb.img = require("@/assets" + itemb.img);
                }
              });
            });
          }
        },
        (err) => {
          console.log(res);
        }
      );
    },
  },
};
</script>

<style scoped>
main {
  width: 95%;
  margin: 0 auto;
  margin-top: 0.24rem;
  overflow-y: hidden;
  display: flex;
  justify-content: space-between;
}
.left {
  width: 2.07rem;
  /* border: 1px solid red; */
  overflow-y: auto;
}
.left li {
  width: 100%;
  height: 1rem;
  font-size: 0.3rem;
}
/* 被点击时 */
.active {
  font-size: 0.36rem !important;
  font-weight: bolder;
  color: black;
}
.right {
  width: 4.85rem;
  overflow-y: auto;
}
.recommend {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.recommend h2 {
  font-size: 0.3rem;
  font-weight: bolder;
}
.rec_cnt {
  width: 100%;
  display: flex;
  flex-flow: wrap row;
  justify-content: start;
}
.rec_cnt figure {
  width: 1.5rem;
  height: 1.7rem;
  margin-top: 0.1rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  font-size: 0.16rem;
  margin-right: calc((100% - 4.5rem) / 3);
}
.rec_cnt figure img {
  width: 1.5rem;
  height: 1.5rem;
}
.brand {
  width: 100%;
  margin-top: 0.35rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.brand h2 {
  font-size: 0.3rem;
  font-weight: bolder;
}
.bra_cnt {
  width: 100%;
  display: flex;
  flex-flow: wrap row;
  justify-content: start;
}
.bra_cnt figure {
  width: 1.5rem;
  height: 1.7rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  font-size: 0.16rem;
  margin-right: calc((100% - 4.5rem) / 3);
}
.bra_cnt figure img {
  width: 1.5rem;
  height: 1.5rem;
}
</style>
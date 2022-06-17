<template>
  <div id="container">
    <sheader title="卖闲置">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <h3>请选择您要出售的宝贝分类</h3>
      <div class="content">
        <figure
          v-for="item in classifyList"
          :key="item.id"
          @click="publish(item.id)"
        >
          <figcaption>
            <strong>{{ item.name }}</strong>
            <p>{{ item.alias }}</p>
          </figcaption>
          <img :src="item.imgurlc" alt="" />
        </figure>
      </div>
    </main>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
export default {
  name: "Sale",
  components: { sheader },
  data() {
    return {
      classifyAlias: ["SHOES", "BAGS", "WATCHES", "CLOTHES", "ACCESSORIES"],
      classifyList: [],
    };
  },
  mounted() {
    let self = this;
    this.$axios.get("/index/Sale/classifyList").then(
      (res) => {
        if (res.data.ret == 200 && res.data.data.length > 0) {
          self.classifyList = res.data.data;
          self.classifyList.forEach((item, index) => {
            item.alias = self.classifyAlias[index];
          });
          self.classifyList = self.classifyList.map((item) => {
            item.imgurlc = "http://www.shoes.com:8081" + item.imgurlc;
            return item;
          });
        }
        console.log(self.classifyList)
      },
      (err) => {
        console.log(err);
      }
    );
  },
  methods: {
    went() {
      this.$router.replace("/");
    },
    publish(id) {
      // query传递的参数会显示在url后面?id=？
      // 通过params的方式，路径不会显示传递的参数
      this.$router.push({ path: "/release", query: { id: id } });
    },
  },
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
main h3 {
  font-size: 0.24rem;
  font-weight: bold;
  margin: 0.4rem auto;
  text-align: center;
}
.content {
  width: 6.46rem;
  display: flex;
  flex-flow: wrap row;
  justify-content: space-between;
  margin: 0 auto;
}
.content figure {
  width: 2.82rem;
  height: 1.22rem;
  display: flex;
  justify-content: space-around;
  align-items: center;
  box-shadow: 5px 5px 5px #cecece;
  margin-top: 0.35rem;
}
.content figure figcaption {
  height: 0.6rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.content figure figcaption strong {
  font-size: 0.24rem;
  letter-spacing: 0.27rem;
}
.content figure figcaption p {
  font-size: 0.18rem;
  line-height: 0.2rem;
  letter-spacing: 0.05rem;
}
.content figure img {
  width: 0.82rem;
  height: 0.82rem;
}
</style>
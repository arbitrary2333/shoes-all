<template>
  <div id="classifyList">
    <sheader :title="name">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <!-- <ul class="select">
        <li>综合</li>
        <li>销量</li>
        <li>价格</li>
        <li>成色</li>
      </ul> -->
      <div class="content" v-if="classifyList.length > 0">
        <figure
          v-for="(item, index) in classifyList"
          :key="index"
          @click="detail(item.id)"
        >
          <img :src="item.imgurl" alt="" />
          <section>
            <figcaption>{{ item.size }}{{ item.goods_name }}</figcaption>
            <p>
              ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
            </p>
          </section>
        </figure>
      </div>
      <div v-else class="noContent">暂无数据</div>
    </main>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
export default {
  name: "classifyList",
  components: { sheader },
  data() {
    return {
      name: "",
      classifyList: [],
    };
  },
  created() {
    if (Object.keys(this.$route.query)[0] == "cid") {
      this.getDiffClassify();
    } else if (Object.keys(this.$route.query)[0] == "aid") {
      if (this.$route.query.aid == 1) {
        this.name = "今日上新";
        this.getDiffActivity(1);
      } else {
        this.name = "促销商品";
        this.getDiffActivity(2);
      }
    } else if (Object.keys(this.$route.query)[0] == "bid") {
      this.name = this.$route.query.name;
      this.getBrandList(this.$route.query.bid);
    }
  },
  methods: {
    getDiffClassify() {
      let cid = this.$route.query.cid;
      this.$axios.get("/index/classifylist/diffClassify?cid=" + cid).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            this.classifyList = res.data.data;
            this.name = this.classifyList[0].name;
            this.classifyList = this.classifyList.map((item) => {
              item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
              return item;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getDiffActivity(aid) {
      this.$axios.get("/index/classifylist/diffActivity?aid=" + aid).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            this.classifyList = res.data.data;
            this.classifyList = this.classifyList.map((item) => {
              item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
              return item;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getBrandList(bid) {
      this.$axios
        .get("/index/classifylist/diffBrand?bid=" + bid)
        .then((res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            this.classifyList = res.data.data;
            this.classifyList = this.classifyList.map((item) => {
              item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
              return item;
            });
          }else{
            this.classifyList = []
          }
        });
    },
    went() {
      this.$router.go(-1);
    },
    detail(id) {
      this.$router.push({ name: "productDetail", query: { id } });
    },
  },
};
</script>

<style scoped>
#classifyList {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
}
main {
  width: 100%;
  flex: 1;
  overflow-y: auto;
}
.select {
  width: 100%;
  height: 0.7rem;
  display: flex;
}
.select li {
  flex: 1;
  font-size: 0.24rem;
  font-weight: bold;
  text-align: center;
  line-height: 0.7rem;
}
.content {
  width: 100%;
  display: flex;
  flex-flow: wrap row;
  border-top: 1px solid #666666;
}
.content figure:nth-child(odd) {
  width: 50%;
  height: 3.35rem;
  border-bottom: 1px solid #666666;
  border-right: 1px solid #666666;
  box-sizing: border-box;
}
.content figure:nth-child(even) {
  width: 50%;
  height: 3.35rem;
  border-bottom: 1px solid #666666;
  box-sizing: border-box;
}
.content figure {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.content figure img {
  width: 2.28rem;
  height: 2.28rem;
}
.content figure section {
  width: 60%;
}
.content figure section figcaption {
  font-size: 0.18rem;
}
.content figure section p {
  font-size: 0.24rem;
  font-weight: bolder;
}
.content figure section p del {
  margin-left: 0.1rem;
  font-size: 0.14rem;
  color: #666666;
}
.noContent{
  font-size: .3rem;
  text-align: center;
  padding-top: 1rem;
}
</style>
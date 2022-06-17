<template>
  <div id="saleProductInfo">
    <sheader title="商品成色">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <ul class="content">
        <li v-for="item in partList" @click="selectStatus(item)">{{ item.name }}</li>
      </ul>
    </main>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
export default {
  name: "SaleProductInfo",
  components: { sheader },
  data() {
    return {
      partList: [],
    };
  },
  mounted() {
    let status = this.$route.query.detailInfo;
    if (status == "brand") {
      this.getDiffBrandList();
    } else if (status == "condition") {
      this.getConditionList();
    } else if (status == "time") {
      this.getTimeList();
    } else if (status == "freeshippingInfo") {
      this.getFreeshippingList();
    }
  },
  methods: {
    getDiffBrandList() {
      let self = this;
      this.$axios
        .get("/index/sale/diffBrandList?cid=" + this.$route.query.id)
        .then(
          (res) => {
            console.log(this.$route)
            if (res.data.ret == 200 && res.data.data.length > 0) {
              self.partList = res.data.data.map((list) => {
                list.name = list.brand_name;
                delete list.brand_name;
                list.kind = "brand"
                return list;
              });
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    getConditionList() {
      let self = this
      this.$axios.get("/index/sale/conditionList").then(
        (res) => {
          console.log(res);
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.partList = res.data.data.map((list) => {
              list.name = list.condition_name;
              delete list.condition_name;
              list.kind = "condition"
              return list;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getTimeList() {
      let self = this;
      this.$axios.get("/index/sale/timeList").then(
        (res) => {
          console.log(res);
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.partList = res.data.data.map((list) => {
              list.name = list.time_name;
              delete list.time_name;
              list.kind = "time"
              return list;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getFreeshippingList() {
      let self = this;
      this.$axios.get("/index/sale/freeshippingList").then(
        (res) => {
          console.log(res);
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.partList = res.data.data.map((list) => {
              list.name = list.freeShipping_name;
              delete list.freeShipping_name;
              list.kind = "freeshipping"
              return list;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    selectStatus(part){
      this.$router.replace({
        path:"/release",
        query:{part:part,classifyId:this.$route.query.id}
      });
    },
    went() {
      this.$router.go(-1);
    },
  },
};
</script>

<style scoped>
#saleProductInfo {
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
.content {
  width: 100%;
  height: auto;
}
.content li {
  width: 95%;
  height: 0.66rem;
  font-size: 0.24rem;
  border-bottom: 1px solid #eee;
  text-align: left;
  line-height: 0.66rem;
  margin: 0 auto;
}
</style>
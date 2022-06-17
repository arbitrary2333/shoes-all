<template>
  <div id="saleProductInfo" v-if="status">
    <sheader :title="title">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <ul class="content">
        <li v-for="item in partList" @click="selectStatus(item)">
          {{ item.name }}
        </li>
      </ul>
    </main>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
export default {
  name: "selectTmp",
  props: {
    status: {
      type: Boolean,
      default: false,
    },
    condition: {
      type: String,
      default: "",
    },
    classifyId: {
      type: Number,
      default: 0,
    },
  },
  components: { sheader },
  data() {
    return {
      partList: [],
      title:""
    };
  },
  watch: {
    condition(newVal) {
      switch (newVal) {
        case "brand":
          this.partList = [];
          this.title = "商品品牌"
          this.getDiffBrandList();
          break;
        case "color":
          this.partList = [];
          this.title = "商品成色"
          this.getColorList();
          break;
        case "time":
          this.partList = [];
          this.title = "发货时间"
          this.getTimeList();
          break;
        case "free":
          this.partList = [];
          this.title = "是否包邮"
          this.getFreeshippingList();
          break;
      }
    },
  },
  methods: {
    getDiffBrandList() {
      let self = this;
      this.$axios.get("/index/sale/diffBrandList?cid=" + this.classifyId).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.partList = res.data.data.map((list) => {
              list.name = list.brand_name;
              delete list.brand_name;
              list.kind = "brand";
              return list;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getColorList() {
      let self = this;
      this.$axios.get("/index/sale/conditionList").then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.partList = res.data.data.map((list) => {
              list.name = list.condition_name;
              delete list.condition_name;
              list.kind = "condition";
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
              list.kind = "time";
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
              list.kind = "freeshipping";
              return list;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    selectStatus(part) {
      this.$emit("conditionChange", part, this.condition);
    },
    went() {
      this.$emit("statusChange", false);
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
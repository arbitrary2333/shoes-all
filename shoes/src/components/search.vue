<template>
  <div id="search">
    <span class="iconfont icon-tubiao_sousuo"></span>
    <input
      type="text"
      placeholder="鸿星尔克"
      @input="search"
      v-model="inputInfo"
    />
    <ul v-show="searchInfo.length > 0" class="searchResult">
      <li
        v-for="item in searchInfo"
        :key="item.id"
        @click="goProductDetail(item.id)"
      >
        {{ item.goods_name }}
      </li>
    </ul>
  </div>
</template>

<script>
import { Debounce } from "../assets/js/debouce";
export default {
  name: "search",
  data() {
    return {
      inputInfo: "",
      searchInfo: [],
    };
  },
  mounted() {},
  watch: {},
  methods: {
    // 精准查询
    searchProductData() {
      let self = this;
      if (this.inputInfo) {
        this.$axios
          .post("/index/index/searchInfo?goods_name=" + this.inputInfo)
          .then(
            (res) => {
              if (res.data.data.length > 0) {
                self.searchInfo = res.data.data;
              } else {
                // 未检索到结果
                self.searchInfo = [];
              }
            },
            (err) => {
              console.log(err);
            }
          );
      } else {
        // 修复bug：用户删除input框的值弹框会一直显示
        self.searchInfo = [];
        return false;
      }
    },
    search() {
      // 封装的防抖功能
      Debounce(this.searchProductData);
    },
    goProductDetail(id) {
      this.$router.push({ name: "productDetail", query: { id } });
    },
  },
};
</script>

<style scoped>
#search {
  width: 95%;
  height: 0.52rem;
  margin: 0 auto;
  background: #eaeaea;
  border-radius: 0.05rem;
  margin-top: 0.13rem;
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
#search span {
  font-size: 0.32rem;
  margin-left: 0.08rem;
}
#search input {
  width: calc(95% - 0.32rem - 1%);
  height: 100%;
  border: none;
  background: none;
  outline: none;
  color: #333333;
  font-size: 0.18rem;
  margin-right: 0.08rem;
}
.searchResult {
  width: 100%;
  font-size: 0.18rem;
  border: 1px solid #333333;
  box-sizing: border-box;
  background: white;
  z-index: 999;
  position: absolute;
  top: 0.52rem;
}
.searchResult li {
  width: 100%;
  height: 0.5rem;
  line-height: 0.5rem;
  box-sizing: border-box;
  padding-left: 5px;
  border-bottom: 1px solid #333333;
}
.searchResult li:active {
  background: #eaeaea;
}
</style>
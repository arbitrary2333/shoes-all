<template>
  <div id="saleProductInfo" v-if="status">
    <sheader title="收货人信息">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <ul class="content">
        <li class="address" v-for="item in consigneeInfo" :key="item.id" @click="goOrder(item)">
          <p>*</p>
          <p>{{ item.consignee_address }}</p>
          <p>{{ item.consignee_name }} {{ item.phone }}</p>
          <span
            class="iconfont icon-tubiao_fanhui"
            @click="goOrder(item)"
          ></span>
        </li>
      </ul>
    </main>
    <footer @click="goAddConsignee">添加收货地址</footer>
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
    }
  },
  components: { sheader },
  data() {
    return { consigneeInfo: [] };
  },
  created() {
    this.getConsigneeInfo();
  },
  methods: {
    goAddConsignee(){
      this.$router.push("/addConsignee")
    },
    getConsigneeInfo() {
      let uid = JSON.parse(sessionStorage.getItem("member")).id;
      this.$axios.get("/index/order/consigneeInfo?uid=" + uid).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            this.consigneeInfo = res.data.data;
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    went() {
      this.$emit("statusChange", false);
    },
    goOrder(item) {
      this.$emit("consigneeChange", item);
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
.address {
  width: 93%;
  height: 1.4rem;
  margin: 0 auto;
  position: relative;
}
.address p:nth-child(1) {
  font-size: 0.18rem;
  color: #999999;
  position: absolute;
  left: 0;
  top: 0.15rem;
}
.address p:nth-child(3) {
  font-size: 0.18rem;
  color: #999999;
  position: absolute;
  left: 0;
  bottom: 0.15rem;
}
.address p:nth-child(2) {
  font-size: 0.24rem;
  color: black;
  position: absolute;
  left: 0;
  top: 50%;
  transform: translate(0, -50%);
}
.address span {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translate(0, -50%);
  transform: rotate(180deg);
}
footer {
  width: 100%;
  height: 1rem;
  background: #be0000;
  color: white;
  text-align: center;
  line-height: 1rem;
  font-size: 0.3rem;
  border: none;
  position: absolute;
  bottom: 0;
}
</style>
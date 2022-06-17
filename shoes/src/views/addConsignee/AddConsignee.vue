<template>
  <div id="container">
    <sheader title="添加收货信息">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <div class="consigneeName">
        <p>姓名：</p>
        <input
          type="text"
          placeholder="请添加收货人姓名"
          v-model="consignee_name"
        />
      </div>
      <div class="consigneeAddress">
        <p>地址：</p>
        <input
          type="text"
          placeholder="请添加收货人地址(省/市/XXX)"
          v-model="consignee_address"
        />
      </div>
      <div class="consigneePhone">
        <p>手机号码：</p>
        <input
          type="number"
          placeholder="请添加收货人手机号码"
          v-model="phone"
        />
      </div>
    </main>
    <footer @click="add">确认添加</footer>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import stip from "@/components/stip.vue";
export default {
  name: "AddConsignee",
  components: { sheader, stip },
  data() {
    return {
      consignee_name: "",
      consignee_address: "",
      phone: "",
      tipStatus: "",
      tipMsg: "",
    };
  },
  methods: {
    add() {
      let self = this;
      if (!self.consignee_name || !self.consignee_address || !self.phone) {
        self.tipStatus = true;
        self.tipMsg = "参数未填写完整！";
        setTimeout(() => {
          self.tipStatus = false;
        }, 2000);
      } else {
        this.$axios
          .post("/index/order/addConsignee", {
            consignee_name: self.consignee_name,
            consignee_address: self.consignee_address,
            phone: self.phone,
            uid: JSON.parse(sessionStorage.getItem("member")).id,
          })
          .then(
            (res) => {
              if (res.data.ret == 200) {
                self.tipStatus = true;
                self.tipMsg = "添加成功！";
                setTimeout(() => {
                  self.tipStatus = false;
                  this.$router.go(-1)
                }, 3000);
                console.log(res);
              }
            },
            (err) => {
              console.log(err);
            }
          );
      }
    },
    went() {
      this.$router.go(-1);
    },
  },
};
</script>

<style scoped>
main {
  width: 100%;
}
.consigneeName,
.consigneeAddress,
.consigneePhone {
  width: 95%;
  height: 0.8rem;
  border-bottom: 1px solid #eee;
  box-sizing: border-box;
  font-size: 0.24rem;
  font-weight: bolder;
  margin: 0 auto;
  display: flex;
  align-items: center;
}
.consigneeName input,
.consigneeAddress input,
.consigneePhone input {
  width: calc(100% - 1.4rem);
  font-size: 0.24rem;
  height: 0.8rem;
  border: none;
  outline: none;
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
<template>
  <div id="container">
    <sheader title="确认订单" v-if="!status">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main v-if="!status">
      <div v-if="Object.keys(consigneeInfo).length" class="address">
        <p>*</p>
        <p>{{ consigneeInfo.consignee_address }}</p>
        <p>{{ consigneeInfo.consignee_name }} {{ consigneeInfo.phone }}</p>
        <span @click="goConsignee" class="iconfont icon-tubiao_fanhui"></span>
      </div>
      <div v-else class="address">
        <p>请添加收货地址</p>
        <p @click="goAddConsignee" style="fontSize:1rem;color: black;position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);">+</p>
      </div>
      <div class="list">
        <h3>购买清单</h3>
        <div class="list_cnt" v-for="item in productInfo" :key="item.id">
          <img :src="item.imgurl" alt="" />
          <div class="list_right">
            <p>{{ item.size }} {{ item.goods_name }}</p>
            <p>
              ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
            </p>
            <p>不支持退货</p>
          </div>
        </div>
        <div class="totalPrice">
          <span>商品金额</span>
          <span>￥{{ totalPrice }}.00</span>
        </div>
        <div class="fare">
          <span>运费</span>
          <span>{{
            freeshipping == 0 ? "￥0.00" : "￥" + freeshipping + ".00"
          }}</span>
        </div>
        <div class="fare">
          <span>付费方式</span>
          <span>货到付款</span>
        </div>
        <div class="discount">
          <span>优惠卷<span style="color:#999999;fontSize:0.18rem">(已为您自动计算优惠)</span></span>
          <span>￥{{ discount }}.00</span>
          <!-- <span class="iconfont icon-tubiao_fanhui"></span> -->
        </div>
        <p class="total_two">
          合计<strong>￥{{ totalPrice + freeshipping - discount }}.00</strong>
        </p>
      </div>
    </main>
    <footer v-if="!status">
      <p>实付：￥{{ totalPrice + freeshipping - discount }}.00</p>
      <p @click="commitOrder">提交订单</p>
    </footer>
    <sharvest
      :status="status"
      @statusChange="statusChange"
      @consigneeChange="consigneeChange"
    ></sharvest>
    <sdialog
      :dialogStatus="dialogStatus"
      :dialogMsg="dialogMsg"
      :buttonStatus="buttonStatus"
      @getDialogStatus="getDialogStatus"
    ></sdialog>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import sharvest from "@/components/sharvest.vue";
import sdialog from "@/components/sdialog";
export default {
  name: "Order",
  components: { sheader, sharvest, sdialog },
  data() {
    return {
      status: false,
      consigneeInfo: {},
      productInfo: [],
      totalPrice: 0,
      fareSize: 10,
      discount: 0,
      totalFare: 0,
      dialogStatus: false,
      dialogMsg: "",
      buttonStatus: false,
      discounts: [200, 500, 800],
      discountInfo: [],
    };
  },
  created() {
    this.getConsigneeInfo();
    let orderInfo = JSON.parse(localStorage.getItem("orderInfo"))
    this.productInfo = orderInfo.goods;
    if (!this.productInfo[0].goods_id) {
      this.productInfo[0].goods_id = this.productInfo[0].id;
    }
    this.totalPrice = orderInfo.totalPrice;
  },
  mounted(){
    this.getDiscountPrice();
  },
  computed: {
    freeshipping() {
      let totalFare = 0;
      this.productInfo.forEach((item) => {
        if (item.fsid == 2) {
          totalFare += this.fareSize;
        }
      });
      this.totalFare = totalFare;
      return totalFare;
    },
  },
  methods: {
    goAddConsignee(){
      this.$router.push("/addConsignee")
    },
    getDiscountPrice() {
      let self = this;
      let id = JSON.parse(sessionStorage.getItem("member")).id;
      this.$axios.get("/index/order/user?id=" + id).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.discountInfo = res.data.data;
            if(self.discountInfo[0].discount_price){
              self.discounts = self.discountInfo[0].discount_price.split(",");
            }else{
              return
            }
            self.discounts = self.discounts.map(item => {
              return Number(item)
            })
            if(self.totalPrice >= 200 && self.totalPrice < 500 && self.discounts.includes(20)){
              self.discount = 20
            }else if(self.totalPrice >= 500 && self.totalPrice < 800 && self.discounts.includes(50)){
              self.discount = 50
            }else if(self.totalPrice >= 800 && self.discounts.includes(80)){
              self.discount = 80
            }
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getConsigneeInfo() {
      let self = this;
      let uid = JSON.parse(sessionStorage.getItem("member")).id;
      this.$axios.get("/index/order/consigneeInfo?uid=" + uid).then(
        (res) => {
          if (res.data.ret == 200 && res.data.data.length > 0) {
            self.consigneeInfo = res.data.data[0];
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    goConsignee() {
      this.status = true;
    },
    went() {
      this.$router.go(-1);
    },
    statusChange(change) {
      this.status = change;
    },
    consigneeChange(change) {
      this.status = false;
      this.consigneeInfo = change;
    },
    commitOrder() {
      let self = this;
      let user_id = JSON.parse(sessionStorage.getItem("member")).id;
      let totalPrice = this.totalPrice + this.totalFare - this.discount;
      let productInfo = this.productInfo;
      if(!Object.keys(self.consigneeInfo).length){
        this.dialogStatus = true;
        this.dialogMsg = "请添加收货信息！";
        setTimeout(() => {
          this.dialogStatus = false;
        }, 2000);
        return
      }
      this.$axios
        .post("/index/order/commitOrder", {
          consignee_address: self.consigneeInfo.consignee_address,
          consignee_name: self.consigneeInfo.consignee_name,
          consignee_phone: self.consigneeInfo.phone,
          user_id,
          totalPrice,
          productInfo,
          discount: self.discount
        })
        .then(
          (res) => {
            if (res.data.ret == 200) {
              this.dialogStatus = true;
              this.dialogMsg = "提交成功！";
              setTimeout(() => {
                this.dialogStatus = false;
                localStorage.removeItem("orderInfo")
                this.$router.push("/");
              }, 2000);
            } else {
              this.dialogStatus = true;
              this.dialogMsg = "提交失败！";
              setTimeout(() => {
                this.dialogStatus = false;
              }, 2000);
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    getDialogStatus(data) {
      this.dialogStatus = !data;
    },
  },
};
</script>

<style scoped>
main {
  width: 100%;
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
.list {
  width: 93%;
  margin: 0 auto;
  margin-top: 0.3rem;
}
.list h3 {
  font-size: 0.24rem;
  font-weight: bold;
}
.list_cnt {
  width: 100%;
  height: 2.07rem;
  border-top: 1px solid #eeeeee;
  box-sizing: border-box;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.list_cnt img {
  width: 1.87rem;
  height: 1.12rem;
}
.list_right {
  width: 50%;
  height: 1.4rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.list_right p:nth-child(1) {
  font-size: 0.18rem;
}
.list_right p:nth-child(2) {
  font-size: 0.24rem;
  font-weight: bolder;
}
.list_right p:nth-child(2) del {
  font-size: 0.14rem;
  color: #666666;
}
.list_right p:nth-child(3) {
  width: 1.12rem;
  height: 0.3rem;
  border: 2px solid #be0000;
  color: #be0000;
  text-align: center;
  line-height: 0.3rem;
  font-size: 0.16rem;
  font-weight: bolder;
  border-radius: 5px;
}
.totalPrice,
.fare,
.discount {
  width: 93%;
  margin: 0 auto;
  margin-bottom: 0.3rem;
  display: flex;
  justify-content: space-between;
}
.totalPrice span:nth-child(1),
.fare span:nth-child(1),
.discount span:nth-child(1) {
  font-size: 0.24rem;
  font-weight: bold;
}
.totalPrice span:nth-child(2),
.fare span:nth-child(2),
.discount span:nth-child(2) {
  font-size: 0.18rem;
}
/* .discount {
  width: 93%;
  height: 0.3rem;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
} */
/* .discount span:nth-child(1) {
  font-size: 0.24rem;
  font-weight: bold;
  position: absolute;
  left: 0;
}
.discount span:nth-child(2) {
  font-size: 0.18rem;
  position: absolute;
  right: 0.24rem;
}
.discount span:nth-child(3) {
  font-size: 0.18rem;
  position: absolute;
  right: 0;
  transform: rotate(180deg);
} */
.total_two {
  width: 93%;
  margin: 0 auto;
  margin-top: 0.7rem;
  text-align: end;
  font-size: 0.18rem;
}
.total_two strong {
  font-size: 0.24rem;
  font-weight: bolder;
  margin-left: 0.15rem;
}
footer {
  width: 95%;
  height: 1rem;
  margin: 0 auto;
  border-top: 1px solid #eeeeee;
  box-sizing: border-box;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
}
footer p:nth-child(1) {
  font-size: 0.24rem;
  font-weight: bolder;
}
footer p:nth-child(2) {
  width: 2.9rem;
  height: 0.67rem;
  border-radius: 5px;
  text-align: center;
  line-height: 0.67rem;
  color: white;
  background: #be0000;
  font-size: 0.3rem;
  font-weight: bolder;
}
</style>
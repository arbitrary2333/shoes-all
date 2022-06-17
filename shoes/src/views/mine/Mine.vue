<template>
  <div id="container">
    <header>
      <span @click="getNews" class="iconfont icon-tubiao_xiaoxi"></span>
    </header>
    <main>
      <!-- 头像 -->
      <div v-if="username" style="justify-content: space-between" class="head">
        <p>{{ username }}<br />欢迎您~</p>
        <p @click="logout" style="color: red">退出</p>
      </div>
      <div v-else class="head" @click="login">
        <span class="iconfont icon-touxiang"></span>
        <p>登录/注册</p>
      </div>
      <!-- 收藏，优惠 -->
      <!-- <div class="coll_sale">
        <div class="collect">
          <p>2</p>
          <p>收藏</p>
        </div>
        <div class="sale">
          <p>5</p>
          <p>优惠卷</p>
        </div>
      </div> -->
      <!-- 我的订单 -->
      <div class="order">
        <div class="order_top">
          <h3>我的订单</h3>
          <div class="order_more" @click="myOrder">
            <p>全部订单</p>
            <span class="iconfont icon-tubiao_fanhui"></span>
          </div>
        </div>
        <div class="order_bottom">
          <figure>
            <span class="iconfont icon-pay"></span>
            <figcaption>待付款</figcaption>
          </figure>
          <figure @click="myOrder">
            <span class="iconfont icon-yizhifu"></span>
            <figcaption>已支付</figcaption>
          </figure>
          <figure>
            <span class="iconfont icon-fahuotixing"></span>
            <figcaption>待发货</figcaption>
          </figure>
          <figure>
            <span class="iconfont icon-waitsign"></span>
            <figcaption>待签收</figcaption>
          </figure>
        </div>
      </div>
      <!-- 我的宝贝 -->
      <div class="treasure">
        <div class="tre_top">
          <h3>我的宝贝</h3>
          <div class="tre_more" @click="myBaby">
            <p>全部宝贝</p>
            <span class="iconfont icon-tubiao_fanhui"></span>
          </div>
        </div>
        <div class="tre_bottom">
          <figure>
            <span class="iconfont icon-pay"></span>
            <figcaption>待上架</figcaption>
          </figure>
          <figure @click="myBaby">
            <span class="iconfont icon-yizhifu"></span>
            <figcaption>在售中</figcaption>
          </figure>
          <figure>
            <span class="iconfont icon-fahuotixing"></span>
            <figcaption>已售中</figcaption>
          </figure>
          <figure>
            <span class="iconfont icon-waitsign"></span>
            <figcaption>下架/返回</figcaption>
          </figure>
        </div>
      </div>
      <!-- 其他 -->
      <div class="others">
        <figure @click="inviteFriends">
          <span class="iconfont icon-yaoqinghaoyou"></span>
          <figcaption>邀请好友</figcaption>
        </figure>
        <figure @click="helpFeedback">
          <span class="iconfont icon-bangzhuyufankui"></span>
          <figcaption>帮助与反馈</figcaption>
        </figure>
        <figure>
          <span @click="customerService" class="iconfont icon-lianxikefu"></span>
          <figcaption>联系客服</figcaption>
        </figure>
      </div>
    </main>
    <sfooter></sfooter>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
    <!-- 弹窗 -->
    <sdialog
      :dialogStatus="dialogStatus"
      :dialogMsg="dialogMsg"
      :buttonStatus="buttonStatus"
      @getDialogStatus="getDialogStatus"
    ></sdialog>
  </div>
</template>

<script>
import sfooter from "@/components/sfooter.vue";
import stip from "@/components/stip.vue";
import sdialog from "@/components/sdialog";
export default {
  name: "Mine",
  components: { sfooter, stip,sdialog },
  data() {
    return {
      tipStatus: false,
      tipMsg: "",
      username: "",
      dialogStatus: false,
      dialogMsg: "",
      buttonStatus: false
    };
  },
  created() {
    if (sessionStorage.getItem("member")) {
      this.username = JSON.parse(sessionStorage.getItem("member")).username;
    }
  },
  methods: {
    myBaby(){
      this.$router.push({ path: "/searchOrder", query: { name: '我的宝贝' } });
    },
    login() {
      this.$router.push("/login");
    },
    logout() {
      let self = this;
      sessionStorage.removeItem("member");
      this.tipStatus = true;
      this.tipMsg = "已退出";
      setTimeout(() => {
        self.tipStatus = false;
        this.$router.go(0);
      }, 2000);
    },
    myOrder() {
      this.$router.push({ path: "/searchOrder", query: { name: '我的订单' } });
    },
    getDialogStatus(data) {
      this.dialogStatus = !data;
    },
    getNews(){
      this.dialogStatus = true
      this.dialogMsg = "如想了解相关信息请加微信：18032198647~~~"
      this.buttonStatus = true
    },
    inviteFriends(){
      this.dialogStatus = true
      this.dialogMsg = "请添加个人微信：18032198647，将推荐的好友发至此微信号~~~"
      this.buttonStatus = true
    },
    helpFeedback(){
      this.dialogStatus = true
      this.dialogMsg = "请添加个人微信：18032198647，以反馈您的意见并为之提供帮助~~~"
      this.buttonStatus = true
    },
    customerService(){
      this.dialogStatus = true
      this.dialogMsg = "请添加客服微信：18032198647~~~"
      this.buttonStatus = true
    }
  },
};
</script>

<style scoped>
header {
  width: 95%;
  height: 0.62rem;
  margin: 0 auto;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
header span:nth-child(2) {
  margin-left: 0.15rem;
}
main {
  color: black;
}
.icon-tubiao_xiaoxi,
.icon-tubiao_shezhi {
  font-size: 0.32rem;
}
.head {
  width: 93%;
  height: 0.87rem;
  margin: 0 auto;
  display: flex;
  align-items: center;
}
.icon-touxiang {
  font-size: 0.87rem;
}
.head p {
  font-size: 0.3rem;
  font-weight: bolder;
  margin-left: 0.25rem;
}
.coll_sale {
  width: 95%;
  height: 0.73rem;
  margin: 0 auto;
  margin-top: 0.5rem;
  display: flex;
}
.coll_sale div {
  width: 50%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
}
.collect {
  border-right: 3px solid #eeeeee;
  box-sizing: border-box;
}
.coll_sale div p:nth-child(1) {
  font-size: 0.3rem;
  font-weight: bolder;
}
.coll_sale div p:nth-child(2) {
  font-size: 0.24rem;
}
.order,
.treasure {
  width: 95%;
  height: 2.04rem;
  box-shadow: 2px 2px 5px #cecece;
  margin: 0 auto;
  margin-top: 0.37rem;
}
.order_top,
.tre_top {
  width: 100%;
  height: 0.47rem;
  position: relative;
}
.order_top h3,
.tre_top h3 {
  font-size: 0.24rem;
  font-weight: bold;
  position: absolute;
  left: 0.25rem;
  top: 0.15rem;
}
.order_more,
.tre_more {
  font-size: 0.18rem;
  color: #999999;
  display: flex;
  align-items: center;
  position: absolute;
  right: 0.08rem;
  top: 0.25rem;
}
.icon-tubiao_fanhui {
  font-size: 0.2rem;
  transform: rotate(180deg);
}
.order_bottom,
.tre_bottom {
  width: 100%;
  height: calc(100% - 0.47rem);
  display: flex;
}
.order_bottom figure,
.tre_bottom figure {
  width: 25%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.order_bottom figure .iconfont,
.tre_bottom figure .iconfont {
  font-size: 0.64rem;
}
.order_bottom figure figcaption,
.tre_bottom figure figcaption {
  font-size: 0.2rem;
  margin-top: 0.1rem;
}
.others {
  width: 95%;
  height: 1.56rem;
  box-shadow: 2px 2px 5px #cecece;
  margin: 0 auto;
  margin-top: 0.37rem;
  display: flex;
}
.others figure {
  width: 33.3%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.others figure .iconfont {
  font-size: 0.64rem;
}
.others figure figcaption {
  font-size: 0.2rem;
}
</style>
<template>
  <div id="container">
    <!-- 加载页 -->
    <div id="load">
      <img src="@/assets/imgs/loading.jpg" alt="" />
    </div>
    <header>
      <div id="title">
        <div id="logo">
          <img src="@/assets/imgs/logo.png" alt="消息" title="消息" />
          <h3>年轻人的潮流闲置</h3>
        </div>
        <span @click="getNews" class="iconfont icon-tubiao_xiaoxi"></span>
      </div>
    </header>
    <main>
      <!-- 搜索框 -->
      <search></search>
      <!-- swiper轮播 -->
      <swiper id="banner" :options="swiperOptions">
        <swiper-slide v-for="item in bannerInfo" :key="item.id">
          <img :src="require('@/assets' + item.imgurl)" alt="banner" />
        </swiper-slide>
        <div class="swiper-pagination" slot="pagination"></div>
      </swiper>
      <!-- 分类 -->
      <div class="classify">
        <figure
          v-for="item in classifyInfo"
          :key="item.id"
          @click="goDiffClassify(item.id)"
        >
          <img :src="item.imgurl" alt="" />
          <figcaption>{{ item.name }}</figcaption>
        </figure>
        <figure @click="goClassify">
          <span class="iconfont icon-gengduo"></span>
          <figcaption>查看更多</figcaption>
        </figure>
      </div>
      <!-- 优惠卷 -->
      <div class="sale">
        <h2>优惠卷</h2>
        <div class="sale_cnt">
          <template v-for="item in couponInfo">
            <img
              :ref="'coupon' + item.id"
              v-if="item.num > 0"
              :key="item.id"
              @click="item.addClick && getCoupon(item)"
              :src="require('@/assets' + item.image)"
              alt=""
            />
            <img v-else src="@/assets/imgs/soldOut.png" alt="" />
          </template>
        </div>
      </div>
      <!-- 今日上新 -->
      <div class="today_new">
        <div class="new_top">
          <h2>今日上新</h2>
          <p @click="more(1)">
            <span>更多</span><span class="iconfont icon-tubiao_zhankai"></span>
          </p>
        </div>
        <div class="new_btm">
          <figure
            v-for="item in todayNew"
            :key="item.id"
            @click="productInfo(item.id)"
          >
            <img :src="item.imgurl" alt="" />
            <figcaption>{{ item.goods_name }}</figcaption>
            <p>
              ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
            </p>
          </figure>
        </div>
      </div>
      <!-- 促销商品 -->
      <div class="sale_product">
        <div class="sale_top">
          <h2>促销商品</h2>
          <p @click="more(2)">
            <span>更多</span><span class="iconfont icon-tubiao_zhankai"></span>
          </p>
        </div>
        <div class="sale_btm">
          <figure
            v-for="item in saleProduct"
            :key="item.id"
            @click="productInfo(item.id)"
          >
            <img :src="item.imgurl" alt="" />
            <figcaption>{{ item.goods_name }}</figcaption>
            <p>
              ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
            </p>
          </figure>
        </div>
      </div>
      <!-- 主体内容 -->
      <div class="content">
        <figure
          v-for="item in goodsList"
          :key="item.id"
          @click="productInfo(item.id)"
        >
          <img :src="item.imgurl" alt="" />
          <section>
            <figcaption>
              {{ item.condition_name }} {{ item.goods_name }}
            </figcaption>
            <p>
              ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
            </p>
          </section>
        </figure>
        <p class="bottomEnd" ref="bottomEnd">已经到底了~~</p>
        <p class="loadGoods" ref="loadGoods">加载中~~</p>
      </div>
      <!-- 弹窗 -->
      <sdialog
        :dialogStatus="dialogStatus"
        :dialogMsg="dialogMsg"
        :buttonStatus="buttonStatus"
        @getDialogStatus="getDialogStatus"
      ></sdialog>
    </main>
    <!-- 底部导航栏 -->
    <sfooter></sfooter>
  </div>
</template>

<script>
import search from "@/components/search.vue";
import sfooter from "@/components/sfooter.vue";
import sdialog from "@/components/sdialog";
import "swiper/swiper-bundle.css";
import { swiper, swiperSlide } from "vue-awesome-swiper";
export default {
  name: "Home",
  components: { swiper, swiperSlide, search, sfooter, sdialog },
  data() {
    return {
      swiperOptions: {
        autoplay: true,
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
        },
      },
      classifyInfo: [
        {
          id: 1,
          name: "潮流球鞋",
          imgurl: require("@/assets/imgs/home_one.png"),
        },
        {
          id: 2,
          name: "奢品包袋",
          imgurl: require("@/assets/imgs/home_two.png"),
        },
        {
          id: 3,
          name: "经典腕表",
          imgurl: require("@/assets/imgs/home_three.png"),
        },
        {
          id: 4,
          name: "人气服饰",
          imgurl: require("@/assets/imgs/home_four.png"),
        },
      ],
      couponInfo: [],
      received: require("@/assets/imgs/received.png"),
      bannerInfo: [],
      todayNew: [],
      saleProduct: [],
      goodsList: [],
      goodsRequestNum: 4,
      goodsRequestSize: 4,
      allGoodsNum: 0,
      dialogStatus: false,
      dialogMsg: "",
      buttonStatus: false,
    };
  },
  created() {
    this.listenerScroll();
    this.getAllGoodsList();
  },
  mounted() {
    this.getBanner();
    this.getCouponInfo();
    this.getActivity(1);
    this.getActivity(2);
    this.getGoodsList(this.goodsRequestNum, "init");
  },
  beforeDestroy() {
    document.removeEventListener("scroll", this.listenerScroll);
  },
  methods: {
    listenerScroll(e) {
      document.addEventListener("scroll", this.handleScroll, true);
    },
    handleScroll() {
      let main = document.getElementsByTagName("main")[0];
      let scrollHeight = Math.trunc(main.scrollHeight - main.scrollTop);
      if (
        scrollHeight == main.clientHeight ||
        scrollHeight - 1 == main.clientHeight ||
        scrollHeight + 1 == main.clientHeight
      ) {
        this.goodsRequestNum += this.goodsRequestSize;
        this.getGoodsList(this.goodsRequestNum, "noInit");
      }
    },
    goDiffClassify(cid) {
      this.$router.push({ name: "classifyList", query: { cid: cid } });
    },
    getCouponInfo() {
      this.$axios.get("/index/index/coupon").then(
        (res) => {
          if (res.data.ret == 200) {
            this.couponInfo = res.data.data;
            this.couponInfo.forEach((item) => {
              item.addClick = true;
            });
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getCoupon(coupon) {
      let self = this;
      let user_id;
      if (sessionStorage.getItem("member")) {
        user_id = JSON.parse(sessionStorage.getItem("member")).id;
      } else {
        this.$router.push("/login");
        return;
      }
      if (this.couponInfo[coupon.id - 1].addClick) {
        this.$axios
          .get(
            "/index/index/dealCouponNum?id=" + coupon.id + "&user_id=" + user_id
          )
          .then(
            (res) => {
              if (res.data.ret == 200 && res.data.data.length == 0) {
                self.dialogMsg = "已领取" + coupon.discount_name + "的优惠卷";
                // 变换已领取的img
                self.$refs["coupon" + coupon.id][0].src = this.received;
                // 解决领取优惠卷之后还能领取的bug
                self.couponInfo[coupon.id - 1].addClick = false;
                self.dialogStatus = true;
                setTimeout(() => {
                  self.dialogStatus = false;
                }, 2000);
              } else if (res.data.ret == 200 && res.data.data.length != 0) {
                self.dialogMsg = res.data.msg;
                self.dialogStatus = true;
                setTimeout(() => {
                  self.dialogStatus = false;
                }, 2000);
              } else {
                console.log(res.msg);
              }
            },
            (err) => {
              console.log(err);
            }
          );
      } else {
        return false;
      }
    },
    getDialogStatus(data) {
      this.dialogStatus = !data;
    },
    getBanner() {
      this.$axios.get("/index/index/getBanner").then(
        (res) => {
          if (res.data.ret == 200) {
            this.bannerInfo = res.data.data;
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getActivity(aid) {
      this.$axios.get("/index/index/getActivity?aid=" + aid).then(
        (res) => {
          if (res.data.ret == 200) {
            if (aid == 1) {
              this.todayNew = res.data.data;
              this.todayNew = this.todayNew.map((item) => {
                item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
                return item;
              });
            } else if (aid == 2) {
              this.saleProduct = res.data.data;
              this.saleProduct = this.saleProduct.map((item) => {
                item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
                return item;
              });
            }
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getAllGoodsList() {
      this.$axios.get("/index/index/allGoodsList").then(
        (res) => {
          if (res.data.ret == 200) {
            this.allGoodsNum = res.data.data.length;
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    getGoodsList(num, status) {
      let self = this;
      if (status == "init") {
        this.$axios.get("/index/index/showGoodsList?num=" + num).then(
          (res) => {
            if (res.data.ret == 200) {
              self.goodsList = res.data.data;
              self.goodsList = this.goodsList.map((item) => {
                item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
                return item;
              });
            }
          },
          (err) => {
            console.log(err);
          }
        );
      } else {
        if (num >= this.allGoodsNum) {
          if (self.$refs.bottomEnd) {
            self.$refs.bottomEnd.style.display = "block";
          }
          return false;
        } else {
          if (self.$refs.loadGoods) {
            self.$refs.loadGoods.style.display = "block";
          }
          this.$axios.get("/index/index/showGoodsList?num=" + num).then(
            (res) => {
              if (res.data.ret == 200) {
                self.goodsList = res.data.data;
                self.goodsList = this.goodsList.map((item) => {
                  item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
                  return item;
                });
                if (self.$refs.loadGoods) {
                  self.$refs.loadGoods.style.display = "none";
                }
              }
            },
            (err) => {
              console.log(err);
            }
          );
        }
      }
    },
    more(aid) {
      this.$router.push({ name: "classifyList", query: { aid: aid } });
    },
    productInfo(id) {
      this.$router.push({ name: "productDetail", query: { id } });
    },
    goClassify() {
      this.$router.push("/classify");
    },
    getNews() {
      this.dialogStatus = true;
      this.dialogMsg = "如想了解相关信息请加微信：18032198647~~~";
      this.buttonStatus = true;
    },
  },
};
</script>

<style scoped>
#load {
  display: none;
}
#load img {
  width: 100vw;
  height: 100vh;
}
header {
  width: 100vw;
  height: 0.62rem;
  border-bottom: 1px solid #efefef;
  box-sizing: border-box;
}
#title {
  width: 93%;
  height: 100%;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
#logo {
  display: flex;
  align-items: center;
}
#logo img {
  width: 0.64rem;
  height: 0.64rem;
}
#logo h3 {
  letter-spacing: 0.05rem;
  font-size: 0.18rem;
  font-weight: bold;
  margin-left: 0.2rem;
}
#title span {
  font-size: 0.32rem;
}
main {
  width: 100vw;
}
#banner {
  width: 95%;
  height: 2.25rem;
  margin-top: 0.25rem;
  border-radius: 0.05rem;
}
#banner img {
  width: 100%;
  height: 100%;
}
/* 改变分页位置 */
.swiper-pagination {
  position: absolute;
  bottom: 0;
}
/* 改变小圆点颜色 */
.swiper-container {
  /* --swiper-theme-color: #ff6600; */
  --swiper-pagination-color: #fff; /* 两种都可以 */
}
.classify {
  width: 93%;
  height: 1rem;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  margin-top: 0.36rem;
}
.classify figure {
  /* width: 20%; */
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.classify figure img {
  width: 0.8rem;
  height: 0.8rem;
}
.classify figure figcaption {
  font-size: 0.18rem;
  font-weight: bold;
}

.icon-gengduo {
  font-size: 0.48rem;
  margin: 0.1rem 0.1rem 0.18rem 0.1rem;
}
.sale {
  width: 93%;
  height: 1.1rem;
  margin: 0 auto;
  margin-top: 0.4rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.sale h2 {
  font-size: 0.3rem;
  font-weight: bolder;
}
.sale_cnt {
  width: 100%;
  display: flex;
  justify-content: space-around;
}
.sale_cnt img {
  width: 1.62rem;
  height: 0.62rem;
}
.today_new,
.sale_product {
  width: 93%;
  height: 2.83rem;
  margin: 0 auto;
  margin-top: 0.45rem;
  /* border: 1px solid red; */
}
.new_top,
.sale_top {
  width: 100%;
  height: 0.3rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.18rem;
}
.new_top h2,
.sale_top h2 {
  font-size: 0.3rem;
}
.icon-tubiao_zhankai {
  font-size: 0.16rem;
}
.new_btm,
.sale_btm {
  width: 100%;
  height: calc(100% - 0.3rem);
  display: flex;
}
.new_btm figure,
.sale_btm figure {
  width: 33%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.new_btm figure img,
.sale_btm figure img {
  width: 1.68rem;
  height: 1.7rem;
}
.new_btm figure figcaption,
.sale_btm figure figcaption {
  font-size: 0.14rem;
}
.new_btm figure p,
.sale_btm figure p {
  font-size: 0.18rem;
  font-weight: bolder;
}
.new_btm figure p del,
.sale_btm figure p del {
  font-size: 0.14rem;
  color: #666666;
}
/* 主体内容 */
.content {
  width: 100%;
  display: flex;
  flex-flow: wrap row;
  margin-top: 0.35rem;
  border-top: 1px solid #666666;
  box-sizing: border-box;
}
.content figure:nth-child(odd) {
  width: 50%;
  height: 3.35rem;
  border-right: 1px solid #666666;
  border-bottom: 1px solid #666666;
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
  width: 70%;
}
.content figure section figcaption {
  font-size: 0.18rem;
}
.content figure section p {
  font-size: 0.18rem;
  font-weight: bolder;
}
.content figure section p del {
  font-size: 0.14rem;
  color: #666666;
}
.bottomEnd,
.loadGoods {
  width: 100%;
  height: 0.5rem;
  font-size: 0.24rem;
  color: #666666;
  text-align: center;
  line-height: 0.5rem;
  display: none;
}
</style>
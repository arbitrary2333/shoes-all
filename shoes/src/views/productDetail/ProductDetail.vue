<template>
  <div id="container">
    <sheader title="商品详情">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
        <span @click="getNews" class="iconfont icon-fenxiang"></span>
      </template>
    </sheader>
    <main>
      <!-- swiper轮播 -->
      <swiper id="banner" :options="swiperOptions">
        <swiper-slide>
          <img :src="productDetail.imgurl" alt="banner" />
        </swiper-slide>
        <swiper-slide>
          <img :src="productDetail.imgurl" alt="banner" />
        </swiper-slide>
        <swiper-slide>
          <img :src="productDetail.imgurl" alt="banner" />
        </swiper-slide>
        <swiper-slide>
          <img :src="productDetail.imgurl" alt="banner" />
        </swiper-slide>
        <div class="swiper-pagination" slot="pagination"></div>
      </swiper>
      <!-- 信息 -->
      <div class="info">
        <h3>{{ productDetail.goods_name }}</h3>
        <p>
          ￥{{ productDetail.newprice
          }}<del>￥{{ productDetail.oldprice }}</del>
        </p>
        <p>
          成色：{{ productDetail.condition_name }} 尺码：{{
            productDetail.size ? productDetail.size : "*"
          }}
        </p>
      </div>
      <!-- 详情 -->
      <div class="detailImg">
        <h2>商品详情</h2>
        <img :src="productDetail.imgurl" alt="detail" />
      </div>
    </main>
    <footer>
      <!-- <figure>
        <span class="iconfont icon-tubiao_shoucang"></span>
        <figcaption>收藏</figcaption>
      </figure> -->
      <figure @click="goShop">
        <span class="iconfont icon-tubiao_gouwuche"></span>
        <figcaption>购物车</figcaption>
      </figure>
      <div class="shopcar" @click="addCar">加入购物车</div>
      <div class="buy" @click="buy">立即购买</div>
    </footer>
    <sdialog
      :dialogStatus="dialogStatus"
      :dialogMsg="dialogMsg"
      :buttonStatus="buttonStatus"
      @getDialogStatus="getDialogStatus"
    ></sdialog>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import "swiper/swiper-bundle.css";
import { swiper, swiperSlide } from "vue-awesome-swiper";
import stip from "@/components/stip.vue";
import sdialog from "@/components/sdialog";
export default {
  name: "ProductDetail",
  components: { sheader, swiper, swiperSlide, stip, sdialog },
  data() {
    return {
      tipStatus: false,
      tipMsg: "",
      dialogStatus: false,
      dialogMsg: "",
      buttonStatus: false,
      productDetail: {},
      swiperOptions: {
        loop: true,
        autoplay: {
          delay: 3000,
          stopOnLastSlide: false,
          disableOnInteraction: false,
        },
        // 显示分页
        pagination: {
          el: ".swiper-pagination",
          clickable: true, //允许分页点击跳转
        },
      },
    };
  },
  created() {
    this.$axios
      .get("/index/Productdetail/detail?id=" + this.$route.query.id)
      .then((res) => {
        if (res.data.ret == 200 && res.data.data.length > 0) {
          this.productDetail = res.data.data[0];
          this.productDetail.imgurl =
            "http://www.shoes.com:8081" + this.productDetail.imgurl;
        }
      });
  },
  methods: {
    getDialogStatus(data) {
      this.dialogStatus = !data;
    },
    getNews() {
      this.dialogStatus = true;
      this.dialogMsg = "如需分享此商品请添加加微信：18032198647~~~";
      this.buttonStatus = true;
    },
    went() {
      this.$router.go(-1);
    },
    addCar() {
      let self = this;
      let user_id
      if(sessionStorage.getItem("member")){
        user_id = JSON.parse(sessionStorage.getItem("member")).id;
      }else{
        this.$router.push("/login")
        return
      }
      this.$axios
        .post("/index/Productdetail/addCar", {
          user_id: user_id,
          goods_id: self.productDetail.id,
        })
        .then(
          (res) => {
            if (res.data.ret == 200 && res.data.data.length > 0) {
              self.tipStatus = true;
              self.tipMsg = "添加成功";
              setTimeout(() => {
                self.tipStatus = false;
                // this.$router.push("/shopcar");
              }, 2000);
            }else{
              self.tipStatus = true;
              self.tipMsg = res.data.msg;
              setTimeout(() => {
                self.tipStatus = false;
              }, 2000);
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    buy() {
      let orderInfo = {
        goods: [this.productDetail],
        totalPrice: this.productDetail.newprice,
      }
      localStorage.setItem('orderInfo', JSON.stringify(orderInfo))
      this.$router.push("/order");
    },
    goShop() {
      this.$router.push("/shopcar");
    },
  },
};
</script>

<style scoped>
.icon-fenxiang {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translate(0, -50%);
}
main {
  width: 100%;
}
#banner {
  width: 95%;
  height: 4.14rem;
  position: relative;
}
#banner img {
  width: 3.48rem;
  height: 3.33rem;
  position: absolute;
  left: 50%;
  transform: translate(-50%, 0);
}
/* 改变小圆点颜色 */
.swiper-container {
  /* --swiper-theme-color: #ff6600; */
  --swiper-pagination-color: #000; /* 两种都可以 */
}
.info {
  width: 93%;
  height: 1.3rem;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.info h3 {
  font-size: 0.24rem;
}
.info p:nth-child(2) {
  font-size: 0.36rem;
  color: #be0000;
  font-weight: bolder;
  display: flex;
  align-items: center;
}
.info p:nth-child(2) del {
  font-size: 0.18rem;
  color: #666;
  margin-left: 0.15rem;
}
.info p:nth-child(3) {
  font-size: 0.18rem;
}
.detailImg {
  width: 100%;
}
.detailImg h2 {
  height: 0.63rem;
  font-size: 0.3rem;
  font-weight: bolder;
  text-align: center;
  line-height: 0.63rem;
}
.detailImg img {
  width: 100%;
}
footer {
  width: 100%;
  height: 1rem;
  border-top: 1px solid #eee;
  box-sizing: border-box;
  margin: 0 auto;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
footer figure {
  width: 20%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
footer figure:nth-child(1) {
  border-right: 1px solid #eee;
}
footer figure span {
  font-size: 0.48rem;
}
footer figure figcaption {
  font-size: 0.18rem;
  font-weight: bolder;
}
.shopcar {
  width: 2.07rem;
  height: 0.7rem;
  background: #333333;
  color: white;
  text-align: center;
  line-height: 0.7rem;
  font-weight: bold;
  font-size: 0.24rem;
}
.buy {
  width: 1.8rem;
  height: 0.7rem;
  background: #be0000;
  color: white;
  text-align: center;
  line-height: 0.7rem;
  font-weight: bold;
  font-size: 0.24rem;
}
</style>
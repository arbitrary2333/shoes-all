<template>
  <div id="searchOrder">
    <sheader :title="title">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <ul class="select">
        <li
          :class="{ active: current == index }"
          v-for="(item, index) in searchOrder"
          :key="index"
          @click="tab(index)"
        >
          {{ item.classify }}
        </li>
      </ul>
      <div
        class="content"
        v-for="(item, index) in searchOrder"
        :key="index"
        v-show="current == index"
      >
        <section v-for="(itemTwo, indexTwo) in item.info" :key="indexTwo">
          <!-- <div class="cnt_top">
            <p>{{ itemTwo.ids }}</p>
            <p>{{ itemTwo.status }}</p>
          </div> -->
          <div class="cnt">
            <img :src="'http://www.shoes.com:8081' + itemTwo.imgurl" alt="" />
            <div class="cnt_right">
              <h3>{{ itemTwo.goods_name }}</h3>
              <p>
                ￥{{ itemTwo.newprice }}<del>￥{{ itemTwo.oldprice }}</del>
              </p>
            </div>
          </div>
          <div class="cnt_bottom">
            <p>
              共一件宝贝，实付：<strong
                >￥{{
                  itemTwo.fsid == 1
                    ? itemTwo.newprice
                    : itemTwo.newprice + fareSize
                }}</strong
              >
            </p>
            <!-- <p class="delete">删除订单</p> -->
          </div>
        </section>
      </div>
    </main>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
export default {
  name: "searchOrder",
  components: { sheader },
  data() {
    return {
      title: "",
      fareSize: 10,
      current: 0,
      searchOrder: [
        {
          id: 0,
          classify: "已支付",
          info: [],
        },
      ],
    };
  },
  created() {
    this.title = this.$route.query.name;
    if (this.title == "我的订单") {
      this.getMyOrder()
    }else{
      this.getMyBaby()
    }
  },
  methods: {
    getMyOrder() {
      let self = this;
      let user_id = JSON.parse(sessionStorage.getItem("member")).id;
      this.$axios.post("/index/order/searchOrder", { user_id }).then((res) => {
        if (res.data.ret == 200) {
          self.searchOrder[0].classify = "已支付"
          self.searchOrder[0].info = res.data.data;
        }
      });
    },
    getMyBaby(){
      let self = this;
      let uid = JSON.parse(sessionStorage.getItem("member")).id;
      this.$axios.post("/index/order/searchBaby", { uid }).then((res) => {
        if (res.data.ret == 200) {
          self.searchOrder[0].classify = "已售出"
          self.searchOrder[0].info = res.data.data;
        }
      });
    },
    went() {
      this.$router.go(-1);
    },
    tab(index) {
      console.log(index);
      this.current = index;
    },
  },
};
</script>

<style scoped>
#searchOrder {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
}
main {
  width: 100%;
  flex: 1;
  overflow-y: hidden;
  background: #eeeeee;
}
.select {
  width: 100%;
  height: 0.7rem;
  background: white;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.select li {
  font-size: 0.24rem;
  font-weight: bold;
  color: #666666;
  padding-bottom: 0.28rem;
}
.active {
  border-bottom: 1px solid black;
  color: black;
}
.content {
  width: 100%;
  height: calc(100% - 0.7rem - 0.62rem);
  overflow-y: auto;
}
.content section {
  width: 100%;
  height: 3.64rem;
  background: white;
  margin-bottom: 0.2rem;
}
.cnt_top {
  width: 95%;
  height: 0.5rem;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.18rem;
  border-bottom: 1px solid #eeeeee;
  box-sizing: border-box;
}
.cnt {
  width: 95%;
  height: 1.93rem;
  margin: 0 auto;
  border-bottom: 1px solid #eeeeee;
  box-sizing: border-box;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.cnt img {
  width: 2.2rem;
  height: 1.32rem;
}
.cnt_right {
  width: calc(100% - 3rem);
  height: 1.1rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.cnt_right h3 {
  font-size: 0.22rem;
}
.cnt_right p {
  font-size: 0.3rem;
  font-weight: bolder;
  display: flex;
  align-items: center;
}
.cnt_right p del {
  font-size: 0.18rem;
  color: #666666;
  margin-left: 0.15rem;
}
.cnt_bottom {
  width: 95%;
  height: calc(100% - 1.93rem - 0.5rem);
  font-size: 0.22rem;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: flex-end;
}
.cnt_bottom p strong {
  font-size: 0.24rem;
  color: #be0000;
}
.delete {
  width: 1.37rem;
  height: 0.36rem;
  border: 1px solid black;
  text-align: center;
  line-height: 0.36rem;
}
</style>
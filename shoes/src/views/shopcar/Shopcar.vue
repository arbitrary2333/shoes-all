<template>
  <div id="container">
    <sheader title="购物车"></sheader>
    <main>
      <div
        style="font-size: 0.3rem; text-align: center; margin-top: 0.3rem"
        v-if="shopcar.length == 0"
      >
        请添加商品到您的购物车~~~
      </div>
      <section v-for="(item, index) in shopcar" :key="index">
        <img
          :src="item.status ? selected : select"
          alt=""
          @click="selectOne(index, item.id)"
        />
        <img :src="item.imgurl" alt="" />
        <article>
          <h3>{{ item.goods_name }}</h3>
          <p v-if="item.size">{{ item.size }}</p>
          <p v-else>*</p>
          <p>
            ￥{{ item.newprice }}<del>￥{{ item.oldprice }}</del>
          </p>
        </article>
        <p @click="del(item.id)">删除</p>
      </section>
    </main>
    <sfooter>
      <template>
        <div v-if="shopcar.length != 0" class="pay">
          <figure>
            <img
              :src="flag == true ? selected : select"
              @click="selectAll"
              alt=""
            />
            <figcaption @click="selectAll">全选</figcaption>
          </figure>
          <section style="position: fixed; right: 0.2rem">
            <p>总计</p>
            <p>￥{{ totalPrice }}</p>
            <p @click="jiesuan">结算({{ num }})</p>
          </section>
        </div>
      </template>
    </sfooter>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import sfooter from "@/components/sfooter.vue";
import stip from "@/components/stip.vue";
export default {
  name: "Shopcar",
  components: { sheader, sfooter, stip },
  inject: ["reload"], //注入reload方法
  data() {
    return {
      selected: require("@/assets/imgs/selected.png"),
      select: require("@/assets/imgs/select.png"),
      checked: false,
      flag: true,
      shopcar: [],
      sum: 0,
      tipMsg: "",
      tipStatus: false,
    };
  },
  created() {
    this.getCartList();
  },
  methods: {
    getCartList() {
      this.$axios
        .get(
          "/index/cart/cart?user_id=" +
            JSON.parse(sessionStorage.getItem("member")).id
        )
        .then(
          (res) => {
            if (res.data.ret == 200 && res.data.data.length > 0) {
              this.shopcar = res.data.data;
              this.shopcar = this.shopcar.map((item) => {
                item.imgurl = "http://www.shoes.com:8081" + item.imgurl;
                return item;
              });
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    selectOne(index, id) {
      let self = this;
      // this.shopcar[index].status = Number(!this.shopcar[index].status);
      this.$axios
        .post("/index/cart/switchStatus", {
          id: id,
          status: Number(!this.shopcar[index].status),
        })
        .then(
          (res) => {
            if (res.data.ret == 200 && res.data.data.length > 0) {
              self.getCartList();
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    selectAll() {
      let self = this;
      this.$axios
        .post("/index/cart/switchAllStatus", {
          status: Number(!self.flag),
          user_id: JSON.parse(sessionStorage.getItem("member")).id,
        })
        .then(
          (res) => {
            if (res.data.ret == 200) {
              self.flag = !self.flag;
              for (let i = 0, length = self.shopcar.length; i < length; i++) {
                self.shopcar[i].status = Number(self.flag);
              }
              console.log(res);
            }
          },
          (err) => {
            console.log(err);
          }
        );
    },
    del(id) {
      let self = this;
      this.$axios.post("/index/cart/delCartGoods", { id }).then(
        (res) => {
          if (res.data.ret == 200) {
            self.getCartList();
            this.reload();
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    jiesuan() {
      let noSelect = this.shopcar.every((item) => {
        return item.status == 0;
      });
      if (noSelect) {
        this.tipStatus = true;
        this.tipMsg = "请选择要结算的商品";
        setTimeout(() => {
          this.tipStatus = false;
        }, 2000);
      } else {
        let filterShopcar = this.shopcar.filter((item) => {
          return item.status == 1;
        });
        let orderInfo = {
          goods: filterShopcar,
          totalPrice: this.sum,
        }
        localStorage.setItem("orderInfo", JSON.stringify(orderInfo))
        this.$router.push("/order");
      }
    },
  },
  computed: {
    totalPrice() {
      // 有问题
      // 监听全选是否有没选的
      this.flag = this.shopcar.every((item) => {
        return item.status == 1;
      });
      let sum = 0;
      for (let i = 0, length = this.shopcar.length; i < length; i++) {
        if (this.shopcar[i].status) {
          sum += this.shopcar[i].newprice;
        }
      }
      this.sum = sum;
      return sum;
    },
    num() {
      let num = 0;
      for (let i = 0, length = this.shopcar.length; i < length; i++) {
        if (this.shopcar[i].status) {
          num++;
        }
      }
      return num;
    },
  },
};
</script>

<style scoped>
main section {
  width: 95%;
  height: 2rem;
  border-bottom: 1px solid #b5b5b5;
  box-sizing: border-box;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

main section img:nth-child(1) {
  width: 0.32rem;
  height: 0.32rem;
}

main section img:nth-child(2) {
  width: 1.32rem;
  height: 1.32rem;
}

main section article {
  width: 50%;
  height: 1.32rem;
}

main section article h3 {
  font-size: 0.24rem;
  font-weight: bold;
}

main section article p:nth-child(2) {
  width: 0.6rem;
  height: 0.3rem;
  border-radius: 0.05rem;
  background: #b5b5b5;
  text-align: center;
  line-height: 0.3rem;
  color: black;
  font-size: 0.18rem;
}

main section article p:nth-child(3) {
  font-size: 0.3rem;
  color: #be0000;
  margin-top: 0.3rem;
  font-weight: bolder;
}

main section article p:nth-child(3) del {
  font-size: 0.18rem;
  color: #b5b5b5;
  margin-left: 0.2rem;
}

main section p:nth-child(4) {
  color: #be0000;
  font-size: 0.24rem;
}
</style>
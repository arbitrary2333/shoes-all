<template>
  <div id="container">
    <sheader title="发布商品" v-if="!status">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main v-if="!status">
      <div class="describe">
        <textarea
          v-model="goods_name"
          id=""
          placeholder="请描述您的宝贝(至少10个字符)"
        ></textarea>
        <div class="file">
          <span v-if="imgUrl == ''">+</span>
          <input
            ref="input"
            type="file"
            accept="image/gif, image/jpeg, image/jpg, image/png, image/svg"
            multiple="multiple"
            @change="handleFileChange"
          />
          <img
            style="
              height: 50px;
              width: 50px;
              z-index: 9;
              position: absolute;
              top: 0;
            "
            v-if="imgUrl != ''"
            :src="imgUrl"
          />
        </div>
      </div>
      <div class="oldPrice">
        <p>商品原价：</p>
        <input
          type="number"
          v-model="oldPrice"
          placeholder="例如：￥199.00，￥可省去"
        />
      </div>
      <div class="newPrice">
        <p>商品售价：</p>
        <input
          type="number"
          v-model="newPrice"
          placeholder="例如：￥199.00，￥可省去"
        />
      </div>
      <div class="size">
        <p>尺码：</p>
        <input
          type="text"
          v-model="size"
          placeholder="请填写尺码"
        />
      </div>
      <div class="brand" @click="openSelect('brand')">
        <p>
          商品品牌：<b style="fontsize: 0.12rem; margin-left: 0.1rem">{{
            brand
          }}</b>
        </p>
        <span class="iconfont icon-tubiao_fanhui"></span>
      </div>
      <div class="color" @click="openSelect('color')">
        <p>
          商品成色：<b style="fontsize: 0.12rem; margin-left: 0.1rem">{{
            color
          }}</b>
        </p>
        <span class="iconfont icon-tubiao_fanhui"></span>
      </div>
      <div class="time" @click="openSelect('time')">
        <p>
          发货时间：<b style="fontsize: 0.12rem; margin-left: 0.1rem">{{
            time
          }}</b>
        </p>
        <span class="iconfont icon-tubiao_fanhui"></span>
      </div>
      <div class="free" @click="openSelect('free')">
        <p>
          是否包邮：<b style="fontsize: 0.12rem; margin-left: 0.1rem">{{
            free
          }}</b>
        </p>
        <span class="iconfont icon-tubiao_fanhui"></span>
      </div>
    </main>
    <footer v-if="!status" @click="submit">立即发布</footer>
    <select-tmp
      :status="status"
      @statusChange="statusChange"
      @conditionChange="conditionChange"
      :condition="condition"
      :classifyId="classifyId"
    ></select-tmp>
    <sdialog
      :dialogStatus="dialogStatus"
      :dialogMsg="dialogMsg"
      :buttonStatus="true"
      @getDialogStatus="getDialogStatus"
    ></sdialog>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import selectTmp from "@/components/selectTmp.vue";
import sdialog from "@/components/sdialog.vue";
import stip from "@/components/stip.vue";
export default {
  name: "Release",
  components: { sheader, selectTmp, sdialog, stip },
  data() {
    return {
      goods_name: "",
      oldPrice: "",
      newPrice: "",
      size:"",
      brand: "",
      color: "",
      time: "",
      free: "",
      status: false,
      condition: "",
      classifyId: 0,
      imgUrl: "", //本地展示的图片base64
      imgurl: {}, //向后端传递的图片，格式为对象
      brandId: 0,
      colorId: 0,
      timeId: 0,
      freeId: 0,
      dialogStatus: false,
      dialogMsg: "",
      dialogOption: "",
      tipMsg: "",
      tipStatus: false,
    };
  },
  watch: {
    dialogOption(newVal) {
      let self = this;
      if (newVal == "determine") {
        let formData = new FormData();
        formData.append("goods_name", self.goods_name);
        formData.append("imgurl", self.imgurl);
        formData.append("oldprice", self.oldPrice);
        formData.append("newprice", self.newPrice);
        formData.append("size", self.size);
        formData.append("cid", self.classifyId);
        formData.append("bid", self.brandId);
        formData.append("coid", self.colorId);
        formData.append("tid", self.timeId);
        formData.append("fsid", self.freeId);
        formData.append("uid", JSON.parse(sessionStorage.getItem("member")).id);
        this.$axios.post("/index/Sale/publishGoods", formData).then(
          (res) => {
            console.log(res);
            if (res.data.ret == 200 && Object.keys(res.data.data).length > 0) {
              self.tipStatus = true;
              self.tipMsg = "发布成功！";
              self.dialogStatus = false;
              setTimeout(() => {
                self.tipStatus = false;
                self.goods_name = "";
                self.oldPrice = "";
                self.newPrice = "";
                self.brand = "";
                self.color = "";
                self.time = "";
                self.free = "";
                self.imgUrl = "";
                self.dialogOption = "";
                self.$router.replace("/");
              }, 2000);
            }
          },
          (err) => {
            console.log(err);
          }
        );
      } else if (newVal == "cancel") {
        this.dialogStatus = false;
      } else {
        console.log("no content！");
      }
    },
  },
  created() {
    this.classifyId = parseInt(this.$route.query.id);
  },
  methods: {
    handleFileChange(event) {
      let self = this;
      let file = event.target.files[0];
      let url = "";
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        // url为base64路径
        url = this.result.substring(this.result.indexOf(",") + 1);
        self.imgUrl = "data:image/png;base64," + url;
      };

      this.imgurl = file;
    },
    went() {
      this.$router.replace("/sale");
    },
    submit() {
      let self = this;
      if (
        !self.goods_name ||
        !self.oldPrice ||
        !self.newPrice ||
        !self.brand ||
        !self.imgUrl ||
        !self.color ||
        !self.time ||
        !self.free
      ) {
        self.tipStatus = true;
        self.tipMsg = "参数未填写完整！";
        setTimeout(() => {
          self.tipStatus = false;
        }, 3000);
      } else {
        this.dialogStatus = true;
        this.dialogMsg = "您确定要发布闲置：" + this.goods_name + "吗？";
      }
    },
    openSelect(value) {
      this.condition = value;
      this.status = true;
    },
    getDialogStatus(data, option) {
      this.dialogStatus = !data;
      this.dialogOption = option;
    },
    statusChange(change) {
      this.status = change;
    },
    conditionChange(change) {
      this.status = false;
      console.log(change);
      switch (change.kind) {
        case "brand":
          this.brandId = change.id;
          this.brand = change.name;
          break;
        case "condition":
          this.colorId = change.id;
          this.color = change.name;
          break;
        case "time":
          this.timeId = change.id;
          this.time = change.name;
          break;
        case "freeshipping":
          this.freeId = change.id;
          this.free = change.name;
          break;
      }
    },
  },
};
</script>

<style scoped>
main {
  width: 100%;
}
.describe {
  width: 95%;
  height: 2.56rem;
  margin: 0 auto;
  background: #fff;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}
.describe textarea {
  width: 100%;
  height: 1.36rem;
  border: none;
  outline: none;
  color: #999999;
  font-size: 0.18rem;
  font-family: "苹方";
}
.file {
  position: relative;
}
.file span {
  display: block;
  width: 1rem;
  height: 1rem;
  background: #eee;
  color: #999;
  text-align: center;
  line-height: 0.9rem;
  position: absolute;
}
.file input {
  display: block;
  width: 1rem;
  height: 1rem;
  opacity: 0;
  z-index: 999;
}
.oldPrice {
  margin-top: 0.2rem !important;
}
.newPrice,
.oldPrice,
.size {
  width: 95%;
  height: 0.6rem;
  border-bottom: 1px solid #eee;
  box-sizing: border-box;
  font-size: 0.18rem;
  font-weight: bolder;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.newPrice input,
.oldPrice input,
.size input {
  width: calc(100% - 1rem);
  font-size: 0.18rem;
  height: 0.5rem;
  border: none;
  outline: none;
}
.brand,
.color,
.time,
.free {
  width: 95%;
  height: 0.6rem;
  border-bottom: 1px solid #eee;
  box-sizing: border-box;
  font-size: 0.18rem;
  font-weight: bolder;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.brand span,
.color span,
.time span,
.free span {
  font-size: 0.24rem;
  transform: rotate(180deg);
}
footer {
  width: 100%;
  height: 1rem;
  background: #666666;
  color: white;
  text-align: center;
  line-height: 1rem;
  font-size: 0.3rem;
  border: none;
  position: absolute;
  bottom: 0;
}
</style>
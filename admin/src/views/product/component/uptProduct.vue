<template>
  <el-dialog
    title="修改产品"
    @opened="getData"
    :before-close="close"
    :visible.sync="uptProductStatus"
    width="50%"
  >
    <el-form :model="uptProductData" ref="memberRule" inline label-width="80px">
      <el-form-item
        label="商品名称"
        prop="goods_name"
        :rules="[
          { required: true, message: '请输入商品名称', trigger: 'blur' },
        ]"
      >
        <el-input type="text" v-model="uptProductData.goods_name"></el-input>
      </el-form-item>
      <el-form-item
        label="新价格"
        prop="newprice"
        :rules="[{ required: true, message: '请输入价格', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="uptProductData.newprice"></el-input>
      </el-form-item>
      <el-form-item
        label="旧价格"
        prop="oldprice"
        :rules="[{ required: true, message: '请输入价格', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="uptProductData.oldprice"></el-input>
      </el-form-item>
      <el-form-item
        label="图片"
        prop="imgurl"
        :rules="[{ required: true, message: '请选择图片', trigger: 'blur' }]"
      >
        <div>
          <input
            v-if="imgUrl == ''"
            type="file"
            accept="image/gif, image/jpeg, image/jpg, image/png, image/svg"
            multiple="multiple"
            @change="handleFileChange"
          />
          <img
            style="height: 100px; width: 100px"
            v-if="imgUrl != ''"
            :src="imgUrl"
          />
        </div>
      </el-form-item>
      <el-form-item
        label="尺码"
        prop="size"
        :rules="[{ required: true, message: '请输入尺码', trigger: 'blur' }]"
      >
        <el-input v-model="uptProductData.size" type="text"></el-input>
      </el-form-item>
      <el-form-item
        label="分类"
        prop="cid"
        :rules="[
          { required: true, message: '请选择所属分类', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptProductData.cid" placeholder="请选择支付方式">
          <el-option label="潮鞋" :value="1">潮鞋</el-option>
          <el-option label="包袋" :value="2">包袋</el-option>
          <el-option label="腕表" :value="3">腕表</el-option>
          <el-option label="服饰" :value="4">服饰</el-option>
          <el-option label="配饰" :value="5">配饰</el-option>
        </el-select>
      </el-form-item>
      <el-form-item
        label="品牌"
        prop="bid"
        :rules="[
          { required: true, message: '请选择所属品牌', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptProductData.bid" placeholder="请选择所属品牌">
          <el-option
            v-for="brand in brandInfo"
            :key="brand.id"
            :label="brand.brand_name"
            :value="brand.id"
            >{{ brand.brand_name }}</el-option
          >
        </el-select>
      </el-form-item>
      <el-form-item
        label="活动"
        prop="aid"
        :rules="[
          { required: true, message: '请选择所参加的活动', trigger: 'blur' },
        ]"
      >
        <el-select
          v-model="uptProductData.aid"
          placeholder="请选择所参加的活动"
        >
          <el-option label="今日上新" :value="1">今日上新</el-option>
          <el-option label="促销商品" :value="2">促销商品</el-option>
          <el-option label="无活动" :value="3">无活动</el-option>
        </el-select>
      </el-form-item>
      <el-form-item
        label="成色"
        prop="coid"
        :rules="[
          { required: true, message: '请选择商品成色', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptProductData.coid" placeholder="请选择商品成色">
          <el-option label="99成新" :value="1">99成新</el-option>
          <el-option label="98成新" :value="2">98成新</el-option>
          <el-option label="95成新" :value="3">95成新</el-option>
          <el-option label="9成新" :value="4">9成新</el-option>
          <el-option label="85成新" :value="5">85成新</el-option>
          <el-option label="8成新" :value="6">8成新</el-option>
        </el-select>
      </el-form-item>
      <el-form-item
        label="发货时间"
        prop="tid"
        :rules="[
          { required: true, message: '请选择发货时间', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptProductData.tid" placeholder="请选择发货时间">
          <el-option label="当天发货" :value="1">当天发货</el-option>
          <el-option label="1-3天" :value="2">1-3天</el-option>
          <el-option label="4-6天" :value="3">4-6天</el-option>
          <el-option label="大于一周" :value="4">大于一周</el-option>
        </el-select>
      </el-form-item>
      <el-form-item
        label="是否包邮"
        prop="fsid"
        :rules="[
          { required: true, message: '请选择是否包邮', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptProductData.fsid" placeholder="请选择是否包邮">
          <el-option label="是" :value="1">是</el-option>
          <el-option label="否" :value="2">否</el-option>
        </el-select>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="uptProduct('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptProduct",
  props: ["uptProductStatus", "uptProductObj"],
  data() {
    return {
      uptProductData: {
        goods_name: "",
        newprice: null,
        oldprice: null,
        imgurl: "",
        size: null,
        cid: null,
        bid: null,
        aid: null,
        coid: null,
        tid: null,
        fsid: null,
      },
      brandInfo: [],
      imgUrl: "",
    };
  },
  created() {
    this.getBrand();
  },
  methods: {
    handleFileChange(event) {
      console.log(event.target.files[0]);
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

      this.uptProductData.imgurl = file;
    },
    getBrand() {
      this.$axios.get("/admin/goods/getBrand").then((res) => {
        if (res.data.ret == 200) {
          this.brandInfo = res.data.data;
        }
      });
    },
    close() {
      this.$parent.uptProductStatus = false;
      this.imgUrl = ""
    },
    getData() {
      this.imgUrl = ""
      this.uptProductData = JSON.parse(JSON.stringify(this.uptProductObj));
      this.uptMemberData.imgurl = ""
    },
    uptProduct(formName) {
      let self = this;
      let formData = new FormData();
      formData.append("id", self.uptProductData.id);
      formData.append("goods_name", self.uptProductData.goods_name);
      formData.append("newprice", self.uptProductData.newprice);
      formData.append("oldprice", self.uptProductData.oldprice);
      formData.append("imgurl", self.uptProductData.imgurl);
      formData.append("size", self.uptProductData.size);
      formData.append("cid", self.uptProductData.cid);
      formData.append("bid", self.uptProductData.bid);
      formData.append("aid", self.uptProductData.aid);
      formData.append("coid", self.uptProductData.coid);
      formData.append("tid", self.uptProductData.tid);
      formData.append("fsid", self.uptProductData.fsid);
      formData.append("aid", self.uptProductData.aid);
      formData.append("coid", self.uptProductData.coid);
      formData.append("tid", self.uptProductData.tid);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/goods/upt", formData).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "修改成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptProductStatus = false;
                    self.$parent.getList();
                  },
                });
              } else {
                self.$message({
                  message: "修改失败",
                  type: "error",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptProductStatus = false;
                    self.$parent.getList();
                  },
                });
              }
            },
            function (err) {
              console.log(err);
            }
          );
        } else {
          return false;
        }
      });
    },
  },
};
</script>

<style scoped>
</style>
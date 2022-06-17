<template>
  <el-dialog
    title="修改分类"
    @open="getData"
    :before-close="close"
    :visible.sync="uptClassifyStatus"
    width="30%"
  >
    <el-form
      :model="uptClassifyData"
      ref="memberRule"
      inline
      label-width="80px"
    >
      <el-form-item
        label="名称"
        prop="name"
        :rules="[
          { required: true, message: '请输入分类名称', trigger: 'blur' },
        ]"
      >
        <el-input type="text" v-model="uptClassifyData.name"></el-input>
      </el-form-item>
      <el-form-item
        label="logo"
        prop="imgurlc"
        :rules="[
          { required: true, message: '请重新选择分类logo', trigger: 'blur' },
        ]"
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
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="uptClassify('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptClassify",
  props: ["uptClassifyStatus", "uptClassifyObj"],
  data() {
    return {
      uptClassifyData: {
        id: "",
        name: "",
        imgurlc:""
      },
      imgUrl: ""
    };
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

      this.uptClassifyData.imgurlc = file;
    },
    close() {
      this.$parent.uptClassifyStatus = false;
    },
    getData() {
      this.uptClassifyData = JSON.parse(JSON.stringify(this.uptClassifyObj));
    },
    uptClassify(formName) {
      let self = this;
      let formData = new FormData();
      formData.append("id", self.uptClassifyData.id);
      formData.append("name", self.uptClassifyData.name);
      formData.append("imgurlc", self.uptClassifyData.imgurlc);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/classify/upt", formData).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "添加成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptClassifyStatus = false;
                    self.$parent.getList();
                  },
                });
              } else {
                self.$message({
                  message: "添加失败",
                  type: "error",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptClassifyStatus = false;
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
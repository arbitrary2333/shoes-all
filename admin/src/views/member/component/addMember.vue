<template>
  <el-dialog
    title="添加管理员"
    :before-close="close"
    :visible.sync="addMemberStatus"
    width="30%"
  >
    <el-form :model="addMemberData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="用户名"
        prop="username"
        :rules="[{ required: true, message: '请输入用户名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="addMemberData.username"></el-input>
      </el-form-item>
      <el-form-item
        label="密码"
        prop="password"
        :rules="[{ required: true, message: '请输入密码', trigger: 'blur' }]"
      >
        <el-input type="password" v-model="addMemberData.password"></el-input>
      </el-form-item>
      <el-form-item
        label="头像"
        prop="imgurl"
        :rules="[{ required: true, message: '请选择头像', trigger: 'blur' }]"
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
      <el-button type="primary" @click="addMember('memberRule')"
        >添 加</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "addMember",
  props: ["addMemberStatus"],
  data() {
    return {
      addMemberData: {
        username: "",
        password: "",
        imgurl: "",
      },
      imgUrl: "",
    };
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

      this.addMemberData.imgurl = file;
    },
    close() {
      this.$parent.addMemberStatus = false;
    },
    addMember(formName) {
      let self = this;
      let formData = new FormData();
      formData.append("username", self.addMemberData.username);
      formData.append("password", self.addMemberData.password);
      formData.append("imgurl", self.addMemberData.imgurl);
      console.log(formData);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/manager/add", formData).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "添加成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.addMemberStatus = false;
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
                    self.$parent.addMemberStatus = false;
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
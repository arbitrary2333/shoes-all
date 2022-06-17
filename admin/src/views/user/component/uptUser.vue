<template>
  <el-dialog
    title="修改用户"
    @open="getData"
    :before-close="close"
    :visible.sync="uptUserStatus"
    width="30%"
  >
    <el-form :model="uptUserData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="用户名"
        prop="username"
        :rules="[{ required: true, message: '请填写用户名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="uptUserData.username"></el-input>
      </el-form-item>
      <el-form-item
        label="密码"
        prop="password"
        :rules="[{ required: true, message: '请填写密码', trigger: 'blur' }]"
      >
        <el-input type="password" v-model="uptUserData.password"></el-input>
      </el-form-item>
      <el-form-item
        label="手机号"
        prop="phone"
        :rules="[{ required: true, message: '请填写手机号', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="uptUserData.phone"></el-input>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="uptUser('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptUser",
  props: ["uptUserStatus", "uptUserObj"],
  data() {
    return {
      uptUserData: {
        username: "",
        password: "",
        phone: "",
      },
    };
  },
  methods: {
    close() {
      this.$parent.uptUserStatus = false;
    },
    getData() {
      this.uptUserData = JSON.parse(JSON.stringify(this.$props.uptUserObj));
    },
    uptUser(formName) {
      let self = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/user/upt", {
            id: self.uptUserData.id,
            username: self.uptUserData.username,
            password: self.uptUserData.password,
            phone: self.uptUserData.phone
          }).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "修改成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptUserStatus = false;
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
                    self.$parent.uptUserStatus = false;
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
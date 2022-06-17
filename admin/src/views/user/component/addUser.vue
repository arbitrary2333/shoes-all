<template>
  <el-dialog
    title="添加用户"
    :before-close="close"
    :visible.sync="addUserStatus"
    width="30%"
  >
    <el-form :model="addUserData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="用户名"
        prop="username"
        :rules="[{ required: true, message: '请输入用户名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="addUserData.username"></el-input>
      </el-form-item>
      <el-form-item
        label="密码"
        prop="password"
        :rules="[{ required: true, message: '请输入密码', trigger: 'blur' }]"
      >
        <el-input type="password" v-model="addUserData.password"></el-input>
      </el-form-item>
      <el-form-item
        label="手机号"
        prop="phone"
        :rules="[{ required: true, message: '请输入手机号', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="addUserData.phone"></el-input>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="addUser('memberRule')">添 加</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "addUser",
  props: ["addUserStatus"],
  data() {
    return {
      addUserData: {
        username: "",
        password: "",
        phone: "",
      },
    };
  },
  methods: {
    close() {
      this.$parent.addUserStatus = false;
    },
    addUser(formName) {
      let self = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios
            .post("/admin/user/add", {
              username: self.addUserData.username,
              password: self.addUserData.password,
              phone: self.addUserData.phone,
            })
            .then(
              function (res) {
                if (res.data.ret == 200) {
                  self.$message({
                    message: "添加成功",
                    type: "success",
                    duration: 1000,
                    onClose: function () {
                      self.$refs["memberRule"].resetFields();
                      self.$parent.addUserStatus = false;
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
                      self.$parent.addUserStatus = false;
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
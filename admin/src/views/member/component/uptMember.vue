<template>
  <el-dialog
    title="修改管理员"
    @open="getData"
    :before-close="close"
    :visible.sync="uptMemberStatus"
    width="30%"
  >
    <el-form :model="uptMemberData" ref="memberRule" inline label-width="100px">
      <el-form-item label="用户名" prop="username" :rules="[{ required: true, message: '请填写用户名', trigger: 'blur' }]">
        <el-input type="text" v-model="uptMemberData.username"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password" :rules="[{ required: true, message: '请填写密码', trigger: 'blur' }]">
        <el-input type="password" v-model="uptMemberData.password"></el-input>
      </el-form-item>
      <el-form-item
        label="头像"
        prop="imgurl"
        :rules="[{ required: true, message: '请重新选择头像', trigger: 'blur' }]"
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
      <el-button type="primary" @click="uptMember('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptMember",
  props: ["uptMemberStatus", "uptMemberObj"],
  data() {
    return {
      uptMemberData: {
        id:"",
        username:"",
        password:"",
        imgurl:""
      },
      imgUrl:""
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

      this.uptMemberData.imgurl = file;
    },
    close() {
      this.$parent.uptMemberStatus = false;
      this.imgUrl = ""
    },
    getData() {
      this.imgUrl = ""
      this.uptMemberData = JSON.parse(JSON.stringify(this.$props.uptMemberObj));
      this.uptMemberData.imgurl = ""
    },
    uptMember(formName){
      console.log(this.uptMemberData)
      let self = this
      let formData = new FormData();
      formData.append("id", self.uptMemberData.id);
      formData.append("username", self.uptMemberData.username);
      formData.append("password", self.uptMemberData.password);
      formData.append("imgurl", self.uptMemberData.imgurl);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/manager/upt",formData)
          .then(function (res) {
            if(res.data.ret == 200){
              self.$message({
                message: '修改成功',
                type: 'success',
                duration: 1000,
                onClose: function () {
                  self.$refs["memberRule"].resetFields()
                  self.$parent.uptMemberStatus = false
                  self.$parent.getList()
                }
              })
            }else {
              self.$message({
                message: "修改失败",
                type: 'error',
                duration: 1000,
                onClose: function () {
                  self.$refs["memberRule"].resetFields()
                  self.$parent.uptMemberStatus = false
                }
              })
            }
          },function (err) {
            console.log(err)
          })
        } else {
          return false;
        }
      });
    }
  },
};
</script>

<style scoped>
</style>
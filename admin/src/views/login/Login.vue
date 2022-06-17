<template>
  <div class="login">
    <div class="loginBox">
      <el-tag id="logo" effect="dark">SHOES后台管理系统</el-tag>
      <el-input type="text" v-model="username" placeholder="请输入用户名"></el-input>
      <el-input type="password" v-model="userpwd" placeholder="请输入密码"></el-input>
      <el-button type="primary" @click="login">登录</el-button>
    </div>
  </div>
</template>

<script>
  export default {
    name: "Login",
    data(){
      return{
        username:"",
        userpwd:""
      }
    },
    methods:{
      login(){
        let that = this
        if(this.username == ""){
          this.$message({
            message:"用户名不能为空",
            type:"error",
            duration:1000
          })
        }else if (this.userpwd == ""){
          this.$message({
            message:"密码不能为空",
            type:"error",
            duration:1000
          })
        }else{
          this.$axios.post("/admin/login/login",{
            username:this.username,
            password:this.userpwd
          }).then(function (res) {
            if(res.data.ret == 200 && Object.keys(res.data.data).length != 0){
              that.$message({
                type:"success",
                message:"登录成功",
                duration:1000,
                onClose:function () {
                  sessionStorage.setItem("memberAdmin",JSON.stringify(res.data.data))
                  that.$router.push("/home")
                }
              })
            }else {
              that.$message({
                type:"error",
                message:"账号或密码不正确",
                duration:1000
              })
            }
          },function (err) {
            console.log(err)
          })
        }
      }
    }
  }
</script>

<style scoped>
  #logo{
    width: 250px;
    height: 40px;
    line-height: 40px;
    font-size: 20px;
    text-align: center;
  }
  .login{
    width: 100vw;
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background: url(../../assets/imgs/bg.png) no-repeat center bottom;
  }
  .loginBox{
    width: 300px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .loginBox .el-input{
    margin: 10px 0;
  }
  .loginBox .el-button{
    width: 100%;
  }
</style>
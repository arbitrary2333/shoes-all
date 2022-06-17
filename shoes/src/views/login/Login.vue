<template>
  <div id="login">
    <sheader title="账号登录">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <!-- logo -->
      <img id="logo" src="@/assets/imgs/logo.png" alt="" />
      <!-- 手机号码 -->
      <div class="phone">
        <span class="iconfont icon-shoujihao"></span>
        <input type="number" v-model="phone" placeholder="请输入手机号码" />
      </div>
      <!-- 密码 -->
      <div class="password">
        <span class="iconfont icon-mima"></span>
        <input type="password" v-model="password" placeholder="请输入密码" />
      </div>
      <!-- 忘记密码/注册 -->
      <div class="forget">
        <!-- <p>忘记密码</p> -->
        <p></p>
        <p @click="register">注册</p>
      </div>
      <!-- 登录按钮 -->
      <button id="log" @click="login">登录</button>
      <!-- 其他账号登录 -->
      <!-- <div id="other_user">其他账号登录</div> -->
      <!-- 其他账号登陆图标 -->
      <!-- <div class="other_logo">
        <span class="iconfont icon-qq"></span>
        <span class="iconfont icon-xiazai"></span>
      </div> -->
    </main>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import stip from "@/components/stip.vue";
export default {
  name: "Login",
  components: { sheader, stip },
  data() {
    return {
      phone: "",
      password: "",
      tipMsg: "",
      tipStatus: false,
    };
  },
  created() {},
  methods: {
    went() {
      this.$router.go(-1);
    },
    register() {
      this.$router.push("/register");
    },
    login() {
      let self = this;
      if (!this.phone) {
        this.tipStatus = true;
        this.tipMsg = "手机号不能为空";
        setTimeout(() => {
          self.tipStatus = false;
        }, 3000);
      } else if (!this.password) {
        this.tipStatus = true;
        this.tipMsg = "密码不能为空";
        setTimeout(() => {
          self.tipStatus = false;
        }, 3000);
      } else {
        let formData = new FormData();
        formData.append("phone", this.phone);
        formData.append("password", this.password);
        this.$axios.post("/index/Login/login", formData).then(
          (res) => {
            if (res.data.ret == 200 && res.data.data) {
              this.tipStatus = true;
              this.tipMsg = "登录成功";
              setTimeout(() => {
                self.tipStatus = false;
                sessionStorage.setItem("member",JSON.stringify(res.data.data))
                this.$router.push("/")
              }, 3000);
            } else {
              this.tipStatus = true;
              this.tipMsg = "账号或密码不正确";
              setTimeout(() => {
                self.tipStatus = false;
              }, 3000);
            }
          },
          (err) => {
            this.tipStatus = true;
            this.tipMsg = "账号或密码不正确";
            setTimeout(() => {
              self.tipStatus = false;
            }, 3000);
          }
        );
      }
    },
  },
};
</script>

<style scoped>
#login {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex-direction: column;
}
main {
  width: 100%;
  flex: 1;
}
#logo {
  display: block;
  width: 3rem;
  height: 3rem;
  margin: 0 auto;
}
.phone,
.password {
  width: 77%;
  height: 0.87rem;
  border-bottom: 2px solid #b8b8b8;
  margin: 0 auto;
  box-sizing: border-box;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.icon-shoujihao,
.icon-mima {
  font-size: 0.32rem;
}
.phone input,
.password input {
  width: calc(100% - 0.5rem);
  height: 100%;
  border: none;
  outline: none;
  font-size: 0.24rem;
  color: #999999;
}
.password {
  margin-top: 0.3rem;
}
.forget {
  width: 77%;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  font-size: 0.24rem;
  margin-top: 0.3rem;
}
#log {
  width: 62%;
  height: 0.83rem;
  display: block;
  background: #666666;
  color: white;
  font-size: 0.36rem;
  letter-spacing: 0.38rem;
  /* 首行缩进 */
  text-indent: 0.38rem;
  border: none;
  border-radius: 5px;
  margin: 0 auto;
  margin-top: 0.6rem;
}
#other_user {
  margin: 0 auto;
  margin-top: 0.8rem;
  font-size: 0.24rem;
  text-align: center;
}
.other_logo {
  width: 1.8rem;
  height: 0.52rem;
  margin: 0 auto;
  margin-top: 0.43rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.icon-qq,
.icon-xiazai {
  font-size: 0.48rem;
}
</style>
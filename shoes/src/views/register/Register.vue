<template>
  <div id="register">
    <sheader title="账号注册">
      <!-- 插槽 -->
      <template>
        <span class="iconfont icon-tubiao_fanhui" @click="went"></span>
      </template>
    </sheader>
    <main>
      <!-- logo -->
      <img id="logo" src="@/assets/imgs/logo.png" alt="" />
      <!-- 用户名 -->
      <div class="username">
        <span>用户名：</span>
        <input type="text" v-model.trim="username" />
      </div>
      <!-- 密码 -->
      <div class="password">
        <span>密码：</span>
        <input type="password" v-model.trim="password" />
      </div>
      <!-- 确认密码 -->
      <div class="sure">
        <span>确认密码：</span>
        <input type="password" v-model.trim="surepwd" />
      </div>
      <!-- 手机号码 -->
      <div class="phone">
        <span>手机号码：</span>
        <input type="number" v-model.trim="phone" />
      </div>
      <!-- 验证码 -->
      <div class="code">
        <span>验证码：</span>
        <input type="text" v-model.trim="code" />
        <!--验证码组件-->
        <div @click="refreshCode">
          <sidentify :identifyCode="identifyCode"></sidentify>
        </div>
        <!-- <p>获取验证码</p> -->
      </div>
      <!-- 注册按钮 -->
      <button id="reg" @click="register">注册</button>
    </main>
    <stip :tipStatus="tipStatus" :tipMsg="tipMsg"></stip>
  </div>
</template>

<script>
import sheader from "@/components/sheader.vue";
import sidentify from "@/components/sidentify.vue";
import stip from "@/components/stip.vue";
export default {
  name: "Login",
  components: { sheader, sidentify, stip },
  data() {
    return {
      username: "",
      password: "",
      surepwd: "",
      phone: "",
      code: "",
      tipStatus: false,
      tipMsg: "",
      identifyCode: "",
      identifyCodes: "1234567890abcdefjhijklinopqrsduvwxyz",
    };
  },
  mounted() {
    // 初始化验证码
    this.identifyCode = "";
    this.makeCode(this.identifyCodes, 4);
    console.log(this.identifyCode);
  },
  methods: {
    went() {
      this.$router.go(-1);
    },
    // 刷新验证码
    refreshCode() {
      this.identifyCode = "";
      this.makeCode(this.identifyCodes, 4);
    },
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode +=
          this.identifyCodes[this.randomNum(0, this.identifyCodes.length)];
      }
    },
    randomNum(min, max) {
      return Math.floor(Math.random() * (max - min) + min);
    },
    register() {
      let self = this
      console.log(1);
      if (
        !this.username ||
        !this.phone ||
        !this.password ||
        !this.surepwd ||
        !this.code
      ) {
        this.tipStatus = true;
        this.tipMsg = "参数未填写完整";
        setTimeout(() => {
          this.tipStatus = false;
        }, 3000);
      } else {
        if (this.password == this.surepwd) {
          if (this.code == this.identifyCode) {
            let formData = new FormData();
            formData.append("username", this.username);
            formData.append("phone", this.phone);
            formData.append("password", this.password);
            this.$axios.post("/index/Register/register", formData).then(
              (res) => {
                if (res.data.ret == 200 && res.data.data) {
                  this.tipStatus = true;
                  this.tipMsg = "注册成功";
                  setTimeout(() => {
                    self.tipStatus = false;
                    this.$router.go(-1);
                  }, 2000);
                } else {
                  this.tipStatus = true;
                  this.tipMsg = res.data.msg;
                  setTimeout(() => {
                    self.tipStatus = false;
                  }, 2000);
                }
              },
              (err) => {
                this.tipStatus = true;
                this.tipMsg = err.msg;
                setTimeout(() => {
                  self.tipStatus = false;
                }, 2000);
              }
            );
          } else {
            this.tipStatus = true;
            this.tipMsg = "验证码错误";
            setTimeout(() => {
              this.tipStatus = false;
            }, 2000);
          }
        } else {
          this.tipStatus = true;
          this.tipMsg = "两次密码输入不一致";
          setTimeout(() => {
            this.tipStatus = false;
          }, 3000);
        }
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
.username,
.phone,
.password,
.sure {
  width: 77%;
  height: 0.87rem;
  border-bottom: 2px solid #b8b8b8;
  margin: 0 auto;
  margin-bottom: 0.38rem;
  box-sizing: border-box;
  display: flex;
  align-items: center;
}
.username span,
.phone span,
.password span,
.sure span,
.code span {
  font-size: 0.24rem;
}
.username input,
.phone input,
.password input,
.sure input {
  width: 75%;
  height: 100%;
  border: none;
  outline: none;
  font-size: 0.24rem;
  color: #999999;
}
.code {
  width: 77%;
  height: 0.87rem;
  border-bottom: 2px solid #b8b8b8;
  margin: 0 auto;
  box-sizing: border-box;
  display: flex;
  align-items: center;
}
.code input {
  width: 40%;
  height: 100%;
  border: none;
  outline: none;
  font-size: 0.24rem;
  color: #999999;
}
.code p {
  width: 1.8rem;
  height: 0.4rem;
  border: 2px solid #999999;
  border-radius: 5px;
  font-size: 0.24rem;
  color: #999999;
  text-align: center;
  line-height: 0.4rem;
}
#reg {
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
  margin-top: 1.32rem;
}
</style>
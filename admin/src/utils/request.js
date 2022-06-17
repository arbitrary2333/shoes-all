//封装axios
import axios from "axios";
import Vue from 'vue'
let vue = new Vue()
axios.defaults.baseURL="/api"
axios.defaults.timeout=50000
let instance = axios.create()

//请求拦截器，在请求接口之前执行
instance.interceptors.request.use(function (config) {
  //拦截之前的业务逻辑
  //token
  let memberAdmin = JSON.parse(sessionStorage.getItem("memberAdmin"))
  if(memberAdmin){
    config.headers["token"] = memberAdmin.token
  }
  return config
},function (err) {
  return Promise.reject()
})

instance.interceptors.response.use(function (res) {
  return res
},function (err) {
  console.log(err.response)
  //401,403,404,500
  switch (err.response.status) {
    case 401:
      vue.$alert('请设置token', '错误提示', {
        confirmButtonText: '确定'
      });
      break
    case 403:
      vue.$alert('token失效', '错误提示', {
        confirmButtonText: '确定',
        callback: action => {
          sessionStorage.removeItem("member")
          location.href="/login"
        }
      });
      break
    case 404:
      vue.$alert('404页面未找到', '错误提示', {
        confirmButtonText: '确定',
        callback: action => {
          location.href="/home"
        }
      });
      break
    case 500:
      vue.$alert('服务端出错', '错误提示', {
        confirmButtonText: '确定'
      });
      break
  }

  return Promise.reject(err.response)
})

export {
  instance
}
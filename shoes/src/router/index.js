import Vue from 'vue'
import VueRouter from 'vue-router'
import Router from 'vue-router'
import Home from '../views/home/Home'

Vue.use(VueRouter)
Vue.use(Router)
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location, onResolve, onReject) {
    if (onResolve || onReject) return originalPush.call(this, location, onResolve, onReject)
    return originalPush.call(this, location).catch(err => err)
}

//修改原型对象中的push方法
Router.prototype.push = function push(location) {
   return originalPush.call(this, location).catch(err => err)
}
const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/classify',
    name: 'classify',
    component: () => import("@/views/classify/Classify")
  },
  {
    path: '/sale',
    name: 'sale',
    component: () => import("@/views/sale/Sale"),
    meta: {                      //加一个自定义obj
      requireAuth: true      //这个参数 true 代表需要登录才能进入A
    }
  },
  {
    path: '/shopcar',
    name: 'shopcar',
    component: () => import("@/views/shopcar/Shopcar"),
    meta: {                     
      requireAuth: true     
    }
  },
  {
    path: '/mine',
    name: 'mine',
    component: () => import("@/views/mine/Mine")
  },
  {
    path: '/login',
    name: 'login',
    component: () => import("@/views/login/Login")
  },
  {
    path: '/register',
    name: 'register',
    component: () => import("@/views/register/Register")
  },
  {
    path: '/classifyList',
    name: 'classifyList',
    component: () => import("@/views/classifyList/ClassifyList")
  },
  {
    path: '/searchOrder',
    name: 'searchOrder',
    component: () => import("@/views/searchOrder/SearchOrder"),
    meta: {                     
      requireAuth: true     
    }
  },
  {
    path: '/order',
    name: 'order',
    component: () => import("@/views/order/Order"),
    meta: {                     
      requireAuth: true     
    }
  },
  {
    path: '/release',
    name: 'release',
    component: () => import("@/views/release/Release"),
    meta: {                     
      requireAuth: true     
    }
  },
  {
    path: '/productDetail',
    name: 'productDetail',
    component: () => import("@/views/productDetail/ProductDetail")
  },
  {
    path: '/addConsignee',
    name: 'addConsignee',
    component: () => import("@/views/addConsignee/AddConsignee")
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

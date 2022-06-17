import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location, onResolve, onReject) {
    if (onResolve || onReject) return originalPush.call(this, location, onResolve, onReject)
    return originalPush.call(this, location).catch(err => err)
}

const routes = [
  {
    path: '/',
    name: 'login',
    component: () => import("@/views/login/Login"),
  },
  {
    path: '/home',
    name: 'home',
    meta:{
      title:"首页"
    },
    component: () => import("@/views/home/Home"),
    children:[
      {
        path: '/member',
        name: 'member',
        meta:{
          title:"管理员列表"
        },
        component: () => import("@/views/member/Member"),
      },
      {
        path: '/classify',
        name: 'classify',
        meta:{
          title:"分类列表"
        },
        component: () => import("@/views/classify/Classify"),
      },
      {
        path: '/product',
        name: 'product',
        meta:{
          title:"产品列表"
        },
        component: () => import("@/views/product/Product"),
      },
      {
        path: '/orders',
        name: 'orders',
        meta:{
          title:"订单列表"
        },
        component: () => import("@/views/orders/Orders"),
      },
      {
        path: '/user',
        name: 'user',
        meta:{
          title:"用户列表"
        },
        component: () => import("@/views/user/User"),
      },
      {
        path: '/address',
        name: 'address',
        meta:{
          title:"地址列表"
        },
        component: () => import("@/views/address/Address"),
      },
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

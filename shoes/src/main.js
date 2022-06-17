import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import {instance} from "./utils/request";
// import ElementUI from 'element-ui';
// import 'element-ui/lib/theme-chalk/index.css';

Vue.config.productionTip = false
Vue.prototype.$axios = instance
// Vue.use(ElementUI);

//全局路由拦截
router.beforeEach(function (to,from,next) {
  if(to.meta.requireAuth){
    if(sessionStorage.getItem("member")){
      next()
    }else{
      next({path: '/login'})
    }
  }else {
    next()
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

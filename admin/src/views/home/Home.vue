<template>
  <div>
    <el-container>
      <el-aside width="auto">
        <el-menu default-active="1-4-1" class="el-menu-vertical-demo" :collapse="isCollapse" @select="jump">
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-setting"></i>
              <span slot="title">管理员管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/member">管理员列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span slot="title">分类管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/classify">分类列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span slot="title">用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/user">用户列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-document"></i>
              <span slot="title">产品管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/product">产品列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="5">
            <template slot="title">
              <i class="el-icon-shopping-cart-full"></i>
              <span slot="title">订单列表</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/orders">订单列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="6">
            <template slot="title">
              <i class="el-icon-discover"></i>
              <span slot="title">地址管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="/address">地址列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header style="display:flex;justify-content:space-between;align-items: center">
          <el-radio-group v-model="isCollapse">
            <el-radio-button :label="false">展开</el-radio-button>
            <el-radio-button :label="true">收起</el-radio-button>
          </el-radio-group>
          <el-tag id="logo" effect="dark">SHOES后台管理系统</el-tag>

          <div style="display: flex;flex-direction: row;justify-content: space-around;align-items: center">
            <el-avatar shape="circle" size="medium" :src="'http://www.shoes.com:8081'+imgurl"></el-avatar>
            <div style="marginRight: 10px;marginLeft: 5px">
              <el-link :underline="false" type="primary" style="marginRight: 10px">{{name}}</el-link>
              欢迎您~~~
            </div>
            <el-button type="primary" @click="exit">退出</el-button>
          </div>
        </el-header>
        <el-main>
          <el-breadcrumb style="height: 30px" separator-class="el-icon-arrow-right">
            <el-breadcrumb-item v-for="(item,index) in breadcrumbList" :key="index">{{item.meta.title}}</el-breadcrumb-item>
          </el-breadcrumb>
          <div v-if="$route.name == 'home'" style="text-align:left;font-size:20px;color:blue;font-weight:bold">欢迎来到SHOES后台管理系统</div>
          <router-view v-else/>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
  export default {
    name: "Home",
    data() {
      return {
        isCollapse: true,
        name:"",
        imgurl:"",
        role:null
      };
    },
    created() {
      this.name = JSON.parse(sessionStorage.getItem("memberAdmin")).username
      this.imgurl = JSON.parse(sessionStorage.getItem("memberAdmin")).imgurl
    },
    computed:{
      breadcrumbList:function () {
        return this.$route.matched
      }
    },
    methods:{
      jump(key){
        this.$router.push(key)
      },
      exit(){
        let that = this
        this.$confirm('是否退出?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$message({
            type: 'success',
            message: '退出成功!',
            duration:1000,
            onClose:function () {
              sessionStorage.removeItem("memberAdmin")
              that.$router.push("/login")
            }
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消',
            duration:1000
          });
        });
      }
    },
    
  }
</script>

<style scoped>
  /*NavMenu导航菜单*/
  .el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 200px;
    min-height: 400px;
  }
  /*container布局容器*/
  #logo{
    width: 250px;
    height: 40px;
    line-height: 40px;
    font-size: 20px;
    text-align: center;
  }
  .el-header{
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
  }

  .el-aside {
    display: flex;
    flex-direction: column;
    height: auto;
    color: #333;
    text-align: center;
    line-height: 200px;
  }

  .el-main {
    height: calc(100vh - 60px);
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
  }

  body > .el-container {
    margin-bottom: 40px;
  }

  .el-container:nth-child(5) .el-aside,
  .el-container:nth-child(6) .el-aside {
    line-height: 260px;
  }

  .el-container:nth-child(7) .el-aside {
    line-height: 320px;
  }
</style>
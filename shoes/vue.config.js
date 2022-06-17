module.exports = {
  // webpack-dev-server 相关配置
  devServer: {
    proxy: { //跨域配置
      '/api': {
        target: 'http://www.shoes.com:8081/index.php', //源地址
        changeOrigin: true,//改变源(跨域)
        ws: true,//是否代理websockets
        secure: true,//http 请求模式
        pathRewrite: { //如果接口地址以api前缀开始 打开即可
          '^/api': ''
        }
      }
    }
  }
}
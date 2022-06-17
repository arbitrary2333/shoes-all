<template>
  <div id="container">
    <template>
      <div class="memberMenu">
        <el-button type="primary" size="mini" @click="addProductStatus = true"
          >添加</el-button
        >
        <el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
      </div>
      <el-table
        v-loading="loading"
        :data="
          productData
            .filter(
              (data) =>
                !search ||
                data.goods_name.toLowerCase().includes(search.toLowerCase())
            )
            .slice((currentPage - 1) * pagesize, currentPage * pagesize)
        "
      >
        <el-table-column label="编号" prop="id"></el-table-column>
        <el-table-column
          width="200px"
          label="商品名称"
          prop="goods_name"
        ></el-table-column>
        <el-table-column label="新价格" prop="newprice"></el-table-column>
        <el-table-column label="旧价格" prop="oldprice"></el-table-column>
        <el-table-column label="照片" prop="imgurl">
          <template slot-scope="scope">
            <el-avatar
              shape="square"
              :size="80"
              fit="fill"
              :src="'http://www.shoes.com:8081' + scope.row.imgurl"
            ></el-avatar>
          </template>
        </el-table-column>
        <el-table-column label="尺码" prop="size"></el-table-column>
        <el-table-column label="分类" prop="name"></el-table-column>
        <el-table-column label="品牌" prop="brand_name"></el-table-column>
        <el-table-column label="活动" prop="activity_name"></el-table-column>
        <el-table-column label="成色" prop="condition_name"></el-table-column>
        <el-table-column label="发货时间" prop="time_name"></el-table-column>
        <el-table-column
          label="包邮"
          prop="freeshipping_name"
        ></el-table-column>
        <el-table-column width="200px" label="操作">
          <template slot-scope="scope">
            <el-button size="mini" @click="edit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="del(scope.row.id)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[5, 10, 20, 40]"
        :page-size="pagesize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="productListTotal"
        style="margin-top: 10px"
      ></el-pagination>

      <add-product :addProductStatus="addProductStatus"></add-product>
      <upt-product
        :uptProductStatus="uptProductStatus"
        :uptProductObj="uptProductObj"
      ></upt-product>
    </template>
  </div>
</template>

<script>
import addProduct from "./component/addProduct";
import uptProduct from "./component/uptProduct";
export default {
  name: "Product",
  components: { addProduct, uptProduct },
  data() {
    return {
      uptProductObj: {},
      addProductStatus: false,
      uptProductStatus: false,
      search: "",
      productData: [],
      productListTotal: 0,
      loading: true,
      currentPage: 1, //初始页
      pagesize: 10, //    每页的数据
    };
  },
  methods: {
    // 初始页currentPage、初始每页数据数pagesize和数据data
    handleSizeChange(size) {
      this.pagesize = size;
      console.log(this.pagesize); //每页下拉显示数据
    },
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage;
      console.log(this.currentPage); //点击第几页
    },
    getList() {
      let self = this;
      this.$axios.get("/admin/goods/showlist").then(function (res) {
        if (res.data.ret == 200) {
          self.loading = false;
          self.productListTotal = res.data.data.length;
          self.productData = res.data.data;
        }
      });
    },
    edit(obj) {
      this.uptProductObj = obj;
      this.uptProductStatus = true;
    },
    del(id) {
      let self = this;
      this.$confirm("是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/goods/del", { id }).then(function (res) {
            if (res.data.ret == 200) {
              self.$message({
                message: "删除成功",
                type: "success",
                duration: 1000,
                onClose: function () {
                  self.getList();
                },
              });
            } else {
              self.$message({
                message: "删除失败",
                type: "error",
                duration: 1000,
              });
            }
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
  },
  created() {
    this.getList();
  },
};
</script>

<style scoped>
.memberMenu {
  background: #fff;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: 1px solid #dddddd;
  display: flex;
}
.memberMenu .el-input {
  width: 250px;
  margin: 0 20px;
}
</style>
<template>
  <div id="container">
    <template>
      <div class="classifyMenu">
        <el-button type="primary" size="mini" @click="addClassifyStatus = true"
          >添加</el-button
        >
        <el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
      </div>
      <el-table
        v-loading="loading"
        :data="
          classifyData
            .filter(
              (data) =>
                !search ||
                data.name.toLowerCase().includes(search.toLowerCase())
            )
            .slice((currentPage - 1) * pagesize, currentPage * pagesize)
        "
      >
        <el-table-column label="编号" prop="id"></el-table-column>
        <el-table-column label="名称" prop="name"></el-table-column>
        <el-table-column label="logo">
          <template slot-scope="scope">
            <el-avatar
              shape="square"
              :size="50"
              :src="'http://www.shoes.com:8081' + scope.row.imgurlc"
            ></el-avatar>
          </template>
        </el-table-column>
        <el-table-column label="操作">
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
        :total="classifyListTotal"
        style="margin-top: 10px"
      ></el-pagination>

      <add-classify :addClassifyStatus="addClassifyStatus"></add-classify>
      <upt-classify
        :uptClassifyStatus="uptClassifyStatus"
        :uptClassifyObj="uptClassifyObj"
      ></upt-classify>
    </template>
  </div>
</template>

<script>
import addClassify from "./component/addClassify";
import uptClassify from "./component/uptClassify";
export default {
  name: "Classify",
  components: { addClassify, uptClassify },
  data() {
    return {
      uptClassifyObj: {},
      addClassifyStatus: false,
      uptClassifyStatus: false,
      classifyListTotal: 0,
      search: "",
      classifyData: [],
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
      this.$axios.get("/admin/classify/showlist").then(function (res) {
        if (res.data.ret == 200) {
          self.loading = false;
          self.classifyListTotal = res.data.data.length;
          self.classifyData = res.data.data;
        }
      });
    },
    edit(obj) {
      this.uptClassifyObj = obj;
      this.uptClassifyStatus = true;
    },
    del(id) {
      let self = this;
      this.$confirm("是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/classify/del", { id }).then(function (res) {
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
              console.log(res);
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
.classifyMenu {
  background: #fff;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: 1px solid #dddddd;
  text-align: start;
  display: flex;
}
.classifyMenu .el-input {
  width: 250px;
  margin: 0 20px;
}
</style>
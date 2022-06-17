<template>
  <div id="container">
    <template>
      <div class="memberMenu">
        <el-button type="primary" size="mini" @click="addMemberStatus = true"
          >添加</el-button
        >
        <el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
      </div>
      <el-table
        size="mini"
        v-loading="loading"
        :data="
          memberData
            .filter(
              (data) =>
                !search ||
                data.username.toLowerCase().includes(search.toLowerCase())
            )
            .slice((currentPage - 1) * pagesize, currentPage * pagesize)
        "
      >
        <el-table-column label="编号" prop="id"></el-table-column>
        <el-table-column label="用户名" prop="username"></el-table-column>
        <el-table-column label="密码" prop="password"></el-table-column>
        <el-table-column label="头像">
          <template slot-scope="scope">
            <el-avatar
              shape="circle"
              size="medium"
              :src="'http://www.shoes.com:8081' + scope.row.imgurl"
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
        :total="memberListTotal"
        style="margin-top: 10px"
      ></el-pagination>

      <add-member :addMemberStatus="addMemberStatus"></add-member>
      <upt-member
        :uptMemberStatus="uptMemberStatus"
        :uptMemberObj="uptMemberObj"
      ></upt-member>
    </template>
  </div>
</template>

<script>
import addMember from "./component/addMember";
import uptMember from "./component/uptMember";
export default {
  name: "Member",
  components: { addMember, uptMember },
  data() {
    return {
      uptMemberObj: {},
      uptMemberStatus: false,
      addMemberStatus: false,
      memberListTotal: 0,
      search: "",
      memberData: [],
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
      this.$axios.get("/admin/manager/showlist").then(
        (res) => {
          if (res.data.ret == 200) {
            console.log(res);
            self.loading = false;
            self.memberListTotal = res.data.data.length;
            self.memberData = res.data.data;
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    edit(obj) {
      this.uptMemberObj = obj;
      this.uptMemberStatus = true;
    },
    del(id) {
      let self = this;
      this.$confirm("是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/manager/del", { id }).then(function (res) {
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
body {
  margin: 0;
}
.memberMenu {
  background: #fff;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: 1px solid #dddddd;
  text-align: start;
  display: flex;
}
.memberMenu .el-input {
  width: 250px;
  margin: 0 20px;
}
</style>
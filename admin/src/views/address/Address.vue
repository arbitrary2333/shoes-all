<template>
  <div id="container">
    <template>
      <div class="memberMenu">
        <el-button type="primary" size="mini" @click="addAddressStatus = true"
          >添加</el-button
        >
        <el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
      </div>
      <el-table
        size="mini"
        v-loading="loading"
        :data="
          addressData
            .filter(
              (data) =>
                !search ||
                data.consignee_name.toLowerCase().includes(search.toLowerCase())
            )
            .slice((currentPage - 1) * pagesize, currentPage * pagesize)
        "
      >
        <el-table-column label="编号" prop="id"></el-table-column>
        <el-table-column
          label="收货人姓名"
          prop="consignee_name"
        ></el-table-column>
        <el-table-column
          label="收货人地址"
          prop="consignee_address"
        ></el-table-column>
        <el-table-column label="手机号" prop="phone"></el-table-column>
        <el-table-column label="所属用户" prop="username"></el-table-column>
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
        :total="addressListTotal"
        style="margin-top: 10px"
      ></el-pagination>
      <add-address
        :addAddressStatus="addAddressStatus"
        :userData="userData"
      ></add-address>
      <upt-address
        :uptAddressStatus="uptAddressStatus"
        :uptAddressObj="uptAddressObj"
        :userData="userData"
      ></upt-address>
    </template>
  </div>
</template>

<script>
import addAddress from "./component/addAddress";
import uptAddress from "./component/uptAddress";
export default {
  name: "Address",
  components: { addAddress, uptAddress },
  data() {
    return {
      uptAddressObj: {},
      uptAddressStatus: false,
      addAddressStatus: false,
      addressListTotal: 0,
      search: "",
      addressData: [],
      userData: [],
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
    getUserList() {
      this.$axios.get("/admin/user/showlist").then((res) => {
        if (res.data.ret == 200) {
          this.userData = res.data.data;
        }
      });
    },
    getList() {
      let self = this;
      this.$axios.get("/admin/address/showlist").then(
        (res) => {
          if (res.data.ret == 200) {
            console.log(res);
            self.loading = false;
            self.addressListTotal = res.data.data.length;
            self.addressData = res.data.data;
          }
        },
        (err) => {
          console.log(err);
        }
      );
    },
    edit(obj) {
      this.uptAddressObj = obj;
      this.uptAddressStatus = true;
    },
    del(id) {
      let self = this;
      this.$confirm("是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/address/del", { id }).then(function (res) {
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
    this.getUserList();
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
<template>
  <div>
    <div class="top">
      <el-input placeholder="请输入订单编号" v-model="searchOrder">
        <template slot="append">
          <el-button @click="search">搜索</el-button>
        </template>
      </el-input>
    </div>
    <div class="orderList">
      <el-table
        v-loading="loading"
        :data="
          ordersData.slice((currentPage - 1) * pagesize, currentPage * pagesize)
        "
        style="width: 100%"
      >
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form
              v-for="(item, index) in props.row.order_goods"
              :key="index"
              label-position="left"
              inline
              class="demo-table-expand"
              style="border-bottom: 1px solid #ebeef5"
            >
              <el-form-item label="产品名称">
                <span>{{ item.goods_name }}</span>
              </el-form-item>
              <el-form-item label="价格">
                <span>{{ item.goods_price }}</span>
              </el-form-item>
              <el-form-item label="尺码">
                <span>{{ item.size }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="编号" prop="id" width="50px"> </el-table-column>
        <el-table-column label="订单编号" prop="order_sn" width="250px">
        </el-table-column>
        <el-table-column label="订单总价" prop="order_amount">
        </el-table-column>
        <el-table-column label="下单用户" prop="username"> </el-table-column>
        <el-table-column label="收货人姓名" prop="consignee_name">
        </el-table-column>
        <el-table-column
          label="收货地址"
          prop="consignee_address"
          width="250px"
        >
        </el-table-column>
        <el-table-column label="收货人手机号" prop="consignee_phone">
        </el-table-column>
        <el-table-column width="250px" label="操作">
          <template slot-scope="scope">
            <!-- <el-button size="mini" @click="add">添加</el-button> -->
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
        :total="orderListTotal"
        style="margin-top: 10px"
      ></el-pagination>
    </div>
    <upt-orders
      :uptOrdersStatus="uptOrdersStatus"
      @switchUptStatus="switchUptStatus"
      :uptOrdersObj="uptOrdersObj"
    ></upt-orders>
  </div>
</template>

<script>
import uptOrders from "./component/uptOrders";
export default {
  name: "Orders",
  components: { uptOrders },
  inject: ["reload"], //注入App里的reload方法
  data() {
    return {
      orderListTotal: 0,
      searchOrder: "",
      ordersData: [],
      uptOrdersObj: {},
      allOrderData: [],
      loading: true,
      uptOrdersStatus: false,
      currentPage: 1, //初始页
      pagesize: 10, //    每页的数据
    };
  },
  created() {
    this.getList();
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
    //订单列表
    getList() {
      let self = this;
      this.$axios.get("/admin/order/showlist").then(function (res) {
        if (res.data.ret == 200) {
          self.loading = false;
          self.orderListTotal = res.data.data.length;
          self.ordersData = res.data.data;
          self.allOrderData = res.data.data; //用于检索
        }
      });
    },
    search() {
      let self = this;
      this.ordersData = this.allOrderData.filter((item) => {
        return (
          !self.searchOrder ||
          item.order_sn.toLowerCase().includes(self.searchOrder.toLowerCase())
        );
      });
    },
    edit(val) {
      this.uptOrdersStatus = true;
      this.uptOrdersObj.id = val.id;
      this.uptOrdersObj.consignee_name = val.consignee_name;
      this.uptOrdersObj.consignee_phone = val.consignee_phone;
      this.uptOrdersObj.consignee_address = val.consignee_address;
    },
    del(id) {
      let self = this;
      this.$confirm("是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/order/del", { id }).then(function (res) {
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
    switchUptStatus() {
      this.uptOrdersStatus = false;
    },
  },
};
</script>

<style scoped>
.top {
  display: flex;
  background: #ffffff;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: 1px solid #dddddd;
}
.top .el-input {
  width: 250px;
  margin: 0 20px;
}
.formBtm {
  display: flex;
  justify-content: space-between;
}
.formBtmLeft {
  width: 40%;
  display: flex;
  flex-direction: column;
}
.formBtmRight {
  width: 60%;
}

.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
</style>
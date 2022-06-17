<template>
  <el-dialog
    title="修改订单"
    @open="getData"
    :before-close="close"
    :visible.sync="uptOrdersStatus"
    width="30%"
  >
    <el-form :model="uptOrdersData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="收货人姓名"
        label-width="150px"
        prop="consignee_name"
        :rules="[{ required: true, message: '请填写收货人姓名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="uptOrdersData.consignee_name"></el-input>
      </el-form-item>
      <el-form-item
        label="收货人地址"
        label-width="150px"
        prop="consignee_address"
        :rules="[{ required: true, message: '请填写收货人地址', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="uptOrdersData.consignee_address"></el-input>
      </el-form-item>
      <el-form-item
        label="收货人手机号"
        label-width="150px"
        prop="consignee_phone"
        :rules="[{ required: true, message: '请填写收货人手机号', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="uptOrdersData.consignee_phone"></el-input>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="uptOrders('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptOrders",
  props: ["uptOrdersStatus", "uptOrdersObj"],
  data() {
    return {
      uptOrdersData: {
          id: "",
          consignee_name: "",
          consignee_phone: "",
          consignee_address: ""
      },
    };
  },
  methods: {
    close() {
      this.$emit("switchUptStatus")
    },
    getData() {
      this.uptOrdersData = JSON.parse(JSON.stringify(this.$props.uptOrdersObj));
    },
    uptOrders(formName) {
      let self = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/order/upt", {
            id: self.uptOrdersData.id,
            consignee_name: self.uptOrdersData.consignee_name,
            consignee_phone: self.uptOrdersData.consignee_phone,
            consignee_address: self.uptOrdersData.consignee_address
          }).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "修改成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptOrdersStatus = false;
                    self.$parent.getList();
                  },
                });
              } else {
                self.$message({
                  message: "修改失败",
                  type: "error",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptOrdersStatus = false;
                  },
                });
              }
            },
            function (err) {
              console.log(err);
            }
          );
        } else {
          return false;
        }
      });
    },
  },
};
</script>

<style scoped>
</style>
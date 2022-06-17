<template>
  <el-dialog
    title="修改用户"
    @open="getData"
    :before-close="close"
    :visible.sync="uptAddressStatus"
    width="30%"
  >
    <el-form :model="uptAddressData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="收货人姓名"
        prop="consignee_name"
        :rules="[{ required: true, message: '请填写收货人姓名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="uptAddressData.consignee_name"></el-input>
      </el-form-item>
      <el-form-item
        label="收货人地址"
        prop="consignee_address"
        :rules="[{ required: true, message: '请填写收货人地址', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="uptAddressData.consignee_address"></el-input>
      </el-form-item>
      <el-form-item
        label="手机号"
        prop="phone"
        :rules="[{ required: true, message: '请填写手机号', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="uptAddressData.phone"></el-input>
      </el-form-item>
      <el-form-item
        label="所属用户"
        prop="uid"
        :rules="[
          { required: true, message: '请选择用户', trigger: 'blur' },
        ]"
      >
        <el-select v-model="uptAddressData.uid" placeholder="请选择用户">
          <el-option v-for="user in userData" :key="user.id" :label="user.username" :value="user.id">{{user.username}}</el-option>
        </el-select>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="uptAddress('memberRule')"
        >修 改</el-button
      >
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "uptAddress",
  props: ["uptAddressStatus", "uptAddressObj", "userData"],
  data() {
    return {
      uptAddressData: {
        consignee_name: "",
        consignee_address: "",
        phone: "",
        uid: ""
      },
    };
  },
  methods: {
    close() {
      this.$parent.uptAddressStatus = false;
    },
    getData() {
      this.uptAddressData = JSON.parse(JSON.stringify(this.$props.uptAddressObj));
    },
    uptAddress(formName) {
      console.log(this.uptAddressData)
      let self = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios.post("/admin/address/upt", {
            id: self.uptAddressData.id,
            consignee_name: self.uptAddressData.consignee_name,
            consignee_address: self.uptAddressData.consignee_address,
            phone: self.uptAddressData.phone,
            uid: self.uptAddressData.uid
          }).then(
            function (res) {
              if (res.data.ret == 200) {
                self.$message({
                  message: "修改成功",
                  type: "success",
                  duration: 1000,
                  onClose: function () {
                    self.$refs["memberRule"].resetFields();
                    self.$parent.uptAddressStatus = false;
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
                    self.$parent.uptAddressStatus = false;
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
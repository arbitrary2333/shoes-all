<template>
  <el-dialog
    title="添加用户"
    :before-close="close"
    :visible.sync="addAddressStatus"
    width="30%"
  >
    <el-form :model="addAddressData" ref="memberRule" inline label-width="100px">
      <el-form-item
        label="收货人姓名"
        prop="consignee_name"
        :rules="[{ required: true, message: '请输入用户名', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="addAddressData.consignee_name"></el-input>
      </el-form-item>
      <el-form-item
        label="收货人地址"
        prop="consignee_address"
        :rules="[{ required: true, message: '请输入收货人地址', trigger: 'blur' }]"
      >
        <el-input type="text" v-model="addAddressData.consignee_address"></el-input>
      </el-form-item>
      <el-form-item
        label="手机号"
        prop="phone"
        :rules="[{ required: true, message: '请输入手机号', trigger: 'blur' }]"
      >
        <el-input type="number" v-model="addAddressData.phone"></el-input>
      </el-form-item>
      <el-form-item
        label="所属用户"
        prop="uid"
        :rules="[
          { required: true, message: '请选择用户', trigger: 'blur' },
        ]"
      >
        <el-select v-model="addAddressData.uid" placeholder="请选择用户">
          <el-option v-for="user in userData" :key="user.id" :label="user.username" :value="user.id">{{user.username}}</el-option>
        </el-select>
      </el-form-item>
    </el-form>

    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="addAddress('memberRule')">添 加</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: "addAddress",
  props: ["addAddressStatus","userData"],
  data() {
    return {
      addAddressData: {
        consignee_name: "",
        consignee_address: "",
        phone: "",
        uid: ""
      },
    };
  },
  methods: {
    close() {
      this.$parent.addAddressStatus = false;
    },
    addAddress(formName) {
      let self = this;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$axios
            .post("/admin/address/add", {
              consignee_name: self.addAddressData.consignee_name,
              consignee_address: self.addAddressData.consignee_address,
              phone: self.addAddressData.phone,
              uid: self.addAddressData.uid
            })
            .then(
              function (res) {
                if (res.data.ret == 200) {
                  self.$message({
                    message: "添加成功",
                    type: "success",
                    duration: 1000,
                    onClose: function () {
                      self.$refs["memberRule"].resetFields();
                      self.$parent.addAddressStatus = false;
                      self.$parent.getList();
                    },
                  });
                } else {
                  self.$message({
                    message: "添加失败",
                    type: "error",
                    duration: 1000,
                    onClose: function () {
                      self.$refs["memberRule"].resetFields();
                      self.$parent.addAddressStatus = false;
                      self.$parent.getList();
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
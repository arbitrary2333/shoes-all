<template>
  <div id="all" v-show="dialogStatus">
    <div id="dialog" @click="handleCancel"></div>
    <div id="content">
      <h2>提示</h2>
      <div class="info">
        <p>{{ dialogMsg }}</p>
      </div>
      <div class="btn" v-show="buttonStatus">
        <button class="cancel" @click="handleCancel">取消</button>
        <div class="line"></div>
        <button class="determine" @click="handleDetermine">确定</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "sdialog",
  props: ["dialogStatus", "dialogMsg", "buttonStatus"],
  data() {
    return {};
  },
  methods: {
    handleCancel() {
      this.$emit("getDialogStatus", this.dialogStatus,"cancel");
    },
    handleDetermine() {
      this.$emit("getDialogStatus", this.dialogStatus,'determine');
    },
  },
};
</script>

<style scoped>
#all {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9;
}
#dialog {
  width: 100%;
  height: 100%;
  background: black;
  opacity: 0.5;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
}
#content {
  width: 80%;
  height: 3rem;
  background: white;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 0.1rem;
  font-size: 0.2rem;
  padding: 0.2rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
}
.info {
  width: 100%;
  flex: 1;
  font-size: 0.3rem;
  display: flex;
  justify-content: center;
  align-items: center;
}
.info p {
  color: red;
}
.btn {
  width: 100%;
  height: 0.8rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #999999;
  font-weight: 600;
}
.cancel,
.determine {
  width: 49%;
  height: 100%;
  border: none;
  background: none;
}
.cancel {
  font-weight: 600;
  font-size: 0.3rem;
}
.determine {
  font-weight: 600;
  font-size: 0.3rem;
  color: #409eff;
}
.line {
  width: 1px;
  height: 0.5rem;
  background: #999;
}
</style>
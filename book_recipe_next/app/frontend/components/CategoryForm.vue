<template>
  <div class="example-modal-window">
    <p>ボタンを押すとモーダルウィンドウが開きます</p>
    <div @click="openModal">開く</div>

    <!-- コンポーネント MyModal -->
    <Modal @close="closeModal" v-if="modal">
      <!-- default スロットコンテンツ -->
      <h2>カテゴリーを新規登録する</h2>
        <input type="text" name="category_name">
      <!-- /default -->
      <!-- footer スロットコンテンツ -->
      <template slot="footer">
        <input type="submit" value="新規登録する">
      </template>
      <!-- /footer -->
    </Modal>
  </div>
</template>

<script>
import Modal from './Modal.vue'
export default {
  components: { Modal },
  data() {
    return {
      modal: false,
    }
  },
  methods: {
    openModal() {
      this.modal = true
    },
    closeModal() {
      this.modal = false
    },
  }
}
</script>
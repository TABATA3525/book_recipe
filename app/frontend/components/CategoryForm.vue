<template>
  <div class="example-modal-window">
    <p>ボタンを押すとモーダルウィンドウが開きます</p>
    <button class="btn btn-default category-button" type="button" @click="openModal">カテゴリーを追加する</button>
    <!-- コンポーネント MyModal -->
    <Modal @close="closeModal" v-if="modal">
      <!-- default スロットコンテンツ -->
      <h2>カテゴリーを新規登録する</h2>
        <input type="text" name="category_name" v-model="categoryName">
      <!-- /default -->
      <!-- footer スロットコンテンツ -->
      <template #footer>
        <input type="submit" value="新規登録する">
        <button type="button" @click="closeModal">
          閉じる
        </button>
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
      categoryName: '',
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
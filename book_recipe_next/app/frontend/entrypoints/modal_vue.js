import { createApp } from 'vue'
import CategoryForm from '../components/CategoryForm.vue'
import { createVuetify } from 'vuetify'
import 'vuetify/styles'

const vuetify = createVuetify()

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(CategoryForm)
  app.use(vuetify)
  app.mount('#modal-form')
})
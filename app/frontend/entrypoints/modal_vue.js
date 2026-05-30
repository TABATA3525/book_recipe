import { createApp } from 'vue'
import CategoryForm from '../components/CategoryForm.vue'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import 'vuetify/styles'

const vuetify = createVuetify({
  components,
  directives,
})

// const mountModalForm = () => {
//   const app = createApp(CategoryForm)
//   const element = document.getElementById('modal-form')
//   if (!element || element.dataset.vueMounted === 'true') return

//   app.use(vuetify)
//   app.mount(element)
//   element.dataset.vueMounted = 'true'
// }

const mountModalForm = () => {
  console.log("mountModalForm called")

  const app = createApp(CategoryForm)
  const element = document.getElementById('modal-form')

  console.log(element)

  if (!element || element.dataset.vueMounted === 'true') return

  app.use(vuetify)
  app.mount(element)
  element.dataset.vueMounted = 'true'
}

document.addEventListener('DOMContentLoaded', mountModalForm)
document.addEventListener('turbo:load', mountModalForm)

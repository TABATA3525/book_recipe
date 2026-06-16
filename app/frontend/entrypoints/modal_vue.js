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

let app = null

const mountModalForm = () => {
  const element = document.getElementById('modal-form')

  if (!element || element.dataset.vueMounted === 'true') return

  app = createApp(CategoryForm)

  app.use(vuetify)
  app.mount(element)

  element.dataset.vueMounted = 'true'
}

document.addEventListener('turbo:load', mountModalForm)

document.addEventListener('turbo:before-cache', () => {
  const element = document.getElementById('modal-form')

  if (app) {
    app.unmount()
    app = null
  }

  if (element) {
    delete element.dataset.vueMounted
  }
})

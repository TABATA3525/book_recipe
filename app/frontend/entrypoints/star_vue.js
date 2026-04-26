import { createApp } from 'vue'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import 'vuetify/styles'
import '@mdi/font/css/materialdesignicons.css'
import StarRatingVue from '../components/Stars.vue'

const vuetify = createVuetify({
  components,
  directives,
  icons: {
    defaultSet: 'mdi',
    aliases,
    sets: {
      mdi,
    },
  },
})

const mountStarInput = () => {
  const element = document.getElementById('star_input')
  if (!element || element.dataset.vueMounted === 'true') return

  const app = createApp(StarRatingVue)
  app.use(vuetify)
  app.mount(element)
  element.dataset.vueMounted = 'true'
}

document.addEventListener('DOMContentLoaded', mountStarInput)
document.addEventListener('turbo:load', mountStarInput)

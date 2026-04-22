import { createApp } from 'vue'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import 'vuetify/styles'
import '@mdi/font/css/materialdesignicons.css'
import FeelingSearch from '../components/FeelingSearch.vue'

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

const mountFeelingStarsSearch = () => {
  const element = document.getElementById('feeling_stars')
  if (!element || element.dataset.vueMounted === 'true') return

  const app = createApp(FeelingSearch)
  app.use(vuetify)
  app.mount(element)
  element.dataset.vueMounted = 'true'
}

document.addEventListener('DOMContentLoaded', mountFeelingStarsSearch)
document.addEventListener('turbo:load', mountFeelingStarsSearch)

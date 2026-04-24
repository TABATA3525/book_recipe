import { createApp } from 'vue'
import axios from 'axios'
import BookList from '../components/BookList.vue'

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
}

const mountBookSearch = () => {
  const element = document.getElementById('bookForm')
  if (!element || element.dataset.vueMounted === 'true') return

  const app = createApp(BookList)
  app.config.globalProperties.$http = axios
  app.mount(element)
  element.dataset.vueMounted = 'true'
}

document.addEventListener('DOMContentLoaded', mountBookSearch)
document.addEventListener('turbo:load', mountBookSearch)

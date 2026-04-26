import { createApp } from 'vue'
import FeelingIndex from '../components/FeelingIndex.vue'

document.addEventListener('turbo:load', () => {
  const elements = document.getElementsByClassName('feeling_after');

  for (let i = 0; i < elements.length; i++) {
    createApp(FeelingIndex, {
        prop_stars: elements[i].getAttribute('data-stars'),
        prop_feeling_after_reading: elements[i].getAttribute('data-feeling-after-reading')
    }).mount(elements[i])
  }
});
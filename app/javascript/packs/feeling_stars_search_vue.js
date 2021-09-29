import Vue from 'vue';
import FeelingSearch from '../parts/feeling_search.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify); // 追加
const vuetify = new Vuetify(); // 追加

document.addEventListener('DOMContentLoaded', () => {
  console.log(5)
  const starInput = new Vue({
    vuetify,
    render: h => h(FeelingSearch)
  }).$mount()
  var element = document.getElementById('feeling_stars');
  console.log(4)
  element.append(starInput.$el)
});

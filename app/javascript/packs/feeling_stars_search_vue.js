import Vue from 'vue';
import FeelingSearch from '../parts/feeling_search.vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify); // 追加
const vuetify = new Vuetify({
  icons: {
    iconfont: 'mdi', // 追加
  },
}); // 追加

document.addEventListener('DOMContentLoaded', () => {
  const feelingStarsSearch = new Vue({
    vuetify,
    render: h => h(FeelingSearch)
  }).$mount()
  var element = document.getElementById('feeling_stars');
  element.append(feelingStarsSearch.$el)
});

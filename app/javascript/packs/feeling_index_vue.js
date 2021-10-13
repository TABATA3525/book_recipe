import Vue from 'vue';
import feelingIndex from '../parts/feeling_index.vue';
import StarRating from 'vue-star-rating';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify); // 追加
const vuetify = new Vuetify(); // 追加

Vue.component('star-rating', StarRating);

document.addEventListener('DOMContentLoaded', () => {
  const feelingStarsIndex = new Vue({
    vuetify,
    render: h => h(feelingIndex)
  }).$mount()
  var elements = document.getElementsByClassName('feeling_after');
  for(var i = 0; i < elements.length; i++){
    var $ele_clone = $(feelingStarsIndex.$el).clone();
    elements[i].append($ele_clone);
    console.log(i);
    console.log(feelingStarsIndex.$el);
  };
});

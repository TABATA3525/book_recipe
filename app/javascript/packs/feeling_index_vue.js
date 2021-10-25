import Vue from 'vue';
import FeelingIndex from '../parts/feeling_index.vue';
import StarRating from 'vue-star-rating';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify); // 追加
const vuetify = new Vuetify(); // 追加

Vue.component('star-rating', StarRating);

document.addEventListener('DOMContentLoaded', () => {
  var elements = document.getElementsByClassName('feeling_after');
  for(var i = 0; i < elements.length; i++){
    const feelingStarsIndex = new Vue({
      vuetify,
      render: h => h(FeelingIndex, 
      { props: { prop_stars: elements[i].dataset.stars,
                 prop_feeling_category_id: elements[i].dataset.feelingCategoryId,
                 prop_feeling_after_reading: elements[i].dataset.feelingAfterReading }
      })
    }).$mount()
    elements[i].append(feelingStarsIndex.$el);
  };
});

import Vue from 'vue'
import StarRating from 'vue-star-rating'
import StarRatingVue from '../parts/stars.vue'

console.log(11)

Vue.component('star-rating', StarRating);

document.addEventListener('DOMContentLoaded', () => {
  console.log(5)
  const starInput = new Vue({
    render: h => h(StarRatingVue)
  }).$mount()
  var element = document.getElementById('star_input');
  console.log(4)
  element.append(starInput.$el)
})

// document.addEventListener('DOMContentLoaded', () => {
//   const starInput = new Vue({
//     el: '#star_input',
//     data: {
//       rating: 0
//     }
//   }).$mount()
//   var element = document.getElementById('star_input');
//   element.append(starInput.$el)
// })


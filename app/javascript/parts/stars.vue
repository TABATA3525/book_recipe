<template>
  <div>
    <div class="star-container" v-for="(feeling, index) in feelingCategories" :key="index" >
      <input type="hidden" :ref="'hidden_stars_'+index" name="user_book[user_feeling_category_star][]" :id="'user_book_user_feeling_category_stars_'+index">
      <select v-html="feeling.innerHTML" name="user_book[feeling_category_id][]">
      </select>
      <star-rating @rating-selected ="setRating" v-model="star.rating[index]"></star-rating>
      <v-icon @click="addFeelingCategory" class="plus" large>mdi-plus-circle</v-icon>
    </div>
  </div>
</template>

<script>
export default {
  name: 'stars',
  data: function () {
    return {
      star: {
        rating: []
      },
      feelingCategories: []
    }
  },
  async mounted() {
    let default_star_elements = document.getElementsByName('user_feeling_categories[stars]');
    let feeling_category_element = document.getElementById('user_book_feeling_category_ids');
    feeling_category_element.hidden = true;
    
    for(let index=0; index<default_star_elements.length; index++) 
    {
      this.feelingCategories.push({
        innerHTML: feeling_category_element.innerHTML
      })
    };
    this.setRatingInit();
    this.setAfterReadingInit();
  },
  methods: {
    setRating: function(){
      let refs = this.$refs
      this.star.rating.forEach(function(element,index){
        let property = "hidden_stars_"+index;
        refs[property][0].value = element
      });
    },
    setRatingInit: function(){
      let default_star_elements = document.getElementsByName('user_feeling_categories[stars]');
      let that = this
      default_star_elements.forEach(function(element,index){
        that.star.rating[index] = Number(element.value);
      });
    },
    setAfterReadingInit: function(){
      let default_after_reading_elements = document.getElementsByClassName('user_feeling_categories[feeling_after_readings]');
      let that = this;
      Array.prototype.forEach.call(default_after_reading_elements, function(element, index) {
        that.feelingCategories[index].innerHTML = element.innerHTML;
      });
    },
    addFeelingCategory () {
      let feeling_category_element = document.getElementById('user_book_feeling_category_ids');
      this.feelingCategories.push({
        innerHTML: feeling_category_element.innerHTML
      })
    }
  },
}
</script>

<style>
  .star-container {
    display: flex;
  }
  
  .plus {
    margin-left: 20px;
  }
</style>

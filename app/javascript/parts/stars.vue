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
      feelingCategories: [
        {
          innerHTML: ""
        }
      ],
    }
  },
  async mounted() {
    let star_elements = document.getElementsByName('user_feeling_categories[stars]');
    let feeling_category_element = document.getElementById('user_book_feeling_category_ids');
    feeling_category_element.hidden = true;
    
    for(let index=0; index < star_elements.length; index++) 
    {
      var star_value_element = document.getElementById('star_value'+ index);
      this.feelingCategories.push({
        innerHTML: feeling_category_element.innerHTML
      })
    };
  },
  methods: {
    setRating: function(rating){
      // this.$refs.hidden_stars_.value = this.rating
      let refs = this.$refs
      this.star.rating.forEach(function(element,index){
        let property = "hidden_stars_"+index;
        refs[property][0].value = element
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

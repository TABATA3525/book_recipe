<template>
  <div>
    <div class="star-container" v-for="(feeling, index) in feelingCategories" :key="index" >
      <input type="hidden" :ref="'hidden_stars_'+index" name="user_book[user_feeling_category_stars]" :id="'user_book_user_feeling_category_stars_'+index">
      <select v-html="feeling.innerHTML" name="user_book[feeling_category_ids]">
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
    var star_value_element = document.getElementById('star_value');
    var feeling_category_element = document.getElementById('user_book_feeling_category_ids');
    this.rating = parseInt(star_value_element.value);
    // this.$refs.hidden_stars.value = this.rating;
    feeling_category_element.hidden = true;
    // console.log(this.feelingCategoryRefs[0]);
    // this.feelingCategoryRefs[0].innerHTML = feeling_category_element.innerHTML;
    // var feeling_category_select_element = document.getElementById('user_book_feeling_category_ids_0');
    var feeling_category_select_element = this.$refs.user_book_feeling_category_ids_0;
    console.log(this.$refs);
    console.log(feeling_category_select_element);
    console.log(feeling_category_element);
    this.feelingCategories[0].innerHTML = feeling_category_element.innerHTML;
  },
  methods: {
    setRating: function(rating){
      // this.$refs.hidden_stars_.value = this.rating
      let refs = this.$refs
      this.star.rating.forEach(function(element,index){
        let property = "hidden_stars_"+index;
        console.log(refs);
        console.log(refs.hidden_stars_0);
        console.log(property);
        console.log(refs[property][0]);
        refs[property][0].value = element
        console.log(element);
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

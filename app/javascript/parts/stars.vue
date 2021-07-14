<template>
  <div>
    <input type="hidden" ref="hidden_stars" name="user_book[user_feeling_category_stars]" id="user_book_user_feeling_category_stars">
    <div class="star-container" v-for="(feeling, index) in feelingCategories" :key="index" >
      <select name="user_book[feeling_category_ids]" ref="user_book_feeling_category">
        {{ feeling.innerHTML }}
      </select>
      <star-rating @rating-selected ="setRating" v-model="rating"></star-rating>
      <v-icon @click="addFeelingCategory" class="plus" large>mdi-plus-circle</v-icon>
    </div>
  </div>
</template>

<script>
export default {
  name: 'stars',
  data: function () {
    return {
      rating: 0,
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
    this.$refs.hidden_stars.value = this.rating;
    feeling_category_element.hidden = true;
    // console.log(this.feelingCategoryRefs[0]);
    // this.feelingCategoryRefs[0].innerHTML = feeling_category_element.innerHTML;
    // var feeling_category_select_element = document.getElementById('user_book_feeling_category_ids_0');
    var feeling_category_select_element = this.$refs.user_book_feeling_category_ids_0
    console.log(this.$refs);
    console.log(feeling_category_select_element);
    console.log(feeling_category_element);
    this.feelingCategories[0].innerHTML = feeling_category_element.innerHTML;
  },
  methods: {
    setRating: function(rating){
      this.rating = rating;
      this.$refs.hidden_stars.value = this.rating
      console.log(3)
    },
    addFeelingCategory () {
      let feeling_category_element = document.getElementById('user_book_feeling_category_ids');
      this.feelingCategories.push({
        innerHTML: feeling_category_element.innerHTML
      })
      let refs = this.$refs;
      this.feelingCategories.forEach(function(element, index){
        console.log(refs.user_book_feeling_category[index]);
        console.log(index);
        refs.user_book_feeling_category[index].innerHTML = feeling_category_element.innerHTML;
      });
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

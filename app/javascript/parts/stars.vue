<template>
  <div>
    <input type="hidden" ref="hidden_stars" name="user_book[user_feeling_category_stars]" id="user_book_user_feeling_category_stars">
    <star-rating @rating-selected ="setRating" v-model="rating"></star-rating>
  </div>
</template>

<script>
export default {
  name: 'stars',
  data: function () {
    return {
      rating: 0,
    }
  },
  async mounted() {
    var element = document.getElementById('star_value');
    this.rating = parseInt(element.value);
  },
  methods: {
    setRating: function(rating){
      this.rating = rating;
      this.$refs.hidden_stars.value = this.rating
      console.log(3)
    }
  }
}
</script>



<template>
  <div>
    <input type="hidden" ref="hidden_stars" name="user_book[user_feeling_category_stars]" id="user_book_user_feeling_category_stars">
    <div class="star-container" v-for="(feeling, index) in feelingCategories" :key="index">
      <select name="user_book[feeling_category_ids]" id="user_book_feeling_category_ids"><option value="">選択して下さい</option>
        <option value="100000">優しい</option>
        <option value="100001">辛い</option>
        <option value="100002">分かりやすい</option>
        <option value="100003">ハラハラ</option>
        <option value="100004">怖い</option>
        <option value="100006"></option>
        <option value="100007">えらい</option>
        <option value="100008">すごい</option>
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
        {}
      ]
    }
  },
  async mounted() {
    var element = document.getElementById('star_value');
    this.rating = parseInt(element.value);
    this.$refs.hidden_stars.value = this.rating
  },
  methods: {
    setRating: function(rating){
      this.rating = rating;
      this.$refs.hidden_stars.value = this.rating
      console.log(3)
    },
    addFeelingCategory () {
      this.feelingCategories.push({
      })
    },
  }
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

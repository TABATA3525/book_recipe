<template>
  <div class="star-container">
    {{feelingAfterReading}}
    <star-rating :read-only="true" :rating = "stars" :star-size=40 :padding=10></star-rating>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'simple',
  props: {
      prop_stars: String,
      prop_feeling_category_id: String,
      prop_feeling_after_reading: String
    },
  data: function () {
    return {
      // 星の数のデータ
      stars: 0,
      feelingCategoryId: [],
      feelingCategories: [],
      feelingAfterReading: ''
      }
  },
  mounted() {
    axios
      //GETリクエストでRailsで作成したjsonを取得する
      .get('/api/v1/feeling_categories.json')
      //response.data は RailsのUser.select(:id, :name, :email)
      //これをdata()で定義したusersに代入する
      .then(response => (this.feelingCategories = response.data))

    this.stars = Number(this.prop_stars)
    this.feelingCategoryId = Number(this.prop_feeling_category_id);
    this.feelingAfterReading = this.prop_feeling_after_reading;
  }
}
</script>

<style>
  .star-container {
    display: flex;
  }
</style>

<template>
  <div>
    <div v-for="(feeling, index) in feelingCategoryIds" :key="index" >
      <select id="feeling_stars" name="feeling_category_ids[]">
        <option value="">読後感を選択して下さい</option>
        <option v-for="feelingCategory in feelingCategories" :key="feelingCategory.id" :value="feelingCategory.id">
          {{feelingCategory.feeling_after_reading}}
        </option>
      </select>
      <select name="stars[]" id="stars[]">
        <option value="">選択してください</option>
        <option value="stars_5">☆５のみ</option>
        <option value="stars_4">☆４のみ</option>
        <option value="stars_3">☆３のみ</option>
        <option value="stars_2">☆２のみ</option>
        <option value="stars_1">☆１のみ</option>
        <option value="stars_high">高評価（☆３以上）</option>
        <option value="stars_low">低評価（☆２以下）</option>
      </select>
      <span><v-icon @click="addFeelingCategory" class="plus" large>mdi-plus-circle</v-icon></span>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'feeling_stars',
  data: function () {
    return {
      star: {
        rating: []
      },
      // feeling_categories_controllerで取得したjsonデータ
      feelingCategories: [],
      // railsで取得したデフォルトのデータ
      feelingCategoryIds: []
    }
  },
  async mounted() {
    axios
      //GETリクエストでRailsで作成したjsonを取得する
      .get('/api/v1/feeling_categories.json')
      //response.data は RailsのUser.select(:id, :name, :email)
      //これをdata()で定義したusersに代入する
      .then(response => (this.feelingCategories = response.data))

    let default_star_elements = document.getElementsByName('dummy_ids[]');
    let feeling_category_element = document.getElementById('feeling_search');
    feeling_category_element.hidden = true;

    for(let index=0; index<default_star_elements.length; index++) 
    {
      this.feelingCategoryIds.push({ })
    };    
  },
  methods: {
    addFeelingCategory () {
      this.feelingCategoryIds.push({ })
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

<template>
  <div>
    <div v-for="(feeling, index) in feelingCategoryIds" :key="index" >
      <select v-model="feelingCategoryIds[index]" name="feeling_category_ids[]">
        <option value="">読後感</option>
        <option v-for="feelingCategory in feelingCategories" :key="feelingCategory.id" :value="feelingCategory.id">
          {{feelingCategory.feeling_after_reading}}
        </option>
      </select>
      が
      <select v-model="stars[index]" name="stars[]">
        <option value="">☆の数を選択してください</option>
        <option value="stars_5">☆５のみ</option>
        <option value="stars_4">☆４のみ</option>
        <option value="stars_3">☆３のみ</option>
        <option value="stars_2">☆２のみ</option>
        <option value="stars_1">☆１のみ</option>
        <option value="stars_high">高評価（☆３以上）</option>
        <option value="stars_low">低評価（☆２以下）</option>
      </select>
      <span><v-icon @click="addFeelingCategory" class="plus" large color="green accent-3">mdi-plus-circle</v-icon></span>
      <v-icon v-if="index !== 0" @click="deleteFeelingCategory(index)" class="minus" large>mdi-minus-circle</v-icon>

    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'feeling_stars',
  data: function () {
    return {
      // feeling_categories_controllerで取得した登録されている読後感全てのjsonデータ
      feelingCategories: [],
      // railsで選択されたデータ
      feelingCategoryIds: [],
      stars: []
    }
  },
  async mounted() {
    axios
      //GETリクエストでRailsで作成したjsonを取得する
      .get('/api/v1/feeling_categories.json')
      //response.data は RailsのUser.select(:id, :name, :email)
      //これをdata()で定義したusersに代入する
      .then(response => (this.feelingCategories = response.data))

    let default_feeling_elements = document.getElementsByName('dummy_ids[]');
    let default_star_elements = document.getElementsByName('dummy_stars[]');
    let feeling_category_element = document.getElementById('feeling_search');
    feeling_category_element.hidden = true;

    // 取得した読後感と星の数値をvueに渡している
    for(let index=0; index<default_feeling_elements.length; index++) 
    {
      this.feelingCategoryIds.push(default_feeling_elements[index].value)
      this.stars.push(default_star_elements[index].value)
    };    
  },
  methods: {
    addFeelingCategory () {
      this.feelingCategoryIds.push({ })
    },
    deleteFeelingCategory(index) {
      // 指定されたindexの要素を1つ削除します。
      this.feelingCategoryIds.splice(index, 1)
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

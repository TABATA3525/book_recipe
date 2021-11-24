<template>
  <div>
    <div class="star-container" v-for="(feeling, index) in feelingCategories" :key="index" >
      <!-- setRatingから送られてきた星の数のデータを受け取って、railsに送信する体裁を整えている -->
      <input type="hidden" :ref="'hidden_stars_'+index" name="user_book[user_feeling_category_star][]" :id="'user_book_user_feeling_category_stars_'+index">
      <select v-html="feeling.innerHTML" required name="user_book[feeling_category_id][]">
      </select>
      <star-rating @rating-selected ="setRating" v-model="star.rating[index]" :show-rating="false" :star-size=40 :padding=10></star-rating>
      <v-btn 
        class="mx-2"
        fab
        dark
        small
        color="primary"
      >
        <v-icon dark @click="addFeelingCategory" class="plus">
          mdi-plus
        </v-icon>
      </v-btn>
      <!-- feelingが複数表示されている時のみ、消去ボタンを表示 -->
      <v-icon v-if="index !== 0" @click="deleteFeelingCategory(index)" class="minus" size=30>mdi-minus-circle</v-icon>
    </div>
  </div>
</template>

<script>
export default {
  name: 'stars',
  data: function () {
    return {
      // 星の数のデータ
      star: {
        rating: []
      },
      // 読後感のフォーマット情報とデータ
      feelingCategories: []
    }
  },
  async mounted() {
    // 登録されている星の数のデータを取得
    let default_star_elements = document.getElementsByName('user_feeling_categories[stars]');
    // railsで作った読後感のフォーマットを取得
    let feeling_category_element = document.getElementById('user_book_feeling_category_ids');
    feeling_category_element.hidden = true;
    console.log(default_star_elements)
    // 登録されている星データのセット数分、読後感のフォーマットHTMLをそのままvueに入れている。
    for(let index=0; index<default_star_elements.length; index++) 
    {
      this.feelingCategories.push({
        innerHTML: feeling_category_element.innerHTML
      })
    };
    this.setRatingInit();
    this.setAfterReadingInit();
    console.log(this.feelingCategories);
  },
  updated() {
    this.setRating()
  },
  methods: {
    setRating: function(){
      let refs = this.$refs
      // 星の数が変更・クリックされた時に、dataのstar.ratingに入ってきた数値を、ref対応しているinputに渡している。
      this.star.rating.forEach(function(element,index){
        let property = "hidden_stars_"+index;
        console.log(property)
        refs[property][0].value = element
      });
    },
    setRatingInit: function(){
      // 既に登録されている星の数のデータを渡している。
      let default_star_elements = document.getElementsByName('user_feeling_categories[stars]');
      let that = this
      default_star_elements.forEach(function(element,index){
        that.star.rating[index] = Number(element.value);
      });
    },
    setAfterReadingInit: function(){
      // 既に登録されている読後感のフォーマットとデータを渡している。
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
    },
    deleteFeelingCategory(index) {
      // 星をクリックすると、setRatingが走り、星の数のデータが変更されて渡される。変更された星の数のデータも削除する。
      this.star.rating.splice(index, 1);
      // 指定されたindexの要素を1つ削除します。
      this.feelingCategories.splice(index, 1)
    }
  },
}
</script>

<style>
  .star-container {
    display: flex;
  }
  
  @media screen and (max-width:480px) { 
    .vue-star-rating-star {
      height: 30px;
      width: 30px;
    }
  }

</style>

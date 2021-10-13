<template>
  <div>
    <div class="feeling-index-container" v-for="(feeling, index) in feelingCategories" :key="index" >
      <star-rating @rating-selected ="setRating" v-model="star.rating[index]"></star-rating>
    </div>
  </div>
</template>

<script>
export default {
  name: 'feelingStars',
  data: function () {
    return {
      // 星の数のデータ
      star: {
        rating: []
      },
      feelingCategories: []
    }
  },
  async mounted() {
    // 登録されている星
    let default_star_elements = document.getElementsByClassName("feeling_stars[]");
    // 読後感
    let feeling_category_elements = document.getElementsByClassName('feeling_reading[]');
    feeling_category_elements.hidden = true;

    console.log(feeling_category_elements.textContent);
    for(let index=0; index<default_star_elements.length; index++) 
    {
      this.feelingCategories.push({
        innerHTML: feeling_category_elements.innerHTML
      })
    };
    console.log(this.feelingCategories);
    this.setRatingInit();
    this.setAfterReadingInit();
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
  
  .plus {
    margin-left: 20px;
  }
</style>

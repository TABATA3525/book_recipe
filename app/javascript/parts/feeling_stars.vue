<template>
  <div>
    <div v-for="(feeling, index) in feelingCategoryIds" :key="index" >
      <div class="feeling_collect" v-html="feeling.innerHTML">
      </div>
      <v-icon @click="addFeelingCategory" class="plus" large>mdi-plus-circle</v-icon>
    </div>
  </div>
</template>

<script>
export default {
  name: 'feeling_stars',
  data: function () {
    return {
      star: {
        rating: []
      },
      feelingCategoryIds: []
    }
  },
  async mounted() {
    let default_star_elements = document.getElementsByName('dummy_ids[]');
    let feeling_category_element = document.getElementById('feeling_search');
    feeling_category_element.hidden = true;

    for(let index=0; index<default_star_elements.length; index++) 
    {
      console.log(feeling_category_element.innerHTML);
      this.feelingCategoryIds.push({
        innerHTML: feeling_category_element.innerHTML
      })
    };
    
    // 指定したid属性のHTML要素を取得
    var feeling_collect = document.getElementsByClassName("feeling_collect");


    // パターン1：子要素の数を取得
    var child_nodes_count = feeling_collect.childElementCount;
    console.log(feeling_collect); 
    console.log(child_nodes_count); // 5


    // パターン2：全ての子要素を配列形式のプロパティで参照
    for(var i=0; i<child_nodes_count; i++) {
      feeling_collect.children[i].attr("name", "feeling_category_ids[]");
      console.log(feeling_collect.children[i].textContent);
    }
    // this.setRatingInit();
    // this.setAfterReadingInit();
  },
  updated() {
    this.setRating()
  },
  methods: {
    setRating: function(){
      let refs = this.$refs
      this.star.rating.forEach(function(element,index){
        let property = "hidden_stars_"+index;
        refs[property][0].value = element
      });
    },
    setRatingInit: function(){
      let default_star_elements = document.getElementsByName('user_feeling_categories[stars]');
      let that = this
      default_star_elements.forEach(function(element,index){
        that.star.rating[index] = Number(element.value);
      });
    },
    setAfterReadingInit: function(){
      let default_after_reading_elements = document.getElementsByClassName('user_feeling_categories[feeling_after_readings]');
      let that = this;
      Array.prototype.forEach.call(default_after_reading_elements, function(element, index) {
        that.feelingCategories[index].innerHTML = element.innerHTML;
      });
    },
    addFeelingCategory () {
      let feeling_category_element = document.getElementById('feeling_search');
      this.feelingCategoryIds.push({
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

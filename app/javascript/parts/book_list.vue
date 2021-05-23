<template>
  <div>
    <input v-model="search" class='input bg-white mb16' type='search' @input="changeBooks" />
      
    <div>
      <h2 class='mb8'>検索結果</h2>
      <div id='$results' v-for="result in results">
        <a class='f border bg-white mb8' :href="result.link" target='_blank'>
          {{ result.title }}
        </a>
        <input type='hidden' :value="result.title" name="title">
        <img class='w100 object-fit-contain bg-gray' :src="result.image">
        <div v-for="author in result.authors">
          {{ author }}
        </div>
        <input type="hidden" :value="result.authors" name="author">
        <button type="button" @click="createBook">登録する</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data: function () {
    return {
      results: [],
      search: '',
    }
  },
  async mounted() {
    console.log(123)
  },
  methods: {
    searchBooks: async function(query) {
      var endpoint = 'https://www.googleapis.com/books/v1';
  
      // 検索 API を叩く
      var res = await fetch(`${endpoint}/volumes?q=${query}`);
      // JSON に変換
      var data = await res.json();
      
      // 必要なものだけ抜き出してわかりやすいフォーマットに変更する
      var items = data.items.map(item => {
        var vi = item.volumeInfo;
        return {
          title: vi.title,
          authors: vi.authors,
          description: vi.description,
          link: vi.infoLink,
          image: vi.imageLinks ? vi.imageLinks.smallThumbnail : '',
        }; 
      });
      
      return items;
    },
    changeBooks: async function(){
      var value = this.search;
      if (value == ''){
        this.results = ''
        return
      }
      var items = await this.searchBooks(value);
      console.log(items)
      
      this.results = items;  
    },
    createBook: function(){
      this.$http
        .post('/user_books', {
          title: '鬼滅',
          author: '',
          image: ''
        })
    }
  }
}
</script>


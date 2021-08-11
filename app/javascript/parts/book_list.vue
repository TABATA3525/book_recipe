<template>
  <div>
    <input v-model="search" class='input bg-white mb16' type='search' @input="changeBooks" />
      
    <div>
      <h2 class='mb8'>検索結果</h2>
      <div id='$results' v-for="(result, index) in results">
        <a class='f border bg-white mb8' :href="result.link" target='_blank'>
          {{ result.title }}
        </a>
        <input :id="'title' + index" type='hidden' :value="result.title" name="title">
        <img :id="'image'+ index" class='w100 object-fit-contain bg-gray' :src="result.image">
        <div v-for="author in result.authors">
          {{ author }}
        </div>
        <input :id="'author' + index" type="hidden" :value="result.authors" name="author">
        <button type="button" @click="createBook(index)">登録する</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'BookList',
  data: function () {
    return {
      results: [],
      search: '',
    }
  },
  async mounted() {
    console.log(1)
  },
  methods: {
    searchBooks: async function(query) {
      var apiUrl = 'https://www.googleapis.com/books/v1';
  
      // 検索 API を叩く
      var res = await fetch(`${apiUrl}/volumes?q=${query}`);
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
      console.log("searchBooks");
      return items;
    },
    changeBooks: async function(){
      var value = this.search;
      if (value == ''){
        this.results = ''
        return
      }
      console.log("changeBooks");
      var items = await this.searchBooks(value);
      console.log(items);
      this.results = items;  
    },
    createBook: function(index){
      const $title = document.getElementById('title'+index);
      const $author = document.getElementById('author'+index);
      const $image = document.getElementById('image'+index);
      const urlString = $image.src.replace('http://','https://');
      const data = new FormData();
      console.log(data);
      data.append("title", $title.value);
      data.append("author", $author.value);
      data.append("user_book_image", urlString);
      console.log(data.get('title'));
      const headers = { "content-type": "multipart/form-data" };
      this.$http
      .post(
        '/user_books',
        data,
        { headers },
      ).then(response => {
        window.location.href='/user_books'
      })
    }
  }
}
</script>


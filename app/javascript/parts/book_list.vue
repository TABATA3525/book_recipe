<template>
  <div class="user-book-new-wrapper">
    <div class="container">
      <div class="row">
        <div class="user-book-new-reserve col-md-6 col-md-offset-3">
          <div class="new-search-form">
            <h2>本の新規登録</h2>
            <input v-model="search" class='input bg-white mb16' type='search' @input="changeBooks" placeholder="本のタイトル・著者名を入力してください">
          </div>
        </div>
      </div>
    </div>
    <div class="container">  
      <div class="row">
        <div class="new-search-results">
          <h2 class='mb8'>検索結果</h2>
          <div id="error_message"></div>
          <div id='$results' v-for="(result, index) in results">
            <div class="col-md-9 col-md-offset-3">
              <div class="user-book-result-single">
                <img :id="'image'+ index" class='w100 object-fit-contain bg-gray' :src="result.image">
                <div class="user-book-result-show">
                  <h3>
                    <a class='f border bg-white mb8' :href="result.link" target='_blank'>
                      {{ result.title }}
                    </a>
                  </h3>
                  <input :id="'title' + index" type='hidden' :value="result.title" name="title">
                  <p>著者</p>
                  <p v-for="author in result.authors">
                    {{ author }}
                  </p>
                  <input :id="'author' + index" type="hidden" :value="result.authors" name="author">
                </div>
                <div class="submit">
                  <button type="button" @click="createBook(index)" class="btn btn-default edit">新規登録</button>
                </div>
              </div>
            </div>
          </div> 
        </div>
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
      // data内のsearchとresults
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
      const that = this
      this.$http
      .post(
        '/user_books',
        data,
        { headers },
      ).then(response => {
        window.location.href='/user_books'
      }).catch(function(error) {
        // window.location.href='/user_books'
        that.scroll_to_top();
        document.getElementById("error_message").innerHTML= error.response.data.message
      });
    },
    scroll_to_top: function(){
      window.scroll({top: 0, behavior: 'smooth'});
    }
  }
}
</script>


<template>
  <div class="user-book-new-wrapper">
    <div class="container">
      <div class="row">
        <div class="user-book-new-reserve col-md-6 col-md-offset-3">
          <div class="new-search-form">
            <h2>本の新規登録</h2>
            <div id="inputWrapper">
              <input v-model="search" id="input" class='input bg-white mb16' type='search' @input="changeBooks" placeholder="本のタイトル・著者名を入力してください">
              <div id="icon">
                <div id="container">
                  <div id="image"></div>
                </div>
              </div>
              
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container">  
      <div class="row">
        <div class="new-search-results">
          <h2 class='mb8'>検索結果</h2>
          <div id="error_message">{{ errorMessage }}</div>
          <div id='$results' v-for="(result, index) in results" :key="index">
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
                  <p v-for="(author, index) in result.authors" :key="index">
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
      errorMessage: '',
    }
  },
  methods: {
    searchBooks: async function(query) {
      var apiUrl = 'https://www.googleapis.com/books/v1'
      var res = await fetch(`${apiUrl}/volumes?q=${encodeURIComponent(query)}`)
      var data = await res.json()

      if (!res.ok) {
        throw new Error(data.error?.message || 'Google Books APIから検索結果を取得できませんでした。')
      }

      if (!Array.isArray(data.items)) {
        return []
      }
      
      // 必要なものだけ抜き出してわかりやすいフォーマットに変更する
      var items = data.items.map(item => {
        var vi = item.volumeInfo || {}
        return {
          title: vi.title,
          authors: vi.authors || [],
          description: vi.description,
          link: vi.infoLink,
          image: vi.imageLinks ? vi.imageLinks.smallThumbnail : '',
        }
      })
      return items
    },
    changeBooks: async function(){
      // data内のsearchとresults
      var value = this.search.trim()
      if (value == ''){
        this.results = []
        this.errorMessage = ''
        return
      }

      try {
        this.errorMessage = ''
        var items = await this.searchBooks(value)
        this.results = items
        if (items.length === 0) {
          this.errorMessage = '検索結果が見つかりませんでした。'
        }
      } catch (error) {
        this.results = []
        this.errorMessage = error.message || '検索に失敗しました。時間をおいて再度お試しください。'
      }
    },
    createBook: function(index){
      const $title = document.getElementById('title'+index);
      const $author = document.getElementById('author'+index);
      const $image = document.getElementById('image'+index);
      const urlString = $image.src.replace('http://','https://');
      const data = new FormData();
      data.append("title", $title.value);
      data.append("author", $author.value);
      data.append("user_book_image", urlString);
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

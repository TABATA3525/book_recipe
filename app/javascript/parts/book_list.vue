<template>
  <div>
    <input v-model="search" class='input bg-white mb16' type='search' @input="changeBooks" />
      
    <div>
      <h2 class='mb8'>検索結果</h2>
      <div id='$results' v-html="results">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data: function () {
    return {
      results: '',
      search: ''
    }
  },
  async mounted() {
    
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
      console.log(value)
      
      // html に変換して表示用 DOM に代入
      var texts = items.map(item => {
        return `
        <a class='f border bg-white mb8' href='${item.link}', target='_blank'>
          <img class='w100 object-fit-contain bg-gray' src='${item.image}' />
          <div class='p16'>
            <h3 class='mb8'>${item.title}</h3>
            <p class='line-clamp-2'>${item.description}</p>
          </div>
          <input type="submit" value="登録する">
        </div>`;
      });
      this.results = texts.join('');
        
    }
  }
}
</script>


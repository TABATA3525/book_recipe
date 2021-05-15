<template>
  <div>
    <input class='input bg-white mb16' type='search' id='$q' />
      
    <div>
      <h2 class='mb8'>検索結果</h2>
      <div id='$results' v-model="results"></div>
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
      results: ''
    }
  },
  async mounted() {
    var value = '鬼滅';
    var items = await this.searchBooks(value);
    console.log(items)
    
    // html に変換して表示用 DOM に代入
    var texts = items.map(item => {
      return `
      <a class='f border bg-white mb8' href='${item.link}', target='_blank'>
        <img class='w100 object-fit-contain bg-gray' src='${item.image}' />
        <div class='p16'>
          <h3 class='mb8'>${item.title}</h3>
          <p class='line-clamp-2'>${item.description}</p>
        </div>
      </div>`;
    });
    this.results = texts.join('');
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
    }
  }
}
</script>


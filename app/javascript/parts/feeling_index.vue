<template>
  <div class="star-container">
    <table class="single-feeling">
      <tr>
        <td>{{feelingAfterReading}}</td>
        <td><star-rating :read-only="true" :rating = "stars" :star-size=40 :padding=10></star-rating></td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: 'simple',
  props: {
      prop_stars: String,
      prop_feeling_after_reading: String
    },
  data: function () {
    return {
      // 星の数のデータ
      stars: 0,
      feelingAfterReading: ''
      }
  },
  mounted() {
    this.stars = Number(this.prop_stars)
    this.feelingAfterReading = this.prop_feeling_after_reading;
  }
}
</script>

<style>
  .star-container {
    display: flex;
    margin-top: 10px;
  }

  .single-feeling {
    margin-top: 5px;
    margin-right: 10px;
  }

</style>

<template>
  <div class="star-container">
    <table class="single-feeling">
      <tr>
        <td>{{ feelingAfterReading }}</td>
        <td>
          <star-rating
            v-model="stars"
            :disable-click="true"
            :star-size="40"
            :padding="10"
          />
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import StarRating from 'vue3-star-ratings'

export default {
  name: 'FeelingIndex',

  components: {
    StarRating
  },

  props: {
    prop_stars: String,
    prop_feeling_after_reading: String
  },

  data() {
    return {
      stars: 0,
      feelingAfterReading: ''
    }
  },

  mounted() {
    this.stars = Number(this.prop_stars)
    this.feelingAfterReading = this.prop_feeling_after_reading
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
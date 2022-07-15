<template>
  <div class="pwgen" :style="style">
    <h1>{{ pwd }}</h1>
  </div>
</template>

<script>
import axios from 'axios'

function randomIntFromInterval(min, max) { // min and max included 
  return Math.floor(Math.random() * (max - min + 1) + min)
}

export default {
  name: 'PwGen',
  props: {
    length: Number,
    count: Number,
    fontsize: Number,
    startGradColor: {
      type: String,
      default: '#f3ec78'
    },
    endGradColor: {
      type: String,
      default: '#af4261'
    }
  },
  data() {
    return {
      pwd: '',
      word1: '',
      word2: '',
      symbol: '',
    }
  },
  methods: {
    generate() {
      let symbol_list = "!@#$%^&*()_+"
      let w_length = (this.length - 4) / 2
      let rnd_number = randomIntFromInterval(1000, 9999).toString()
      let rnd_symbol = symbol_list[randomIntFromInterval(0, symbol_list.length - 1)]
      axios.get("https://random-word-api.herokuapp.com/word?number=10&length=" + w_length).then(
        response => {
          let words = response.data
          this.word1 = words[randomIntFromInterval(0, words.length - 1)]
          this.word2 = words[randomIntFromInterval(0, words.length - 1)]
          if (this.word1 === this.word2) {
            this.word2 = words[randomIntFromInterval(0, words.length - 1)]
          }
          this.pwd = this.word1 + rnd_number + rnd_symbol + this.word2
          if (this.pwd.length > this.length) {
            rnd_number = rnd_number.substring(0, rnd_number.length - 1)
            this.pwd = this.word1 + rnd_number + rnd_symbol + this.word2
          }
        }
      )
    }
  },
  mounted() {
    this.generate()
  },
  computed: {
    style() {
      return {
        "--font-size": this.fontsize + "px",
        "--start-grad-color": this.startGradColor,
        "--end-grad-color": this.endGradColor,
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #D4ECDD;
}

.pwgen {
  background-clip: text;
  background-image: linear-gradient(45deg, var(--start-grad-color), var(--end-grad-color));
  background-image: conic-gradient(var(--start-grad-color), var(--end-grad-color));
  /* background-color: #112031; */
  background-size: cover;
  -webkit-background-clip: text;
  -moz-background-clip: text;
  -webkit-text-fill-color: transparent;
  -moz-text-fill-color: transparent;
  /* color: #D4ECDD; */
  color: transparent;
  font-family: 'Courier Prime', monospace;
  font-weight: 300;
  /* font-size: 80px; */
  font-size: var(--font-size);
  /* letter-spacing: 1px; */
  margin: 0;
  padding: 0;
  perspective: 1000px;
}
</style>

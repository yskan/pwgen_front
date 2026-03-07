<template>
  <div class="pwgen" :style="style" @click="copyToClipboard">
    <h1>{{ pwd }}</h1>
    <span class="tooltip" :class="{ visible: showTooltip }">Copied!</span>
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
      showTooltip: false,
    }
  },
  methods: {
    copyToClipboard() {
      navigator.clipboard.writeText(this.pwd).then(() => {
        this.showTooltip = true
        setTimeout(() => { this.showTooltip = false }, 1200)
      })
    },
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
  position: relative;
  cursor: pointer;
  background-clip: text;
  background-image: linear-gradient(45deg, var(--start-grad-color), var(--end-grad-color));
  background-image: conic-gradient(var(--start-grad-color), var(--end-grad-color));
  background-size: cover;
  -webkit-background-clip: text;
  -moz-background-clip: text;
  -webkit-text-fill-color: transparent;
  -moz-text-fill-color: transparent;
  color: transparent;
  font-family: 'Courier Prime', monospace;
  font-weight: 300;
  font-size: var(--font-size);
  margin: 0;
  padding: 0 1rem;
  perspective: 1000px;
  word-break: break-all;
  overflow-wrap: break-word;
  max-width: 100%;
  box-sizing: border-box;
}

.pwgen h1 {
  margin: 0.25em 0;
  font-size: inherit;
}

.tooltip {
  position: absolute;
  bottom: -1.6em;
  left: 50%;
  transform: translateX(-50%);
  background: #345B63;
  color: #D4ECDD;
  font-size: 14px;
  padding: 4px 12px;
  border-radius: 6px;
  white-space: nowrap;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.25s ease;
  -webkit-text-fill-color: #D4ECDD;
  -moz-text-fill-color: #D4ECDD;
}

.tooltip.visible {
  opacity: 1;
}

@media (max-width: 768px) {
  .pwgen {
    font-size: clamp(16px, 5vw, var(--font-size));
  }
}

@media (max-width: 480px) {
  .pwgen {
    font-size: clamp(14px, 4.5vw, var(--font-size));
  }
}
</style>

<template>
  <div class="pwgen" :style="style" @click="copyToClipboard">
    <h1>{{ pwd }}</h1>
    <span class="tooltip" :class="{ visible: showTooltip }">Copied!</span>
  </div>
</template>

<script>
import axios from 'axios'
import effWordlist from '../effWordlist'

function randomIntFromInterval(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min)
}

export default {
  name: 'PwGen',
  props: {
    length: Number,
    count: Number,
    fontsize: Number,
    useWordlist: {
      type: Boolean,
      default: true
    },
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
  watch: {
    useWordlist() {
      this.generate()
    }
  },
  methods: {
    copyToClipboard() {
      navigator.clipboard.writeText(this.pwd).then(() => {
        this.showTooltip = true
        setTimeout(() => { this.showTooltip = false }, 1200)
      })
    },
    generateFromWordlist() {
      const wordlist = effWordlist
      const symbolList = "!@#$%^&*()_+"
      let rndNumber = randomIntFromInterval(1000, 9999).toString()
      const rndSymbol = symbolList[randomIntFromInterval(0, symbolList.length - 1)]
      const targetWordChars = this.length - 5

      const words = []
      let totalLen = 0
      while (totalLen < targetWordChars) {
        const remaining = targetWordChars - totalLen
        let candidates = wordlist.filter(w => w.length <= remaining)
        if (candidates.length === 0) break
        const longer = candidates.filter(w => w.length >= 3)
        if (longer.length > 0) candidates = longer
        const word = candidates[randomIntFromInterval(0, candidates.length - 1)]
        words.push(word)
        totalLen += word.length
      }

      const mid = Math.ceil(words.length / 2)
      this.word1 = words.slice(0, mid).join('')
      this.word2 = words.slice(mid).join('')
      this.pwd = this.word1 + rndNumber + rndSymbol + this.word2
      if (this.pwd.length > this.length) {
        rndNumber = rndNumber.substring(0, rndNumber.length - 1)
        this.pwd = this.word1 + rndNumber + rndSymbol + this.word2
      }
    },
    generateFromApi() {
      let symbolList = "!@#$%^&*()_+"
      let wLength = (this.length - 4) / 2
      let rndNumber = randomIntFromInterval(1000, 9999).toString()
      let rndSymbol = symbolList[randomIntFromInterval(0, symbolList.length - 1)]
      axios.get("https://random-word-api.herokuapp.com/word?number=10&length=" + wLength).then(
        response => {
          let words = response.data
          this.word1 = words[randomIntFromInterval(0, words.length - 1)]
          this.word2 = words[randomIntFromInterval(0, words.length - 1)]
          if (this.word1 === this.word2) {
            this.word2 = words[randomIntFromInterval(0, words.length - 1)]
          }
          this.pwd = this.word1 + rndNumber + rndSymbol + this.word2
          if (this.pwd.length > this.length) {
            rndNumber = rndNumber.substring(0, rndNumber.length - 1)
            this.pwd = this.word1 + rndNumber + rndSymbol + this.word2
          }
        }
      )
    },
    generate() {
      if (this.useWordlist) {
        this.generateFromWordlist()
      } else {
        this.generateFromApi()
      }
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

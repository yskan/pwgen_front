<template>
  <div class="pwgen" :style="style">
    <h1>{{ pwd }}</h1>
  </div>
</template>

<script>
import axios from 'axios'

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
    }
  },
  methods: {
    generate() {
      axios.get('https://i2s.devpods.com/pwgen?length=' + this.length + '&count=' + this.count)
        .then(response => {
          this.pwd = response.data["Passwords"][0]["Password"]
        })
        .catch(error => {
          console.log(error)
        })
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

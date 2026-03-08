<template>
  <img alt="Vue logo" src="./assets/lock.svg">
  <div class="toggle-container">
    <span class="toggle-label">{{ useWordlist ? 'EFF Wordlist' : 'Random API' }}</span>
    <label class="toggle-switch">
      <input type="checkbox" v-model="useWordlist">
      <span class="slider"></span>
    </label>
  </div>
  <PwGen length=16 count=1 fontsize=80 startGradColor="#faf0ca" endGradColor="#0d3b66" :use-wordlist="useWordlist" />
  <PwGen length=32 count=1 fontsize=40 startGradColor="#fdfcdc" endGradColor="#0081a7" :use-wordlist="useWordlist" />
  <footer>
    <AboutMe />
  </footer>
</template>

<script>
import PwGen from './components/PwGen.vue'
import AboutMe from './components/About.vue'

export default {
  name: 'App',
  components: {
    PwGen,
    AboutMe
  },
  data() {
    return {
      useWordlist: true
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Anton|Roboto');

/* courier-prime-regular - latin */
@font-face {
  font-family: 'Courier Prime';
  font-style: normal;
  font-weight: 400;
  src: local(''),
    url('./assets/fonts/courier-prime-v7-latin-regular.woff2') format('woff2'),
    /* Chrome 26+, Opera 23+, Firefox 39+ */
    url('./assets/fonts/courier-prime-v7-latin-regular.woff') format('woff');
  /* Chrome 6+, Firefox 3.6+, IE 9+, Safari 5.1+ */
}


img {
  width: 256px;
  max-width: 40vw;
  margin: 0 auto;
  filter: invert(93%) sepia(2%) saturate(3563%) hue-rotate(173deg) brightness(108%) contrast(85%);
}

body {
  background: #112031;
  color: #D4ECDD;
  margin: 0;
  padding: 0;
}

#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  padding: 1rem;
  padding-bottom: 4rem;
  overflow-x: hidden;
  box-sizing: border-box;
  max-width: 100vw;
}

footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
}

.toggle-container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin: 1rem 0;
  font-family: 'Courier Prime', monospace;
}

.toggle-label {
  font-size: 14px;
  color: #D4ECDD;
}

.toggle-switch {
  position: relative;
  display: inline-block;
  width: 48px;
  height: 24px;
}

.toggle-switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

.toggle-switch .slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #345B63;
  transition: 0.3s;
  border-radius: 24px;
}

.toggle-switch .slider:before {
  content: "";
  position: absolute;
  height: 18px;
  width: 18px;
  left: 3px;
  bottom: 3px;
  background-color: #D4ECDD;
  transition: 0.3s;
  border-radius: 50%;
}

.toggle-switch input:checked + .slider {
  background-color: #0d3b66;
}

.toggle-switch input:checked + .slider:before {
  transform: translateX(24px);
}

@media (max-width: 480px) {
  img {
    width: 128px;
    max-width: 30vw;
  }
}
</style>

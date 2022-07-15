<template>
  <img alt="Vue logo" src="./assets/lock.svg">
  <PwGen length=16 count=1 fontsize=80 startGradColor="#faf0ca" endGradColor="#0d3b66" />
  <PwGen length=32 count=1 fontsize=40 startGradColor="#fdfcdc" endGradColor="#0081a7" />
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
  margin: 0 auto;
  filter: invert(93%) sepia(2%) saturate(3563%) hue-rotate(173deg) brightness(108%) contrast(85%);
}

body {
  background: #112031;
  color: #D4ECDD;
}

#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}

footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
}
</style>

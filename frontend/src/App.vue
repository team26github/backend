<template>
  <router-view/>
  <login-form></login-form>
  
</template>

<script>
import loginForm from './components/loginForm.vue';

export default {
  name: 'App',
  components: {
    'login-form': loginForm,
  }
}
</script>

<style>
html, body {
  height: 100%;
}

body {
  display: grid;
  place-items: center;
}
</style>
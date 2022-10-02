<template>
  <div class="login">
    <h2>LOGIN</h2>
    <form>
      <label for="username">Username:&emsp;</label>
      <input type="text" id="username" name="username" v-model="username" required><br><br>
      <label for="password">Password: &emsp;</label>
      <input type="password" id="password" name="password" v-model="password" required><br><br>
      <button type="submit" id="login-button" @click.prevent="get_username_password">Login</button>
    </form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'login-form',

    data() {
      return {
        login_info: []
      };
    },

    methods: {
      get_username_password() {
        const path = 'http://localhost:5000/login';
        axios.get(path, {params: {username: this.username, password: this.password}})
          .then((res) => {
            this.login_info = res.data.login;
          })
          .catch((error) => {
            // esling-disable-next-line
            console.log(error);
          })
      }
    }
  }
</script>

<style>
.login {
  display: grid;
  place-items: center;
  padding: 0 10px 10px;
  border-style: solid;
  border-color: black;
}

#login-button {
  width: 100%;
}
</style>
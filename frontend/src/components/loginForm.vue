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
    <p>{{status}}</p>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'login-form',

    data() {
      return {
        status: null,
        username: '',
        password: '',
        user_type: ''
      };
    },

    methods: {
      get_username_password() {
        const path = 'https://cors-anywhere.herokuapp.com/https://spacebarcowboysbackend.herokuapp.com/login';
        axios.get(path, {params: {username: this.username, password: this.password}})
          .then((res) => {
            if (res.data.status === 'failure'){
              this.status = 'Incorrect Credentials'
            }
            else {
              this.status = 'Success'
              this.username = res.data.results[0][4];
              this.password = res.data.results[0][1];
              this.user_type = res.data.results[0][2];
              this.$router.push(`/${this.user_type.toLowerCase()}`);
            }
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
html, body {
  height: 100%;
}

body {
  display: grid;
  place-items: center;
}

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
<template>
  <div class="login-container">
    <div class="login">
      <h2>LOGIN</h2>
      <form>
        <label for="username">Username:&emsp;</label>
        <input type="text" id="username" name="username" v-model="username" required><br><br>
        <label for="password">Password: &emsp;</label>
        <input type="password" id="password" name="password" v-model="password" required><br><br>
        <button type="submit" id="login-button" @click.prevent="get_login" :disabled="disabled">Login</button>
      </form>
      <p>{{ status }}</p>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: "login-form",
    
    data() {
        return {
            status: null,
            username: "",
            password: "",
            user_type: "",
            login_counter: 0,
            disabled: false,
            time_to_wait: 0,
            time: 0,
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    mounted() {
      this.path = this.production_path;
    },

    methods: {
        get_login() {
            if (this.username === "") {
                this.status = "Username cannot be blank.";
                return;
            }
            else if (this.password === "") {
                this.status = "Password cannot be blank.";
                return;
            }
            axios.get(this.path + "/login", { params: { username: this.username, password: this.password } })
                .then((res) => {
                if (res.data.status === "failure") {
                    this.status = "Incorrect Credentials";
                    this.login_counter++;
                    if (this.login_counter > 4) {
                        this.disabled = true;
                        if (this.time_to_wait !== 0) {
                            this.time_to_wait *= 2;
                        }
                        else {
                            this.time_to_wait += 30000;
                        }
                        if (this.time_to_wait < 60000) {
                            this.time = this.time_to_wait / 1000;
                            this.status = `Too many login attempts, please wait ${this.time} seconds to login again.`;
                        }
                        else if (this.time_to_wait === 60000) {
                            this.time = this.time_to_wait / 60000;
                            this.status = `Too many login attempts, please wait ${this.time} minute to login again.`;
                        }
                        else {
                            this.time = this.time_to_wait / 60000;
                            this.status = `Too many login attempts, please wait ${this.time} minutes to login again.`;
                        }
                        setTimeout(() => {
                            this.login_counter = 4;
                            this.disabled = false;
                            this.status = null;
                        }, this.time_to_wait);
                    }
                }
                else {
                    this.status = "Success";
                    this.username = res.data.results[0][4];
                    this.password = res.data.results[0][1];
                    this.user_type = res.data.results[0][2];
                    this.$router.push({
                        name: `${this.user_type.toLowerCase()}-dashboard`,
                        params: { username: this.username }
                    });
                }
            })
                .catch((error) => {
                // esling-disable-next-line
                console.log(error);
            });
        }
    }
}
</script>

<style scoped>
  .login-container {
    width: 100vw;
    height: 100vh;
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

  p {
    text-align: center;
  }

  #login-button {
    width: 100%;
  }
</style>
<template>
  <div class="login-container">

    <!-- Login form container -->
    <div class="login">
      <h2>LOGIN</h2>

      <!-- Login form -->
      <form>
        <label for="username">Username:&emsp;</label>
        <input type="text" id="username" name="username" v-model="username" required><br><br>
        <label for="password">Password: &emsp;</label>
        <input type="password" id="password" name="password" v-model="password" required><br><br>
        <button type="submit" id="login-button" @click.prevent="get_login" :disabled="disabled" class="btn">Login</button>
      </form>
      <p>{{ status }}</p>

      <!-- Route to forgot password page -->
      <a href="/forgotpassword">Forgot Password?</a>
      <br>
      <button @click="driver_application" class="btn">Apply to be a Driver Here!</button>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {

    // Component name
    name: "login-form",
    
    // Component specific variables and data
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

    // Mounted function is used for doing operations right after the component
    // Is mounted and right before the component is shown to the user
    mounted() {
      this.path = this.production_path;
    },

    // Component specific methods
    methods: {

        // Method to validate login information
        get_login() {
            if (this.username === "") {
                this.status = "Username cannot be blank.";
                return;
            }
            else if (this.password === "") {
                this.status = "Password cannot be blank.";
                return;
            }

            // Axios API call to python backend to validate login information
            axios.get(this.path + "/login", { params: { username: this.username, password: this.password } })
                .then((res) => {
                if (res.data.status === "failure") {
                    this.status = "Incorrect Credentials";
                    this.login_counter++;

                    // If the number of login attempts is greater than 4, then a cooldown timer
                    // for the next login attempt is initated
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

                    // If login attempt is successful, then route user to their
                    // specific dashboard
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
        },

        // Method to route user to driver application page
        driver_application() {
          this.$router.push({
            name: 'driver-application'
          })
        }
    }
}
</script>

<style scoped>
  .login-container {
    width: 99.3vw;
    height: 98.5vh;
    display: grid;
    place-items: center;
    background-color: #8c72e0;
  }

  .login {
    display: grid;
    place-items: center;
    padding: 0 10px 10px;
    border-style: solid;
    border-color: black;
    background-color: #ffffff;
  }

  p {
    text-align: center;
  }

  #login-button {
    width: 100%;
  }

  button {
    position: relative;
    border: solid;
    transition: 0.4s ease-in;
    z-index: 1;
  }

  button::before,
  button::after {
    position: absolute;
    content: "";
    z-index: -1;
  }

  .btn:hover {
    box-shadow: inset -10.5em 0 0 0 #8c72e0,
                inset 10.5em 0 0 0 #8c72e0;
  }
</style>

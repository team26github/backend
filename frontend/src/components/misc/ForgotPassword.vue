<template>
    <div class="profile-container">
        <form style="max-width:800px;margin:auto">
            <h1>Password Reset</h1>

            Please enter the below information correctly to reset your password<br><br>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Full Name" name="full_name" v-model="full_name" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Username" name="username" v-model="username" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="New Password" name="new_passwd" v-model="new_passwd" required><br><br>
            </div>

            <button type="submit" class="btn" @click="reset()" >Reset</button> 
            <br><br>
            <div style="text-align:center"><a href="/login">Return to Login</a></div>
        </form>
    </div>

</template>

<script>
    import axios from 'axios';

    export default {
        name: 'driver-profile',

        data() {
            return {
                full_name: null,
                username: null,
                email: null,
                new_password: null,
                
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        mounted() {
            this.path = this.localhost_path;
        },

        methods: {

            reset() {
                let path = 'http://localhost:5000/reset-passwd';

                axios.get(path, { params: { full_name: this.full_name, username: this.username, new_passwd: this.new_passwd } })
                    .then((res) => {
                    if (res.data.status === "failure") {
                        this.status = "Incorrect Credentials";
                        window.alert("Password reset unsuccessful");
                    }
                    else {
                        this.status = "Success";
                        this.user_id = res.data.results[0][0];
                        this.username = res.data.results[0][4];
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
        }
    }
</script>


<style scoped>
    * {box-sizing: border-box;}

    .profile-container {
    width: 99.3vw;
    height: 98.5vh;
    display: grid;
    place-items: center;
    background-color: #fff;
  }

    .input-container {
    display: auto;
    width: 100%;
    margin-bottom: 15px;
    }

    /* Style the form icons */
    .icon {
    padding: 10px;
    background: #8c72e0;
    color: white;
    min-width: 50px;
    text-align: center;
    }

    /* Style the input fields */
    .input-field {
    width: 100%;
    padding: 10px;
    outline: none;
    }

    .input-field:focus {
    border: 2px solid #555;
    }

    /* Set a style for the submit button */
    .btn {
    background-color: #8c72e0;
    color: white;
    padding: 15px 20px;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
    }

    .btn:hover {
    opacity: 1;
    }
</style>


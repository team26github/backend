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
                <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="New Password" name="new_password" v-model="new_password" required><br><br>
            </div>

            <button type="submit" class="btn" @click="reset" >Reset</button> 
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
            this.path = this.production_path;
        },

        methods: {
        
            edit_password() {
                window.alert("Password must contain at least one upper and lower case letter, at least one number, and at least one special character.")
                let new_password = window.prompt("Enter new password");
                
                var minMaxLength = /^[\s\S]{8,20}$/,
                    upper = /[A-Z]/,
                    lower  = /[a-z]/,
                    number = /[0-9]/,
                    special = /[ !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/;
                axios.post(this.path + '/edit', null, {params: {request: 'password', password: new_password, userid: this.user_id}})
                    .then((res) => {
                        window.print("Password must contain: at least one lower and upper case letter, at least one number, and at least one special character")
                        if (minMaxLength.test(new_password) && upper.test(new_password) && lower.test(new_password) && number.test(new_password) && special.test(new_password)) {
                            res.data.status = "success";
                        }
                        else {
                            res.data.status = "false";
                        }

                        if (res.data.status === "success") {
                            this.password = new_password;
                            window.alert("Password change successful");
                        }
                        if (res.data.status === "failure") {
                            window.alert("New password must be at least 8 characters and no more than 20. Contain at least one upper and lower case letter, at least one number, and at least one special character.");
                        }
                        
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },
        },

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


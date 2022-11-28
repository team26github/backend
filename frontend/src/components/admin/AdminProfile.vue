<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>

        <!-- Row for holding admin User ID, admin Username, and update username button -->
        <div class="row">

            <!-- Container for displaying admin User ID -->
            <div class="user-id-container">
                <p><strong>UserID: </strong>{{ user_id }}</p>
            </div>

            <!-- Container for displaying admin Username -->
            <div class="username-container">
                <div class="username">
                    <p><strong>Username: </strong>{{ username }}</p>
                    <button @click="edit_username"><span>Edit Username</span></button>
                </div>
            </div>
        </div>

        <!-- Row for holding admin Password and update/show password buttons -->
        <div class="row">

            <!-- Container for displaying admin password -->
            <div class="password-container">
                <div class="password">
                    <p><strong>Password: </strong>{{ password_text }}</p>
                    <button @click="edit_password"><span>Edit Password</span></button>
                    <button class="show-password" @click="show_password"><span>{{ button_text }}</span></button>
                </div>
            </div>
        </div>

        <!-- Row for holding admin Email, admin Usertype (Admin), and update button -->
        <div class="row">

            <!-- Container for displaying admin Email -->
            <div class="email-container">
                <div class="email">
                    <p><strong>Email: </strong>{{ email }}</p>
                    <button @click="edit_email"><span>Edit Email</span></button>
                </div>
            </div>

            <!-- Container for displaying admin Usertype (Admin) -->
            <div class="user-type-container">
                <p><strong>UserType: </strong>{{ user_type }}</p>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from '../misc/NavBar.vue';

    export default {

        // Component name
        name: 'admin-profile',

        // Component specific variables and data
        data() {
            return {
                user_id: null,
                username: null,
                password: null,
                password_text: "***********************",
                email: null,
                user_type: "Admin",
                button_text: "Show Password",
                password_active: false,
                edit_username_active: false,
                edit_password_active: false,
                edit_email_active: false,
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {

            // Gets admin username from route url
            this.username = this.$route.params.username;

            // Sets path for axios API calls to either localhost or production
            this.path = this.localhost_path;

            // Axios API call to python backend to get user information
            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        console.log(res.data);
                        this.user_id = res.data.results[0][0];
                        this.password = res.data.results[0][1];
                        this.email = res.data.results[0][3];
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
        },

        // Component specific methods
        methods: {
            show_password() {
                if (this.password_active) {
                    this.password_text = "***********************";
                    this.password_active = false;
                    this.button_text = "Show Password";
                }
                else {
                    this.password_text = this.password;
                    this.password_active = true;
                    this.button_text = "Hide Password";
                }
            },

            // Method to change admin username
            edit_username() {

                // Getting new username from user
                let new_username = window.prompt("Enter new username");

                // Axios API call to python backend to check for duplicate username
                axios.get(this.path + '/edit', {params: {request: 'username', username: new_username}})
                    .then((res) => {
                        if (res.data.status === 'success') {      
                            
                            // Axios API call to python backend to update username
                            axios.post(this.path + '/edit', null, {params: {request: 'username', username: new_username, userid: this.user_id}})
                                .then((res) => {
                                    if (res.data.status === "success") {
                                        this.username = new_username;
                                        console.log("success");
                                    }
                                    else {
                                        window.alert("Username change unsuccessful");
                                    }
                                })
                                .catch((error) => {
                                    // esling-disable-next-line
                                    console.log(error);
                                })
                        }
                        else {
                            window.alert("That username is unavailable.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },

            // Method to change admin password
            edit_password() {

                // Getting new password from user and checking to make sure it meets password requirements
                window.alert("Password must contain at least one upper and lower case letter, at least one number, and at least one special character.")
                let new_password = window.prompt("Enter new password");
                var minMaxLength = /^[\s\S]{8,20}$/,
                    upper = /[A-Z]/,
                    lower  = /[a-z]/,
                    number = /[0-9]/,
                    special = /[ !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/;
                
                // Axios API call to python backend to change password
                axios.post(this.path + '/edit', null, {params: {request: 'password', password: new_password, userid: this.user_id}})
                    .then((res) => {

                        // Checking password to make sure it meets all requirements
                        if (minMaxLength.test(new_password) && upper.test(new_password) && lower.test(new_password) && number.test(new_password) && special.test(new_password)) {
                            res.data.status = "success";
                        }
                        else {
                            res.data.status = "false";
                        }

                        // Checking to see if new password is different from old password
                        if(new_password === this.password){
                            window.alert("New password must be different than old password")
                            res.data.status = "failure"
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

            // Method to change admin email
            edit_email() {

                // Getting new email from user
                let new_email = window.prompt("Enter new email");

                // Axios API call to python backend to check for duplicate email
                axios.get(this.path + '/edit', {params: {request: 'email', email: new_email}})
                .then((res) => {
                    if (res.data.status === "success") {

                        // Axios API call to python backend to change user email
                        axios.post(this.path + '/edit', null, {params: {request: 'email', email: new_email, userid: this.user_id}})
                        .then((res) => {
                            if (res.data.status === "success") {
                                this.email = new_email;
                                window.alert("Email change successful");
                            }
                            else {
                                window.alert("Email change unsuccessful");
                            }
                        })
                        .catch((error) => {
                            // esling-disable-next-line
                            console.log(error);
                        })
                    }
                    else {
                        window.alert("That email is unavailable.");
                    }
                })
            }
        },

        // Components used from external files
        components: { NavBar }
    }
</script>

<style scoped>
    .profile-container {
        display: flex;
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: #ff90b3;
    }

    .password, .username, .email {
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .row {
        width: 100%;
        height: 45px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
    }

    .user-id-container, .username-container, .password-container, .email-container, .user-type-container {
        display: flex;
        width: 49%;
        border-style: solid;
        border-color: black;
        justify-content: start;
        align-items: center;
    }

    button {
        margin-right: 5px;
        margin-left: auto;
        display: block;
        width: 150px;
        height: 30px;
        font-size: 13px;
        text-decoration: none;
        color: black;
        border: 2px solid black;
        letter-spacing: 1px;
        text-align: center;
        position: relative;
        transition: all 0.35s;
    }

    button span {
        position: relative;
        z-index: 2;
    }

    button::after {
        position: absolute;
        content: "";
        top: 0;
        left: 0;
        width: 0;
        height: 100%;
        background: lightskyblue;
        transition: all 0.35s;
    }

    button:hover {
        color: white;
        cursor: pointer;
    }

    button:hover::after {
        width: 100%;
    }

    .password-container .password .show-password {
        margin-left: 0;
    }

    p {
        margin-left: 5px;
    }
</style>

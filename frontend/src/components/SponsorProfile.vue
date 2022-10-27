<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <div class="row">
            <div class="user-id-container">
                <p><strong>UserID: </strong>{{ user_id }}</p>
            </div>
            <div class="username-container">
                <div class="username">
                    <p><strong>Username: </strong>{{ username }}</p>
                    <button @click="edit_username">Edit Username</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="password-container">
                <div class="password">
                    <p><strong>Password: </strong>{{ password_text }}</p>
                    <button @click="edit_password">Edit Password</button>
                    <button class="show-password" @click="show_password">{{ button_text }}</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="email-container">
                <div class="email">
                    <p><strong>Email: </strong>{{ email }}</p>
                    <button @click="edit_email">Edit Email</button>
                </div>
            </div>
            <div class="user-type-container">
                <p><strong>UserType: </strong>{{ user_type }}</p>
            </div>
        </div>
        <div class="row">
            <div class="drivers-container">
                <div class="drivers">
                    <p><strong>Drivers: </strong>{{ selected }}
                    <button @click="fetchDrivers">View Drivers</button></p>
                </div>
            </div>
        </div>
        <div class="row">
            <option v-for="driver in drivers" :key="driver">{{driver}}</option>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from './NavBar.vue';

    export default {
        name: 'sponsor-profile',

        data() {
            return {
                user_id: null,
                username: null,
                password: null,
                password_text: "***********************",
                email: null,
                user_type: "Sponsor",
                button_text: "Show Password",
                password_active: false,
                edit_username_active: false,
                edit_password_active: false,
                edit_email_active: false,
                drivers: [],
                allData: null,
                localhost_path: 'http://localhost:5000',
                production_path: "http://18.191.136.200"
            };
        },

        mounted() {
            this.username = this.$route.params.username;
            this.path = this.localhost_path;

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

        methods: {
            fetchAllData(){ //show records
                axios.get(this.path + '/', {params: {request: 'username'}})
                .then(function(response){
                        console.log(response);
                        this.allData = response.data.members;
                });
            },

            fetchDrivers() {
                axios.get(this.path + '/get-drivers', {params: {user_id: this.user_id}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            for (const name of res.data.results) {
                                this.drivers.push(name[0]);
                            }
                        }
                        else {
                            console.log('Unsuccessful');
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            },
            
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

            edit_username() {
                let new_username = window.prompt("Enter new username");
                axios.get(this.path + '/edit', {params: {request: 'username', username: new_username}})
                    .then((res) => {
                        if (res.data.status === 'success') {       
                            axios.post(this.path + '/edit', null, {params: {request: 'username', username: new_username, userid: 3}})
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

            edit_password() {
                window.alert("Password must contain at least one upper and lower case letter, at least one number, and at least one special character.")
                let new_password = window.prompt("Enter new password");
                var minMaxLength = /^[\s\S]{8,20}$/,
                    upper = /[A-Z]/,
                    lower  = /[a-z]/,
                    number = /[0-9]/,
                    special = /[ !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/;
                axios.post(this.path + '/edit', null, {params: {request: 'password', password: new_password, userid: 3}})
                    .then((res) => {
                        if (minMaxLength.test(new_password) && upper.test(new_password) && lower.test(new_password) && number.test(new_password) && special.test(new_password)) {
                            res.data.status = "success";
                        }
                        else {
                            res.data.status = "failure";
                        }

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

            edit_email() {
                let new_email = window.prompt("Enter new email");
                axios.get(this.path + '/edit', {params: {request: 'email', email: new_email}})
                .then((res) => {
                    if (res.data.status === "success") {
                        axios.post(this.path + '/edit', null, {params: {request: 'email', email: new_email, userid: 3}})
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
            },
        },

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
        background-color: #73bfb8;
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

    .user-id-container, .username-container, .password-container, .email-container, .user-type-container, .drivers-list-container {
        display: flex;
        width: 49%;
        border-style: solid;
        border-color: black;
        justify-content: center;
        align-items: center;
    }

    button {
        margin-right: 5px;
        margin-left: auto;
    }

    .password-container .password .show-password .show-drivers{
        margin-left: 0;
    }

    p {
        margin-left: 5px;
    }
</style>

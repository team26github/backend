<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :userid="username"></NavBar>
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
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from './NavBar.vue';

    export default {
        name: 'driver-profile',

        data() {
            return {
                user_id: 1,
                username: "Driver1",
                password: "Password1",
                password_text: "***********************",
                email: "driver1@email.com",
                user_type: "driver",
                button_text: "Show Password",
                password_active: false,
                edit_username_active: false,
                edit_password_active: false,
                edit_email_active: false,
                points:0
            };
        },
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

            edit_username() {
                let path = 'http://localhost:5000/edit'
                let new_username = window.prompt("Enter new username");
                axios.get(path, {params: {request: 'username', username: new_username}})
                    .then((res) => {
                        if (res.data.status === 'success') {       
                            axios.post(path, null, {params: {request: 'username', username: new_username, userid: 1}})
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
                let new_password = window.prompt("Enter new password");
                let path = 'http://localhost:5000/edit';
                var minNumOfChars = 8;
                var maxNumOfChars = 20;
                var regExpression = /^[a-zA-Z0-9!@#$%^&*]{8,20}$/;
                axios.post(path, null, {params: {request: 'password', password: new_password, userid: 3}})
                    .then((res) => {
                        if (new_password.length < minNumOfChars){
                                window.alert("Password must be at least 8 characters");
                                res.data.status = "failure";
                        }
                        if (new_password.length > maxNumOfChars){
                                window.alert("Password must be less than 20 characters");
                                res.data.status = "failure";
                        }
                        if (!regExpression.test(new_password)){
                                window.alert("Password should contain at least one lowercase and uppercase letter, and at least one special character");
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
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },

            edit_email() {
                let path = 'http://localhost:5000/edit';
                let new_email = window.prompt("Enter new email");
                axios.get(path, {params: {request: 'email', email: new_email}})
                .then((res) => {
                    if (res.data.status === "success") {
                        axios.post(path, null, {params: {request: 'email', email: new_email, userid: 1}})
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
        background-color: darkseagreen;
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
        justify-content: center;
        align-items: center;
    }

    button {
        margin-right: 5px;
        margin-left: auto;
    }

    .password-container .password .show-password {
        margin-left: 0;
    }

    p {
        margin-left: 5px;
    }
</style>
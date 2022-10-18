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
        <div class="row">
            <div class="drivers-container">
                <div class="drivers">
                    <p><strong>Drivers: </strong>{{ drivers }}
                    <button @click="view_drivers">View Drivers</button></p>
                </div>
                <!-- <table class="table table-bordered table-striped">
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                    </tr>
                    <tr v-for="rs in records" v-bind:key="rs.id">
                        <td>{{ rs.FIRST_NAME }}</td>
                        <td>{{ rs.LAST_NAME }}</td>
                        !-- <td><button type="button" name="edit" class="btn btn-primary btn-xs edit">Edit</button></td>
                        <td><button type="button" name="delete" class="btn btn-danger btn-xs delete">Delete</button></td> --
                    </tr>
                </table> -->
            </div>
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
                user_id: 3,
                username: "Sponsor1",
                password: "Password3",
                password_text: "***********************",
                email: "sponsor@email.com",
                user_type: "sponsor",
                button_text: "Show Password",
                password_active: false,
                edit_username_active: false,
                edit_password_active: false,
                edit_email_active: false,
                drivers: 'Driver1, Driver 2',
                records: '',
            };
        },
        methods: {
            fetchAllData:function(){ //show records
                axios.get('http://localhost:5000/', {params: {request: 'username'}})
                .then(function(response){
                        console.log(response);
                        this.allData = response.data.members;
                });
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
                let path = 'http://localhost:5000/edit'
                let new_username = window.prompt("Enter new username");
                axios.get(path, {params: {request: 'username', username: new_username}})
                    .then((res) => {
                        if (res.data.status === 'success') {       
                            axios.post(path, null, {params: {request: 'username', username: new_username, userid: 3}})
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
                let path = 'http://localhost:5000/edit';
                var minMaxLength = /^[\s\S]{8,20}$/,
                    upper = /[A-Z]/,
                    lower  = /[a-z]/,
                    number = /[0-9]/,
                    special = /[ !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]/;
                axios.post(path, null, {params: {request: 'password', password: new_password, userid: 3}})
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
                let path = 'http://localhost:5000/edit';
                let new_email = window.prompt("Enter new email");
                axios.get(path, {params: {request: 'email', email: new_email}})
                .then((res) => {
                    if (res.data.status === "success") {
                        axios.post(path, null, {params: {request: 'email', email: new_email, userid: 3}})
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

            view_drivers() {
                let path = 'http://localhost:5000/edit';
                axios.get(path, {params: {request: 'username1', userid: 3}})
                .then((res) => {
                    console.log(res)
                    this.records = res.data;
                })
                .catch(err => {
                  console.log(err)
                })
            },
        },
        created:function(){
            this.fetchAllData();
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
        background-color: darkgray;
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
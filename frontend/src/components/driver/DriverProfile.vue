<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        
        <!-- Row for holding driver User ID, driver Username, and update username button -->
        <div class="row">

            <!-- Container for displaying driver User ID -->
            <div class="user-id-container">
                <p><strong>UserID: </strong>{{ user_id }}</p>
            </div>

            <!-- Container for displaying driver Username -->
            <div class="username-container">
                <div class="username">
                    <p><strong>Username: </strong>{{ username }}</p>
                    <!-- <button @click="edit_username"><span>Edit Username</span></button> -->
                </div>
            </div>
        </div>

        <!-- Row for holding driver Password and update/show password buttons -->
        <div class="row">

            <!-- Container for displaying driver password -->
            <div class="password-container">
                <div class="password">
                    <p><strong>Password: </strong>{{ password_text }}</p>
                    <button @click="edit_password"><span>Edit Password</span></button>
                    <button class="show-password" @click="show_password"><span>{{ button_text }}</span></button>
                </div>
            </div>
        </div>

        <!-- Row for holding driver Email, driver Usertype (Driver), and update button -->
        <div class="row">

            <!-- Container for displaying driver Email -->
            <div class="email-container">
                <div class="email">
                    <p><strong>Email: </strong>{{ email }}</p>
                    <button @click="edit_email"><span>Edit Email</span></button>
                </div>
            </div>

            <!-- Container for displaying driver Usertype (Driver) -->
            <div class="user-type-container">
                <p><strong>UserType: </strong>{{ user_type }}</p>
            </div>
        </div>

        <!-- Row for holding driver past purchases -->
        <div class="row">

            <!-- Container for displaying driver past purchase names -->
            <div class="purchases-container">
                <p><strong>View Past Purchases</strong></p>&nbsp;
                <label class="purchases">Choose a Purchase: </label>

                <!-- Dropdown menu for showing driver past purchases -->
                <select class="dropdown-menu" @change="get_purchase($event)">
                    <option value="All" selected>All</option>
                    <option v-for="purchase in purchase_info" :key="purchase">{{purchase.items}}</option>
                </select>

                <button @click="show_purchases = !show_purchases" class="btn"><span>{{ (show_purchases ? "Hide" : "View") }}</span></button>
            </div> 
        </div>

        <!-- Row for holding driver past purchase information -->
        <div class="info-row">

            <!-- Container for displaying driver past purchase information if "view" button is clicked -->
            <div class="purchases" v-if="show_purchases">
                <div class="purchases" v-for="purchase in display_purchases()" :key="purchase">
                    <p><strong>Order Email:</strong> {{ purchase.email }}</p>
                    <br>
                    <p><strong>Items:</strong> {{ purchase.items }}</p>
                    <br>
                    <p><strong>Points Cost:</strong> {{ purchase.point_total }}</p>
                    <br>
                    <p><strong>Order Status:</strong> Pending Delivery</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from '../misc/NavBar.vue';

    export default {

        // Component name
        name: 'driver-profile',

        // Component specific variables and data
        data() {
            return {
                user_id: null,
                username: null,
                password: null,
                password_text: "***********************",
                email: null,
                user_type: "Driver",
                button_text: "Show Password",
                password_active: false,
                edit_username_active: false,
                edit_password_active: false,
                purchase_info: [],
                show_purchases: false,
                selected_purchase:'All',
                edit_email_active: false,
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {

            // Getting username for user from URL and setting path for axios API calls
            // to either localhost or production
            this.username = this.$route.params.username;
            this.path = this.production_path;

            // Axios API call to python backend to get current user information
            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.user_id = res.data.results[0][0];
                        this.password = res.data.results[0][1];
                        this.email = res.data.results[0][3];

                        this.get_purchase_info();

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

            // Method to show user password depending on whether "password_active" flag
            // is true or false
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

            // Method to get specific purchase information from dropdown menu
            get_purchase(event) {
                this.selected_purchase = event.target.value;
            },

            // Method to display specific past purchase if one is selected or all past purchases
            // if a specific past purchase is not selected
            display_purchases() {
                if (this.selected_purchase === 'All') return this.purchase_info;
                else {
                    for (let p of this.purchase_info) {
                        if (p.items === this.selected_purchase) return [p];
                    }
                }
            },

            // Method to get past purchase information
            get_purchase_info() {

                // Axios API call to python backend to get all driver past purchases and information
                // from database
                axios.get(this.path + '/purchase-info', { params: { user_id: this.user_id } })
                    .then((res) => {
                        if (res.data.status === 'success') {
                            for (const info of res.data.results) {
                                let purchase = {};

                                purchase['first_name'] = info[1];
                                purchase['last_name'] = info[2];
                                purchase['email'] = info[7];
                                purchase['items_total'] = info[8];
                                purchase['point_total'] = info[9];
                                purchase['items'] = info[10];
                                this.purchase_info.push(purchase);
                            }
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            },

            // edit_username() {
            //     let new_username = window.prompt("Enter new username");
            //     axios.get(this.path + '/edit', {params: {request: 'username', username: new_username}})
            //         .then((res) => {
            //             if (res.data.status === 'success') {       
            //                 axios.post(this.path + '/edit', null, {params: {request: 'username', username: new_username, userid: this.user_id}})
            //                     .then((res) => {
            //                         if (res.data.status === "success") {
            //                             this.username = new_username;
            //                             console.log("success");
            //                         }
            //                         else {
            //                             window.alert("Username change unsuccessful");
            //                         }
            //                     })
            //                     .catch((error) => {
            //                         // esling-disable-next-line
            //                         console.log(error);
            //                     })
            //             }
            //             else {
            //                 window.alert("That username is unavailable.");
            //             }
            //         })
            //         .catch((error) => {
            //             // esling-disable-next-line
            //             console.log(error);
            //         })
            // },

            // Method to change driver password
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
                        window.print("Password must contain: at least one lower and upper case letter, at least one number, and at least one special character")
                        
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

            // Method to change driver email
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
        background-color: #0096c7;
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

    .info-row {
        width: 100%;
        height: 50vh;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 2rem;
    }

    .user-id-container, .username-container, .password-container, .email-container, .user-type-container{
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
        background: darkred;
        transition: all 0.35s;
    }

    button:hover {
        color: white;
        cursor: pointer;
    }

    button:hover::after {
        width: 100%;
    }

    .purchases-container {
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .password-container .password .show-password {
        margin-left: 0;
    }

    p {
        display: inline-block;
        width: auto;
        margin-left: 5px;
    }

    .points-container {
        margin-left: 0;
    }

    .dropdown-menu>li>a {
    word-wrap: break-word;
    white-space: normal;
    }

    .dropdown-menu{
        max-width: 200px;
    }

</style>

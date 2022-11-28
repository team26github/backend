<template>
    <div class="settings-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>

        <!-- Form to fill out for a new sponsor -->
        <form style="max-width:800px;margin:auto">
            <h1>New Sponsor</h1>

            <!-- First Name Input Container -->
            <div class="input-container">
                <input class="input-field" type="text" placeholder="First Name" name="first_name" v-model="first_name" required><br><br>
            </div>

            <!-- Last Name Input Container -->
            <div class="input-container">
                <input class="input-field" type="text" placeholder="Last Name" name="last_name" v-model="last_name" required><br><br>
            </div>

            <!-- Username Input Container -->
            <div class="input-container">
                <input class="input-field" type="text" placeholder="Username" name="username" v-model="sponsor_username" required><br><br>
            </div>

            <!-- Email Input Container -->
            <div class="input-container">
                <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
            </div>
            
            <!-- Password Input Container -->
            <div class="input-container">
                <input class="input-field" type="password" placeholder="Password" name="password" v-model="password" required><br><br>
            </div>

            <!-- Submit button to create a new sponsor -->
            <button type="submit" class="btn" @click="create_sponsor" >Create</button> 
        </form>
    </div>

</template>

<script>
    import axios from 'axios';
    import NavBar from '../misc/NavBar.vue';

    export default {

        // Component name
        name: "new-sponsor",

        // Component specific variables and data
        data() {
            return {
                status: null,
                first_name: '',
                last_name:'',
                username: '',
                sponsor_username: '',
                password: '',
                email: '',
                user_type: '',
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {

            // Getting username from route URL and setting Axios API path to either
            // localhost or production
            this.username = this.$route.params.username;
            this.path = this.localhost_path;

            // Axios API call to python backend to get current user information
            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        console.log(res.data);
                        this.user_type = res.data.results[0][2];
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

            // Method to create a new sponsor upon submission button click
            create_sponsor() {

                // Axios API call to python backend to check for duplicate users
                axios.get(this.path + '/new-user', {params: {username: this.sponsor_username, email: this.email}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            if (res.data.results.length === 0) {

                                // Axios API call to python backend to add new sponsor to database
                                axios.post(this.path + '/new-driver', null, {params: {email: this.email, first_name: this.first_name, last_name: this.last_name, username: this.sponsor_username, password: this.password, sponsor: this.sponsor_selected}}) 
                                    .then((res) => {
                                        if (res.data.status === "success") {
                                            console.log("success");
                                        }
                                        else {
                                            window.alert("Cannot create sponsor.");
                                        }
                                    })
                                    .catch((error) => {
                                        // esling-disable-next-line
                                        console.log(error);
                                    });
                            }
                            else if (res.data.results.length === 1) {
                                window.alert(`${res.data.results[0]} is already taken`);
                            }
                            else if (res.data.results.length === 2) {
                                window.alert(`${res.data.results[0]} and ${res.data.results[1]} are already taken`);
                            }
                        }
                        else {
                            console.log('Failure');
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    });
            },
        },

        // Components used from external files
        components: { NavBar }
    }

</script>

<style scoped>
    * {box-sizing: border-box;}

    .settings-container {
        /* display: flex; */
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: #ff90b3;
    }

    .input-container {
    display: flex;
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
    border: 2px solid #8c72e0;
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

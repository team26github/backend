<template>
    <div class="settings-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <form style="max-width:800px;margin:auto">
            <h1>New Sponsor</h1>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="First Name" name="first_name" v-model="first_name" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Last Name" name="last_name" v-model="last_name" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Username" name="username" v-model="sponsor_username" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
            </div>
            
            <div class="input-container">
                <input class="input-field" type="password" placeholder="Password" name="password" v-model="password" required><br><br>
            </div>

            <button type="submit" class="btn" @click="create_sponsor" >Create</button> 
        </form>
    </div>

</template>

<script>
    import axios from 'axios';
    import NavBar from '../misc/NavBar.vue';

    export default {
        name: "new-sponsor",

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

        mounted() {
            this.username = this.$route.params.username;
            this.path = this.localhost_path;

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

        methods: {

            create_sponsor() {
                axios.get(this.path + '/new-user', {params: {username: this.sponsor_username, email: this.email}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            if (res.data.results.length === 0) {
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
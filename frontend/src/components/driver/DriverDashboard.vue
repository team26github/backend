<template>
    <div class="profile-container">
        <nav-bar :usertype="user_type" :username="username"></nav-bar>
        <div class="row">
            <div class="points">
                <p><strong>Points: </strong>{{ num_points }}</p>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '@/components/misc/NavBar.vue';
    import axios from 'axios';

    export default {

        // Component name
        name: 'driver-dashboard',

        // Component specific variables and data
        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'driver',
                active: false,
                num_points: null,
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            }
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {

            // Getting username for user from URL and setting path for axios API calls
            // to either localhost or production
            this.username = this.$route.params.username;
            this.path = this.localhost_path;

            // Axios API call to python backend to get current user information
            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.num_points = res.data.results[0][11];
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
        },

        // Components used from external files
        components: {
            "nav-bar": NavBar
        },
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

    .points-container {
        margin-left: 0;
    }

    p {
        margin-left: 5px;
    }
</style>
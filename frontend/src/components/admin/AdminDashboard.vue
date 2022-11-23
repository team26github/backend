<template>

    <!-- Container to hold admin dashboard -->
    <div class="profile-container">
        <nav-bar :usertype="user_type" :username="username"></nav-bar>
        <br><br>
        <!-- Button for Adding Points to a Driver -->
        <div class="row">
            <div class="add-point-container">
                <button @click="go_to_add_points_admin"><span>Add Points to Driver</span></button>
            </div>
        </div>

        <!-- Button for Removing Points from a Driver -->
        <div class="row">
            <div class="remove-points-button">
                    <button @click="go_to_remove_points_admin"><span>Deduct Points from Driver</span></button>
            </div>
        </div>

        <!-- Button for Setting Users Inactive -->
        <div class="row">
            <div class="set-inactive-admin-button">
                <button @click="go_to_set_inactive_admins"><span>Set Users Inactive</span></button>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '../misc/NavBar.vue';

    export default {

        // Component name
        name: 'admin-dashboard',

        // Component specific variables and data
        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'admin',
                active: false,
                points: 0
            }
        },

        // Component specific methods
        methods: {
            
            // Function that routes admin user to add points screen
            go_to_add_points_admin() {
                this.$router.push({
                    name: 'add-points-admin',
                    params: { username: this.username }
                });
            },

            // Function that routes admin user to remove points screen
            go_to_remove_points_admin() {
                this.$router.push({
                    name: 'remove-points-admin',
                    params: { username: this.username }
                });
            },

            // Function that routes admin user to set inactive screen
            go_to_set_inactive_admins() {
                this.$router.push({
                    name: 'set-inactive-admins',
                    params: { username: this.username }
                });
            },
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {
            // Gets username of user from route url
            this.username = this.$route.params.username;
        },

        // Components used from external files
        components: {
            "nav-bar": NavBar
        }
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
        justify-content: center;
        align-items: center;
    }

    button {
        margin-right: 5px;
        margin-left: auto;
        display: block;
        width: 200px;
        height: 40px;
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

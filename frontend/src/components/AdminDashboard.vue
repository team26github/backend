<template>
    <div class="profile-container">
        <nav-bar :usertype="user_type" :username="username"></nav-bar>
        <br><br>
        <div class="row">
            <div class="add-point-container">
                <button @click="add_points"> Add Points to Driver</button>
            </div>
        </div>
        <div class="row">
            <div class="remove-points-container">
                    <button @click="deduct_points">Deduct Points from Driver</button>
            </div>
        </div>
        <div class="row">
            <div class="set-inactive-admin-button">
                <button @click="go_to_set_inactive_admins">Set Drivers Inactive</button>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'admin-dashboard',

        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'admin',
                active: false,
                points: 0
            }
        },

        methods: {
            add_points() {
                let add_point_val = window.prompt("Enter number of points to be added");
                this.points += add_point_val;
                if (this.points > 1000000) {
                    window.alert("Total points cannot be greater than 1000000")
                }
                this.points -+ add_point_val;
            },
            deduct_points() {
                let remove_point_val = window.prompt("Enter number of points to be removed");
                this.points -= remove_point_val;
                if (this.points < 0) {
                    window.alert("Total point value cannot go below 0")
                }
                this.points += remove_point_val;
            },
            go_to_set_inactive_admins() {
                this.$router.push({
                    name: 'set-inactive-admins',
                    params: { username: this.username }
                });
            },
        },

        mounted() {
            this.username = this.$route.params.username;
        },

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
    }

    .password-container .password .show-password {
        margin-left: 0;
    }

    p {
        margin-left: 5px;
    }
</style>

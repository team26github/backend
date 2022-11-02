<template>
    <div class="profile-container">
        <nav-bar :usertype="user_type" :username="username"></nav-bar>
        <div class="row">
            <div class="points">
                <p><strong>Points: </strong>{{ default_points }}</p>
            </div>
        </div>
        <div class="row">
            <div class="cart">
                <p><button @click="go_to_my_cart">My Cart</button></p>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '../components/misc/NavBar.vue';
    export default {
        name: 'driver-dashboard',

        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'driver',
                active: false,
                default_points: 0
            }
        },

        mounted() {
            this.username = this.$route.params.username;
        },

        components: {
            "nav-bar": NavBar
        },
        methods: {
            go_to_my_cart() {
                this.$router.push({
                    name: 'cart-checkout',
                    params: { username: this.username }
                })
            },
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
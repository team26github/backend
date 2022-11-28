<template>

    <!-- Container to hold nav bar and links to different pages -->
    <div class = "nav">
        <b @click="home"><img v-bind:src=image width="65" height="40" /></b> 
        <a @click="catalog">Catalog</a>
        <a @click="profile">Profile</a>
        <a @click="settings">Settings</a>
        <a @click="logout">Logout</a>
    </div>
</template>

<script>
    import image from "@/components/logo.png"

    export default {

        // Component specific variables and data
        data: function () {
            return {
                image: image
            }
        },

        // Component name and props
        name:'NavBar',
        props: ['usertype', 'username'],

        // Component specific methods
        methods: {

            // Method to logout user upon logout button click
            logout() {
                localStorage.clear();
                this.$router.push({name:'login'})
            },

            // Method to route user to dashboard upon logo click
            home() {
                this.$router.push({
                    name: `${this.usertype.toLowerCase()}-dashboard`,
                    params: { username: this.username }
                });
            },

            // Method to route user to catalog upon catalog button click
            catalog() {
                this.$router.push({
                    name: 'catalog',
                    params: { username: this.username }
                });
            },

            // Method to route user to their profile information upon profile button click
            profile() {
                this.$router.push({
                    name: `${this.usertype.toLowerCase()}-profile`,
                    params: { username: this.username }
                });
            },

            // Method to route user to their settings page upon settings button click
            settings() {
                this.$router.push({
                    name: `${this.usertype.toLowerCase()}-settings`,
                    params: { username: this.username }
                });
            }
        }
    }
</script>

<style scoped>
    .nav {
        width: 100%;
        height: 45px;
        background-color: #555;
    }
    
    .nav a {
        float: left;
        padding: 12px;
        color: white;
        text-decoration: none;
        font-size: 17px;
        transition: 0.2s ease-in;
    }
    .nav b {
        float: left;
        padding: 2px;
        color: white;
        text-decoration: none;
        font-size: 20px;
        transition: 0.2s ease-in;
    }
    
    .nav a:hover {
        background-color: #8c72e0;
        cursor: pointer;
        box-shadow: 0 0 5px #8c72e0,
                    0 0 25px #8c72e0,
                    0 0 50px #8c72e0,
                    0 0 200px #8c72e0;
    }
    .nav b:hover {
        background-color: #8c72e0;
        cursor: pointer;
        box-shadow: 0 0 5px #8c72e0,
                    0 0 25px #8c72e0,
                    0 0 50px #8c72e0,
                    0 0 200px #8c72e0;
    }
    
    @media screen and (max-width: 500px) {
        .navbar a {
        float: none;
        display: block;
        }
    }

</style> 
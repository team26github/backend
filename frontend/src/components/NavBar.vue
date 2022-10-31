<template>
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
        data: function () {
            return {
            image: image
            }
        },
        name:'NavBar',
        props: ['usertype', 'username'],
        methods: {
            logout() {
                localStorage.clear();
                this.$router.push({name:'login'})
            },

            home() {
                this.$router.push({
                    name: `${this.usertype.toLowerCase()}-dashboard`,
                    params: { username: this.username }
                });
            },

            catalog() {
                this.$router.push({
                    name: 'catalog',
                    params: { username: this.username }
                });
            },

            profile() {
                this.$router.push({
                    name: `${this.usertype.toLowerCase()}-profile`,
                    params: { username: this.username }
                });
            },

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
        overflow: auto;
    }
    
    .nav a {
        float: left;
        padding: 12px;
        color: white;
        text-decoration: none;
        font-size: 17px;
    }
    .nav b {
        float: left;
        padding: 2px;
        color: white;
        text-decoration: none;
        font-size: 20px;
    }
    
    .nav a:hover {
        background-color: #8c72e0;
        cursor: pointer;
    }
    .nav b:hover {
        background-color: #8c72e0;
        cursor: pointer;
    }
    
    @media screen and (max-width: 500px) {
        .navbar a {
        float: none;
        display: block;
        }
    }

</style> 
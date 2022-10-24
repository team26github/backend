<template>
    <div class = "nav">
        <a @click="home">Home</a>
        <a @click="catalog">Catalog</a>
        <a @click="profile">Profile</a>
        <a @click="settings">Settings</a>
        <a @click="logout">Logout</a>
    </div>
</template>

<script>
    export default {
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
    
    .nav a:hover {
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
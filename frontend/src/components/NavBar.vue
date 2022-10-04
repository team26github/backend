<template>
    <div class = "nav">
        <a href="#"><i class="fa fa-fw fa-home"></i> Home</a>
        <a href="#" target="blank">Profile</a>
        <a href="#" target="blank">Settings</a>
        <a v-on:click="Logout" href = "/login">Logout</a>
    </div>
</template>

<script>
    export default {
        name:'NavBar',
        methods:{
            logout()
            {
                localStorage.clear();
                this.$router.push({name:'Login'})
            }
        }
    }
</script>

<style>
    body {font-family: Arial, Helvetica, sans-serif; display: grid; place-items: top;}
    
    .nav {
        width: 100%;
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
    }
    
    @media screen and (max-width: 500px) {
        .navbar a {
        float: none;
        display: block;
        }
    }

</style> 
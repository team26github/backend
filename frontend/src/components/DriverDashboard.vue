<template>
    <nav-bar :usertype="user_type" :userid="username"></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'driver-dashboard',

        data() {
            return {
                dashboard_name: 'Driver Dashboard',
                username: 'Driver1',
                user_type: 'driver',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
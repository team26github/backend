<template>
    <nav-bar :usertype="user_type" :userid="username"></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'admin-dashboard',

        data() {
            return {
                dashboard_name: 'Admin Dashboard',
                username: 'Admin1',
                user_type: 'admin',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
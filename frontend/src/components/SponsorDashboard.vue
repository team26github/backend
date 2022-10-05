<template>
    <nav-bar :usertype="user_type" :userid="username"></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'SponsorDashboard',

        data() {
            return {
                dashboard_name: 'Sponsor Dashboard',
                username: 'Sponsor1',
                user_type: 'sponsor',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
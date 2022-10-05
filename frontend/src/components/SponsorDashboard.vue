<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'SponsorDashboard',

        data() {
            return {
                dashboard_name: 'Sponsor Dashboard',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
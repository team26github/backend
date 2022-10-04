<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'admin-dashboard',

        data() {
            return {
                dashboard_name: 'Admin Dashboard',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
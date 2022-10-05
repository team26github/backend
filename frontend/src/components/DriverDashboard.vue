<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'driver-dashboard',

        data() {
            return {
                dashboard_name: 'Driver Dashboard',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
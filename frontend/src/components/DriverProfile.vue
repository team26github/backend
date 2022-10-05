<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'driver-profile',

        data() {
            return {
                dashboard_name: 'Driver Profile',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
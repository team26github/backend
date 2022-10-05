<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'admin-profile',

        data() {
            return {
                dashboard_name: 'Admin Profile',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
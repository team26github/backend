<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'settings',

        data() {
            return {
                dashboard_name: 'Settings',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
<template>
    <nav-bar></nav-bar>
</template>

<script>
    import NavBar from '../components/NavBar.vue';

    export default {
        name: 'sponsor-profile',

        data() {
            return {
                dashboard_name: 'Sponsor Profile',
                active: false
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
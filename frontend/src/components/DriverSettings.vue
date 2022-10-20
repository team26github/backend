<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "driver-settings",
    data() {
        return {
            user_type: "driver",
            username: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
    },

    components: { NavBar }
}
</script>

<style scoped></style>
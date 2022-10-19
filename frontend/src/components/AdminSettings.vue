<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "admin-settings",
    data() {
        return {
            user_type: "admin",
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
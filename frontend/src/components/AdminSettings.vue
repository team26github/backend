<template>
    <NavBar :usertype="user_type" :userid="username"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "admin-settings",
    data() {
        return {
            user_type: "admin",
            username: "Admin1"
        };
    },

    components: { NavBar }
}
</script>

<style></style>
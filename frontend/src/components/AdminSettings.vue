<template>
    <NavBar :usertype="user_type"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "admin-settings",
    data() {
        return {
            user_type: "admin"
        };
    },

    components: { NavBar }
}
</script>

<style></style>
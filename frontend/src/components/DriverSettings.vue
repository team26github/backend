<template>
    <NavBar :usertype="user_type" :userid="username"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "driver-settings",
    data() {
        return {
            user_type: "driver",
            username: "Driver1"
        };
    },

    components: { NavBar }
}
</script>

<style scoped></style>
<template>
    <NavBar :usertype="user_type" :userid="username"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "sponsor-settings",
    data() {
        return {
            user_type: "sponsor",
            username: "Sponsor1"
        };
    },

    components: { NavBar }
}
</script>

<style scoped></style>
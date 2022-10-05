<template>
    <NavBar :usertype="user_type"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "sponsor-settings",
    data() {
        return {
            user_type: "sponsor"
        };
    },

    components: { NavBar }
}
</script>

<style></style>
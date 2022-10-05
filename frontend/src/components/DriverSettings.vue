<template>
    <NavBar :usertype="user_type"></NavBar>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "driver-settings",
    data() {
        return {
            user_type: "driver"
        };
    },

    components: { NavBar }
}
</script>

<style></style>
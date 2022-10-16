<template>
    <NavBar :usertype="user_type" :userid="user_id"></NavBar>
    <div class="catalog-container">
        <div class="row">
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
        </div>
        <div class="row">
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
            <div class="catalog-item-container">
                Item 4
            </div>
            <div class="catalog-item-container">
                Item 3
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from "./NavBar.vue";

    export default {
    name: "user-catalog",
    data() {
        return {
            user_type: "driver",
            user_id: 1
        };
    },
    components: { NavBar }
}
</script>

<style scoped>
    .catalog-container {
        width: 99vw;
        height: 90vh;
        border-style: solid;
        border-color: black;
    }

    .catalog-item-container {
        display: grid;
        place-items: center;
        border-style: solid;
        border-color: black;
        width: 8vw;
        height: 7vw;
    }

    .row {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: left;
        margin: 1rem;
        gap: 1rem;
    }
</style>
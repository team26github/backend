<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
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
    import axios from 'axios';

    export default {
    name: "user-catalog",
    data() {
        return {
            user_type: null,
            user_id: null,
            username: null,
            catalog_filters: null,
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
        this.path = this.production_path;

        axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        console.log(res.data);
                        this.user_id = res.data.results[0][0];
                        this.user_type = res.data.results[0][2];
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
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

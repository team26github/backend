<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
    <div class="catalog-container">
            <div v-for="item in catalog_items" :key="item" class="catalog-item-container">
                <img v-if="'image' in item" src={{item.image.imageUrl}}/>
                <p><strong>Item:</strong> {{item.title}}</p>
                <p><strong>Price:</strong> {{(item.price.value * this.point_conversion).toFixed(2)}} points</p>
                <a href={{item.itemWebUrl}}>Check it out!</a>
            </div>
    </div>
</template>

<script>
    import NavBar from "../misc/NavBar.vue";
    import axios from 'axios';

    export default {
    name: "user-catalog",
    data() {
        return {
            user_type: null,
            user_id: null,
            username: null,
            catalog_filters: null,
            point_conversion: null,
            catalog_items: [],
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
        this.path = this.localhost_path;

        axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.user_id = res.data.results[0][0];
                        this.user_type = res.data.results[0][2];
                        this.point_conversion = res.data.results[0][8];
                        this.catalog_filters = res.data.results[0][10].split(',');

                        let keywords = '';
                        for (let i = 0; i < this.catalog_filters.length - 1; i++) {
                            keywords += this.catalog_filters[i] + ',';
                        }
                        keywords += this.catalog_filters[this.catalog_filters.length - 1];

                        axios.get(this.path + '/get-catalog-items', {params: {keywords: keywords}})
                            .then((res) => {
                                let results = res.data.results;

                                for (let item of results) {
                                    this.catalog_items.push(item);
                                }
                            })
                            .catch((err) => {
                                console.log(err);
                            })
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
        display: flex;
        flex-wrap: wrap;
        width: 99vw;
        height: 90vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        overflow-y: auto;
        background-color:palegreen;
    }

    .catalog-item-container {
        border-style: solid;
        border-color: black;
        overflow: auto;
        padding: 0 0 0.5rem 0.5rem;
        width: 8vw;
        height: 7vw;
        margin: 1rem 1rem 0;
        background-color: white;
    }
</style>

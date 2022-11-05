<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
    <div class="options">
        <label class="filters-label">Filters:</label>
        <select class="filters" @change="get_filter($event)"> 
            <option value="All" selected>All</option>
            <option v-for="filter in catalog_filters" :key="filter">{{ filter }}</option>
        </select>
        <input type="text" placeholder="Search"/>
    </div>
    <div class="catalog-container" :key="update">
        <div v-for="item in catalog_items" :key="item" class="catalog-item-container">
            <img class="item-img" v-if="'image' in item" :src="item.image.imageUrl"/>
            <p><strong>Item:</strong> {{item.title}}</p>
            <p><strong>Price:</strong> {{(item.price.value * this.point_conversion).toFixed(2)}} points</p>
            <a :href="item.itemWebUrl" target="_blank">Check it Out!</a>
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
            selected_filter: null,
            point_conversion: null,
            update: 0,
            catalog_items: null,
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
                        this.get_catalog_items();
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
    },

    methods: {
        get_filter(event) {
            this.selected_filter = event.target.value;
            this.get_catalog_items();
            this.update += 1;
        },

        get_catalog_items() {
            let keywords = '';
            this.catalog_items = [];

            if (this.selected_filter === null || this.selected_filter === 'All') {
                for (let i = 0; i < this.catalog_filters.length - 1; i++) {
                    keywords += this.catalog_filters[i] + ',';
                }
                
                keywords += this.catalog_filters[this.catalog_filters.length - 1];
            }
            else keywords += this.selected_filter;

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
    },

    components: { NavBar }
}
</script>

<style scoped>
    .options {
        text-align: right;
        padding-right: 1rem;
    }

    .filters {
        margin-right: 0.5rem;
    }

    .filters-label {
        margin-right: 0.25rem;
    }

    .catalog-container {
        display: flex;
        flex-wrap: wrap;
        width: 96.5vw;
        height: 87vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        padding: 1rem;
        overflow-y: auto;
        background-color:palegreen;
    }

    .catalog-item-container {
        border-style: solid;
        border-color: black;
        overflow: auto;
        padding: 0.5rem;
        width: 8.25vw;
        height: 8.25vw;
        background-color: white;
    }

    .item-img {
        width: 100%;
        height: 100%;
        justify-content: center;
    }
</style>

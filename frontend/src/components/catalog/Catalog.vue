<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
    <div class="options">
        <label>Filters:</label>
        <select class="filters" @change="get_filter($event)"> 
            <option value="All" selected>All</option>
            <option v-for="filter in catalog_filters" :key="filter">{{ filter }}</option>
        </select>
        <input class="filters" type="text" placeholder="Search" v-model="search_text"/>
        <button type="submit" @click="search()">Search</button>
        <button class="cart" @click="checkout()">Checkout</button>
        <p class="cart">Items in Cart: {{ num_in_cart }}</p>
    </div>
    <div class="catalog-container" :key="update">
        <div v-for="item in catalog_items" :key="item" class="catalog-item-container">
            <img class="item-img" v-if="'image' in item" :src="item.image.imageUrl"/>
            <p><strong>Item:</strong> {{item.title}}</p>
            <p><strong>Price:</strong> {{(item.price.value * this.point_conversion).toFixed(2)}} points</p>
            <a :href="item.itemWebUrl" target="_blank">Check it Out!</a>
            <button @click="add_to_cart(item)">Add to Cart</button>
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
            search_text: null,
            point_conversion: null,
            update: 0,
            cart: [],
            cost: 0,
            num_in_cart: 0,
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
                    //console.log(results);

                    for (let item of results) {
                        this.catalog_items.push(item);
                    }
                })
                .catch((err) => {
                    console.log(err);
                })            
        },

        search() {
            if (this.search_text !== null && this.search_text !== "") {

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
                            if (item.title.toLowerCase().includes(this.search_text.toLowerCase())) {
                                this.catalog_items.push(item);
                            }
                        }
                        
                        this.update += 1;
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            }
        },

        add_to_cart(item) {
            if (this.cart.indexOf(item) === -1) {
                this.cart.push(item);
                this.num_in_cart += 1;
                this.cost += (item.price.value * this.point_conversion).toFixed(2);
            }
        },

        checkout() {
            let content = { username: this.username, cart: this.cart, cost: this.cost };            

            this.$router.push({
                name: 'cart-checkout',
                params: { params: content }
            });
        }
    },

    components: { NavBar }
}
</script>

<style scoped>
    .options {
        float: left;
    }

    .options p {
        display: inline-block;
        width: auto;
        margin-right: 0.5rem;
    }

    .filters {
        margin: 0.25rem 0 0.25rem 0.5rem;
    }

    .cart {
        float: right;
        margin: 0.25rem 0.2rem 0.25rem 0;
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

    .catalog-item-container button {
        margin-top: 1em;
    }

    .item-img {
        width: 100%;
        height: 100%;
        justify-content: center;
    }
</style>

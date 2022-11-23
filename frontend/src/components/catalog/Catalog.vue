<template>
    <NavBar :usertype="user_type" :username="username"></NavBar>
    <!-- Row to hold options for the user such as filters and item searching -->
    <div class="options">

        <!-- Filters dropdown menu based on what the sponsor specifications are -->
        <label>Filters:</label>
        <select class="filters" @change="get_filter($event)"> 
            <option value="All" selected>All</option>
            <option v-for="filter in catalog_filters" :key="filter">{{ filter }}</option>
        </select>

        <!-- Search box and button for the user to search for specific items -->
        <input class="filters" type="text" placeholder="Search" v-model="search_text"/>
        <button type="submit" @click="search()">Search</button>

        <!-- Button to send user to checkout screen and number showing how many items are in their cart -->
        <button class="cart" @click="checkout()">Checkout</button>
        <p class="cart">Items in Cart: {{ num_in_cart }}</p>
    </div>

    <!-- Container to hold items in the catalog -->
    <div class="catalog-container" :key="update">

        <!-- Item(s) in the catalog available for user purchase. If there are more than one catalog item available
            for purchase, then multiple containers will be rendered -->
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

        // Component name
        name: "user-catalog",

        // Component specific variables and data
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
                cost: 0.0,
                num_in_cart: 0,
                catalog_items: null,
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {
            this.username = this.$route.params.username;
            this.path = this.localhost_path;

            // Axios API call to python backend to get user information from the database
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

        // Component specific methods
        methods: {

            // Getting user selected filters
            get_filter(event) {
                this.selected_filter = event.target.value;
                this.get_catalog_items();
                this.update += 1;
            },

            // Getting items for the catalog
            get_catalog_items() {
                let keywords = '';
                this.catalog_items = [];

                // If there is a filter applied, then the catalog will display only those
                // items that meet the filter requirements
                if (this.selected_filter === null || this.selected_filter === 'All') {
                    for (let i = 0; i < this.catalog_filters.length - 1; i++) {
                        keywords += this.catalog_filters[i] + ',';
                    }
                    
                    keywords += this.catalog_filters[this.catalog_filters.length - 1];
                }
                else keywords += this.selected_filter;

                // Axios API call to python backend to get catalog items from eBay
                axios.get(this.path + '/get-catalog-items', {params: {keywords: keywords}})
                    .then((res) => {
                        let results = res.data.results;
                        let temp = res.data.purchased;
                        let purchased = [];                    
                        
                        // Getting previously purchased items so they do not show up
                        // in the catalog display
                        for (let i = 0; i < temp.length; i++) {
                            temp[i][0] = temp[i][0].split(/{\d: |'|"|}|, \d: /g);
                        }

                        // Adding purchases to purchased array
                        for (let i = 0; i < temp.length; i++) {
                            for (let j = 0; j < temp[0].length; j++) {
                                for (let k = 0; k < temp[i][j].length; k++) {
                                    if (temp[i][j][k] !== "" && temp[i][j][k] !== " ") {
                                        purchased.push(temp[i][j][k]);
                                    }
                                }
                            }
                        }

                        // Adding catalog items to catalog_items array if they have not
                        // already been purchased
                        for (let item of results) {
                            let add = true;
                            for (let i = 0; i < purchased.length; i++) {
                                if (item.title === purchased[i]) add = false;
                            }
                            
                            if (add) this.catalog_items.push(item);
                            else add = true;
                        }
                    })
                    .catch((err) => {
                        console.log(err);
                    })            
            },

            // Method used for user search functionality
            search() {

                // If the search box is not empty
                if (this.search_text !== null && this.search_text !== "") {

                    let keywords = '';
                    this.catalog_items = [];

                    // If there is a filter as well as a search
                    if (this.selected_filter === null || this.selected_filter === 'All') {
                        for (let i = 0; i < this.catalog_filters.length - 1; i++) {
                            keywords += this.catalog_filters[i] + ',';
                        }
                        
                        keywords += this.catalog_filters[this.catalog_filters.length - 1];
                    }
                    else keywords += this.selected_filter;

                    // Axios API call to python backend to get catalog items based on search and filter parameters
                    axios.get(this.path + '/get-catalog-items', {params: {keywords: keywords}})
                        .then((res) => {
                            let results = res.data.results;

                            // If the items from the catalog has the text from the search box included in
                            // their title, then they are added to the catalog
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

            // Method to add items to the cart
            add_to_cart(item) {

                // If the item is not already in the cart, then it is added to the cart
                if (this.cart.indexOf(item) === -1) {
                    this.cart.push(item.title);
                    this.num_in_cart += 1;
                    this.cost += parseFloat((item.price.value * this.point_conversion).toFixed(2));
                }
            },

            // Method to route user to checkout page with cart information
            checkout() {
                this.$router.push({
                    name: 'cart-checkout',
                    params: { username: this.username, cart: JSON.stringify(this.cart), cost: this.cost }
                });
            }
        },

        // Components used from external files
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

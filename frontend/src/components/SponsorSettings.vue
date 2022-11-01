<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <h1>&nbsp;Sponsor Settings<br></h1>
        <div class="row">
            <div class="max_points">
                        <p><strong>Maximum Value of Driver Points: </strong>{{ max_points }}
                        <button @click="edit_max_points">Edit Maximum Points</button></p>
            </div>
        </div>  
        <div class="row">
            <div class="expiration_period">
                    <p><strong>Expiration Period of Driver Points: </strong>{{ expiration_period }} <strong> months </strong>
                    <button @click="edit_expiration">Edit Expiration Period</button></p>
            </div>
        </div> 
        <div class="row">
            <div class="catalog-item-points">
                <p><strong>Dollar to Point Conversion: </strong>$1 = {{ dollar_to_point_value }} point(s)</p>
                <button @click="edit_point_conversion">Edit Point Conversion</button>
            </div>
        </div>
        <div class="row">
            <div class="catalog-items">
                <p><strong>Catalog Filters:</strong></p>
                <p v-for="filter in catalog_filters" :key="filter">&nbsp;{{ filter }}</p>
                <button @click="edit_catalog">Edit Catalog Filters</button>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from './NavBar.vue';
    // import ButtonCounter from './ButtonCounter.vue'

    export default {
    name: "sponsor-settings",

    data() {
        return {
            user_type: "sponsor",
            username: null,
            max_points: null,
            expiration_period: null,
            user_id: null,
            dollar_to_point_value: null,
            catalog_filters: ["Phones,", "Watches"],
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
                    this.max_points = res.data.results[0][5];
                    this.expiration_period = res.data.results[0][6];
                    this.user_id = res.data.results[0][0];
                    this.dollar_to_point_value = res.data.results[0][8];
                }
                else {
                    console.log("Unsuccessful");
                }
            });
    },

    methods: {
        edit_max_points() {
            let new_max_points = window.prompt("Enter maximum value of points");
            axios.post(this.path + '/edit', null, {params: {request: 'max_points', max_points: new_max_points, userid: this.user_id}})
                .then((res) => {
                    if (res.data.status === "success") {
                        this.max_points = new_max_points;
                        console.log("success");
                        }
                    else {
                        window.alert("Maximum points change unsuccessful");
                        }
                    })
                .catch((error) => {
                    // esling-disable-next-line
                    console.log(error);
                })
        },
       
        edit_expiration() {
                let new_expiration_period = window.prompt("Enter new expiration period");
                axios.post(this.path + '/edit', null, {params: {request: 'expiration_period', expiration_period: new_expiration_period, userid: this.user_id}})
                .then((res) => {
                    if (res.data.status === "success") {
                        this.expiration_period = new_expiration_period;
                        window.alert("Expiration Period change successful");
                        }
                    else {
                        window.alert("Expiration Period change unsuccessful");
                        }
                        })
                .catch((error) => {
                    // esling-disable-next-line
                    console.log(error);
                })
        },

        edit_catalog() {
            axios.get(this.path + '/update_catalog_items', {params: {keywords: 'Samsung'}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        window.alert('Success');
                    }
                })
        },

        edit_point_conversion() {
            let conversion = window.prompt('Enter new point conversion (Ex: 1.5 -> $1 = 1.5 points)');
            axios.post(this.path + '/conversion', null, {params: {point_conversion: conversion, sponsorID: this.user_id}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        window.alert('Point conversion successful');
                        this.dollar_to_point_value = conversion;
                    }
                    else {
                        window.alert('Point conversion unsuccessful');
                        // Update in window
                    }
                })
                .catch((err) => {
                    // esling-disable-next-line
                    console.log(err);
                })
        }
    },
    components: { NavBar}
}
</script>


<style scoped>
    .profile-container {
        display: flex;
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: #73bfb8;
    }

    .row {
        width: 100%;
        height: 45px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
    }
    
    button {
        margin-right: 5px;
        margin-left: 5px;
    }
    .user-id-container, .username-container, .password-container, .email-container, .user-type-container, .drivers-list-container {
        display: flex;
        width: 49%;
        border-style: solid;
        border-color: black;
        justify-content: center;
        align-items: center;
    }
    .password, .username, .email {
        width: 100%;
    }
    .catalog-item-points, .catalog-items {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
</style>

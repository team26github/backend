<template>
    <div class="profile-container" v-if="!show_drivers" :key="show_drivers">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <h1 class="row">Sponsor Settings<br></h1>
        <div class="row">
            <div class="max_points">
                        <p><strong>Maximum Value of Driver Points: </strong>{{ max_points }}</p>
                        <button @click="edit_max_points"><span>Edit Maximum Points</span></button>
            </div>
        </div>  
        <div class="row">
            <div class="expiration_period">
                    <p><strong>Expiration Period of Driver Points: </strong>{{ expiration_period }} <strong> months </strong></p>
                    <button @click="edit_expiration"><span>Edit Expiration Period</span></button>
            </div>
        </div> 
        <div class="row">
            <div class="catalog-item-points">
                <p><strong>Dollar to Point Conversion: </strong>$1 = {{ dollar_to_point_value }} point(s)</p>
                <button @click="edit_point_conversion"><span>Edit Point Conversion</span></button>
            </div>
        </div>
        <div class="row">
            <div class="catalog-items">
                <p><strong>Catalog Filters:</strong></p>
                <p v-for="filter in catalog_filters" :key="filter">&nbsp;{{ filter }}</p>
                <button @click="edit_catalog"><span>Edit Catalog Filters</span></button>
            </div>
        </div>
        <div class="row">
            <div class="add-sponsor">
                <p><strong>Add New Sponsor:</strong></p>
                <button @click="go_to_new_sponsor"><span>Add New Sponsor</span></button>
            </div>
        </div>
        <div class="row">
            <div class="driver-profiles">
                <p><strong>View Driver Profiles</strong></p>
                <label class="drivers">Choose a Driver</label>
                <select class="drivers" @change="get_driver($event)">
                    <option value="All" selected>All</option>
                    <option v-for="driver in driver_info" :key="driver">{{ driver.full_name }}</option>
                </select>
                <button @click="show_drivers = !show_drivers"><span>{{ (show_drivers ? "Hide" : "View") }}</span></button>
            </div>
        </div>
        <div class="row">
            <div class="sponsor-reports">
                <p><strong>View Point Change Reports: </strong></p>
                <a href="https://app.powerbi.com/reportEmbed?reportId=f793ef90-40fc-44b6-8a7e-62879d982d19&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Power BI</a> 
            </div>
        </div>
    </div>

    <div class="profile-container" v-if="show_drivers" :key="show_drivers">
        <NavBar :usertype="user_type" :username="username" v-if="show_drivers"></NavBar>
        <div class="row2">
            <div class="settings-container">
                <h1 class="row2">Sponsor Settings<br></h1>
                <div class="row2">
                    <div class="max_points">
                        <p><strong>Maximum Value of Driver Points: </strong>{{ max_points }}</p>
                        <button @click="edit_max_points"><span>Edit Maximum Points</span></button>
                    </div>
                </div>  
                <div class="row2">
                    <div class="expiration_period">
                        <p><strong>Expiration Period of Driver Points: </strong>{{ expiration_period }} <strong> months </strong></p>
                        <button @click="edit_expiration"><span>Edit Expiration Period</span></button>
                    </div>
                </div> 
                <div class="row2">
                    <div class="catalog-item-points">
                        <p><strong>Dollar to Point Conversion: </strong>$1 = {{ dollar_to_point_value }} point(s)</p>
                        <button @click="edit_point_conversion"><span>Edit Point Conversion</span></button>
                    </div>
                </div>
                <div class="row2">
                    <div class="catalog-items">
                        <p><strong>Catalog Filters:</strong></p>
                        <p v-for="filter in catalog_filters" :key="filter">&nbsp;{{ filter }}</p>
                        <button @click="edit_catalog"><span>Edit Catalog Filters</span></button>
                    </div>
                </div>
                <div class="row2">
                    <div class="add-sponsor">
                        <p><strong>Add New Sponsor:</strong></p>
                        <button @click="go_to_new_sponsor"><span>Add New Sponsor</span></button>
                    </div>
                </div>
                <div class="row2">
                    <div class="driver-profiles">
                        <p><strong>View Driver Profiles</strong></p>
                        <label class="drivers">Choose a Driver</label>
                        <select class="drivers" @change="get_driver($event)">
                            <option value="All" selected>All</option>
                            <option v-for="driver in driver_info" :key="driver">{{ driver.full_name }}</option>
                        </select>
                        <button @click="show_drivers = !show_drivers"><span>{{ (show_drivers ? "Hide" : "View") }}</span></button>
                    </div>
                </div>
                <div class="row2">
                    <div class="sponsor-reports">
                        <p><strong>View Point Change Reports: </strong></p>
                        <a href="https://app.powerbi.com/reportEmbed?reportId=f793ef90-40fc-44b6-8a7e-62879d982d19&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Power BI</a> 
                    </div>
                </div>
            </div>
            <div class="driver-container" v-if="show_drivers">
                <div class="driver-info" v-for="driver in display_drivers()" :key="driver">
                    <p><strong>Full Name:</strong> {{ driver.full_name }}<input type="text" placeholder="New Name" v-model="new_driver['FullName']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Username:</strong> {{ driver.username }}<input type="text" placeholder="New Username" v-model="new_driver['Username']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Email:</strong> {{ driver.email }}<input type="text" placeholder="New Email" v-model="new_driver['Email']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ driver.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_driver['PointsLimit']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ driver.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_driver['ExpirationPeriod']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ driver.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_driver['SponsorID']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ driver.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_driver['DollarPointValue']" v-if="update_driver[driver.full_name]"/></p>
                    <button v-if="!update_driver[driver.full_name]" @click="update_driver[driver.full_name] = true" class="update-button"><span>Update</span></button>
                    <button v-else @click="update_info(driver, new_driver)" class="update-button"><span>Update</span></button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from '../misc/NavBar.vue';
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
            catalog_filters: null,
            selected_driver: "All",
            show_drivers: false,
            driver_info: [],
            new_driver: {
                'FullName': null,
                'Username': null,
                'Email': null,
                'PointsLimit': null,
                'ExpirationPeriod': null,
                'SponsorID': null,
                'DollarPointValue': null
            },
            update_driver: {},
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
                    this.catalog_filters = res.data.results[0][10].split(',');

                    this.get_info();
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
        
        go_to_new_sponsor() {
            this.$router.push({
                name: 'new-sponsor',
                params: { username: this.username }
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
            let filters = window.prompt(`Current filters for drivers are: ${this.catalog_filters}`);

            if (filters === null || filters === '') window.alert('You must have at least one active filter');
            else {
                axios.post(this.path + '/update-catalog-filters', null, {params: {catalog_filters: filters, user_id: this.user_id}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            this.catalog_filters = filters.split(',');
                            window.alert(`The new filters for drivers are: ${this.catalog_filters}`);
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            }
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
        },

        get_driver(event) {
            this.selected_driver = event.target.value;
        },

        display_drivers() {
            if (this.selected_driver === 'All') return this.driver_info;
            else {
                for (let d of this.driver_info) {
                    if (d.full_name === this.selected_driver) return [d];
                }
            }
        },

        update_info(old_driver, new_driver) {
            let data = {}

            for (let key of Object.keys(new_driver)) {
                if (new_driver[key] !== null) {
                    data[key] = new_driver[key];
                }
            }

            console.log(data);

            axios.post(this.path + '/update-info', null, {params: {update_data: data, user_id: old_driver.user_id}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.update_driver[old_driver.full_name] = false;

                        this.new_driver = {
                            'FullName': null,
                            'Username': null,
                            'Email': null,
                            'PointsLimit': null,
                            'ExpirationPeriod': null,
                            'SponsorID': null,
                            'DollarPointValue': null
                        }

                        this.get_info();
                    }
                })
                .catch((err) => {
                    console.log(err);
                });
        },

        get_info() {
            axios.get(this.path + '/info', { params: { username: this.username } })
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.driver_info = [];

                        for (const info of res.data.results.drivers) {
                            let driver = {};

                            if (info[7] === this.user_id) {
                                driver['user_id'] = info[0];
                                driver['user_type'] = info[2];
                                driver['email'] = info[3];
                                driver['username'] = info[4];
                                driver['points_limit'] = info[5];
                                driver['expiration_period'] = info[6];
                                driver['sponsor_id'] = info[7];
                                driver['dollar_point_value'] = info[8];
                                driver['full_name'] = info[9];

                                this.update_driver[driver.full_name] = false;
                                this.driver_info.push(driver);
                            }
                        }
                    }
                })
        }
    },
    components: { NavBar }
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

    .profile-container2 {
        display: flex;
        flex-direction: row;
        width: 98.5vw;
        height: 95vh;
        border-style: none solid solid solid;
        border-color: black;
        gap: 1rem;
        background-color: #73bfb8;
    }

    .settings-container {
        display: flex;
        flex-direction: column;
        width: 50%;
        height: 97.5vh;
        gap: 1rem;
    }

    .row {
        width: 100%;
        height: 45px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
    }

    .row2 {
        width: 100%;
        height: auto;
        display: flex;
        flex-direction: row;
        justify-content: flex-start;
        gap: 1rem;
        margin-left: 5px;
    }
    
    button {
        margin-right: 5px;
        margin-left: 5px;
        margin-left: 5px;
        display: block;
        width: 200px;
        height: 30px;
        font-size: 13px;
        text-decoration: none;
        color: black;
        border: 2px solid black;
        letter-spacing: 1px;
        text-align: center;
        position: relative;
        transition: all 0.35s;
    }

    button span {
        position: relative;
        z-index: 2;
    }

    button::after {
        position: absolute;
        content: "";
        top: 0;
        left: 0;
        width: 0;
        height: 100%;
        background: darkorange;
        transition: all 0.35s;
    }

    button:hover {
        color: white;
        cursor: pointer;
    }

    button:hover::after {
        width: 100%;
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

    .expiration_period, .max_points, .add-sponsor {
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .driver-profiles {
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .drivers {
        margin-left: 5px;
    }

    .driver-container {
        display: flex;
        flex-direction: column;
        width: 30%;
        height: 80%;
        overflow-y: auto;
        border-style: solid;
        border-color: black;
        align-items: center;
        margin-top: 3%;
    }

    .driver-info {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: auto;
        align-items: flex-start;
        border-style: solid none none none;
        border-color: black;
    }

    .driver-info p {
        margin-left: 5%;
        width: 100%;
    }

    .driver-info p input {
        display: flex;
        margin-right: 5%;
        margin-top: 1%;
    }

    .update-button {
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin-left: 5%;
        margin-bottom: 1.5rem;
        align-items: center;
    }
</style>

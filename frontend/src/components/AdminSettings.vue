<template>
    <div class="settings-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <div class="row">
            <h1>Admin Settings</h1>
        </div>
        <div class="row">
            <div class="driver-profiles-permissions">
                <p><strong>View Driver Profiles & Permissions</strong></p>
                <label class="drivers">Choose a Driver:</label>
                <select class="drivers" @change="get_driver($event)">
                    <option value="All" selected>All</option>
                    <option v-for="driver in driver_info" :key="driver">{{ driver.full_name }}</option>
                </select>
                <button @click="show_drivers = !show_drivers">{{ (show_drivers ? "Hide" : "View") }}</button>
                <button @click="go_to_new_driver">Add New Driver</button>
            </div>
        </div>
        <div class="row">
            <div class="sponsor-profiles-permissions">
                <p><strong>View Sponsor Profiles & Permissions</strong></p>
                <label class="sponsors">Choose a Sponsor:</label>
                <select class="sponsors" @change="get_sponsor($event)">
                    <option value="All" selected>All</option>
                    <option v-for="sponsor in sponsor_info" :key="sponsor">{{ sponsor.full_name }}</option>
                </select>
                <button @click="show_sponsors = !show_sponsors">{{ (show_sponsors ? "Hide" : "View") }}</button>
                <button @click="go_to_new_sponsor">Add New Sponsor</button>
            </div>
        </div>
        <div class="row">
            <div class="admin-profiles-permissions">
                <p><strong>View Admin Profiles & Permissions</strong></p>
                <label class="admins">Choose an Admin:</label>
                <select class="admins" @change="get_admin($event)">
                    <option value="All" selected>All</option>
                    <option v-for="admin in admin_info" :key="admin">{{ admin.full_name }}</option>
                </select>
                <button @click="show_admins = !show_admins;">{{ (show_admins ? "Hide" : "View") }}</button>
                <button @click="go_to_new_admin">Add New Admin</button>
            </div>
        </div>
        <div class="info-row">
            <div class="driver-container" v-if="show_drivers">
                <div class="driver-info" v-for="driver in display_drivers()" :key="driver">
                    <p><strong>Full Name:</strong> {{ driver.full_name }}</p>
                    <p><strong>Username:</strong> {{ driver.username }}</p>
                    <p><strong>Email:</strong> {{ driver.email }}</p>
                    <p><strong>Points Limit:</strong> {{ driver.points_limit }} points</p>
                    <p><strong>Expiration Period:</strong> {{ driver.expiration_period }} months</p>
                    <p><strong>Sponsor ID(s):</strong> {{ driver.sponsor_id }}</p>
                    <p><strong>Point Conversion:</strong> {{ driver.dollar_point_value }} points = $1</p>
                </div>
            </div>
            <div class="sponsor-container" v-if="show_sponsors">
                <div class="sponsor-info" v-for="sponsor in display_sponsors()" :key="sponsor">
                    <p><strong>Full Name:</strong> {{ sponsor.full_name }}</p>
                    <p><strong>Username:</strong> {{ sponsor.username }}</p>
                    <p><strong>Email:</strong> {{ sponsor.email }}</p>
                    <p><strong>Points Limit:</strong> {{ sponsor.points_limit }} points</p>
                    <p><strong>Expiration Period:</strong> {{ sponsor.expiration_period }} months</p>
                    <p><strong>Sponsor ID(s):</strong> {{ sponsor.sponsor_id }}</p>
                    <p><strong>Point Conversion:</strong> {{ sponsor.dollar_point_value }} points = $1</p>
                </div>
            </div>
            <div class="admin-container" v-if="show_admins">
                <div class="admin-info" v-for="admin in display_admins()" :key="admin">
                    <p><strong>Full Name:</strong> {{ admin.full_name }}</p>
                    <p><strong>Username:</strong> {{ admin.username }}</p>
                    <p><strong>Email:</strong> {{ admin.email }}</p>
                    <p><strong>Points Limit:</strong> {{ admin.points_limit }} points</p>
                    <p><strong>Expiration Period:</strong> {{ admin.expiration_period }} months</p>
                    <p><strong>Sponsor ID(s):</strong> {{ admin.sponsor_id }}</p>
                    <p><strong>Point Conversion:</strong> {{ admin.dollar_point_value }} points = $1</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from './NavBar.vue';
    import axios from 'axios';

    export default {
    name: "admin-settings",
    data() {
        return {
            user_type: "admin",
            username: null,
            driver_info: [],
            sponsor_info: [],
            admin_info: [],
            show_drivers: false,
            show_sponsors: false,
            show_admins: false,
            selected_driver: 'All',
            selected_sponsor: 'All',
            selected_admin: 'All',
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
        this.path = this.localhost_path;

        axios.get(this.path + '/info', { params: { username: this.username } })
            .then((res) => {
                if (res.data.status === 'success') {
                    for (const info of res.data.results.drivers) {
                        let driver = {};

                        driver['user_id'] = info[0];
                        driver['user_type'] = info[2];
                        driver['email'] = info[3];
                        driver['username'] = info[4];
                        driver['points_limit'] = info[5];
                        driver['expiration_period'] = info[6];
                        driver['sponsor_id'] = info[7];
                        driver['dollar_point_value'] = info[8];
                        driver['full_name'] = info[9];

                        this.driver_info.push(driver);
                    }

                    for (const info of res.data.results.sponsors) {
                        let sponsor = {};

                        sponsor['user_id'] = info[0];
                        sponsor['user_type'] = info[2];
                        sponsor['email'] = info[3];
                        sponsor['username'] = info[4];
                        sponsor['points_limit'] = info[5];
                        sponsor['expiration_period'] = info[6];
                        sponsor['sponsor_id'] = info[7];
                        sponsor['dollar_point_value'] = info[8];
                        sponsor['full_name'] = info[9];

                        this.sponsor_info.push(sponsor);
                    }

                    for (const info of res.data.results.admins) {
                        let admin = {};

                        admin['user_id'] = info[0];
                        admin['user_type'] = info[2];
                        admin['email'] = info[3];
                        admin['username'] = info[4];
                        admin['points_limit'] = info[5];
                        admin['expiration_period'] = info[6];
                        admin['sponsor_id'] = info[7];
                        admin['dollar_point_value'] = info[8];
                        admin['full_name'] = info[9];

                        this.admin_info.push(admin);
                    }
                }
            })
            .catch((error) => {
                console.log(error);
            })
    },

    methods: {
        get_driver(event) {
            this.selected_driver = event.target.value;
            console.log(this.selected_driver);
        },
        
        get_sponsor(event) {
            this.selected_sponsor = event.target.value;
            console.log(this.selected_sponsor);
        },

        get_admin(event) {
            this.selected_admin = event.target.value;
            console.log(this.selected_admin);
        },

        display_drivers() {
            if (this.selected_driver === 'All') return this.driver_info;
            else {
                for (let d of this.driver_info) {
                    if (d.full_name === this.selected_driver) return [d];
                }
            }
        },

        display_sponsors() {
            if (this.selected_sponsor === 'All') return this.sponsor_info;
            else {
                for (let s of this.sponsor_info) {
                    if (s.full_name === this.selected_sponsor) return [s];
                }
            }
        },

        display_admins() {
            if (this.selected_admin === 'All') return this.admin_info;
            else {
                for (let a of this.admin_info) {
                    if (a.full_name === this.selected_admin) return [a];
                }
            }
        },

        go_to_new_driver() {
            this.$router.push({
                name: 'new-driver',
                params: { username: this.username }
            })
        },

        go_to_new_sponsor() {
            this.$router.push({
                name: 'new-sponsor',
                params: { username: this.username }
            })
        },
        
        go_to_new_admin() {
            this.$router.push({
                name: 'new-admin',
                params: { username: this.username }
            })
        }
    },

    components: { NavBar }
}
</script>

<style scoped>
    .settings-container {
        display: flex;
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: darkorange;
    }

    .row {
        width: 100%;
        height: 45px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 2rem;
    }

    .info-row {
        width: 100%;
        height: 50vh;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 2rem;
    }
    
    button {
        margin-right: 5px;
        margin-left: 5px;
    }

    .driver-profiles-permissions, .sponsor-profiles-permissions, .admin-profiles-permissions {
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .drivers, .sponsors, .admins {
        margin-left: 5px;
    }

    .driver-container, .sponsor-container, .admin-container {
        display: flex;
        flex-direction: column;
        width: 30%;
        height: 100%;
        overflow-y: auto;
        border-style: solid;
        border-color: black;
        align-items: center;
    }

    .driver-info, .sponsor-info, .admin-info {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: auto;
        align-items: left;
        border-style: solid solid none solid;
        border-color: black;
    }

    .driver-info p, .sponsor-info p, .admin-info p {
        margin-left: 5%;
    }
</style>
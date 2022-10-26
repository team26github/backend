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
                <select class="drivers">
                    <option value="All" selected>All</option>
                    <option v-for="driver in driver_info" :key="driver">{{ driver[4] }}</option>
                </select>
                <button @click="show_drivers = !show_drivers">{{ (show_drivers ? "Hide" : "View") }}</button>
                <button @click="go_to_new_driver">Add New Driver</button>
            </div>
        </div>
        <div class="row">
            <div class="sponsor-profiles-permissions">
                <p><strong>View Sponsor Profiles & Permissions</strong></p>
                <label class="sponsors">Choose a Sponsor:</label>
                <select class="sponsors">
                    <option value="All" selected>All</option>
                    <option v-for="sponsor in sponsor_info" :key="sponsor">{{ sponsor[4] }}</option>
                </select>
                <button @click="show_sponsors = !show_sponsors">{{ (show_sponsors ? "Hide" : "View") }}</button>
                <button @click="go_to_new_sponsor">Add New Sponsor</button>
            </div>
        </div>
        <div class="row">
            <div class="admin-profiles-permissions">
                <p><strong>View Admin Profiles & Permissions</strong></p>
                <label class="admins">Choose an Admin:</label>
                <select class="admins">
                    <option value="All" selected>All</option>
                    <option v-for="admin in admin_info" :key="admin">{{ admin[4] }}</option>
                </select>
                <button @click="show_admins = !show_admins;">{{ (show_admins ? "Hide" : "View") }}</button>
                <button @click="go_to_new_admin">Add New Admin</button>
            </div>
        </div>
        <div class="row">
            <div class="driver-container" v-if="show_drivers">
                <div class="driver-info" v-for="driver in driver_info" :key="driver">
                    <p><strong>Full Name:</strong></p>
                    <p><strong>Username:</strong> {{ driver[4] }}</p>
                    <p><strong>Email:</strong> {{ driver[3] }}</p>
                    <p><strong>Points Limit:</strong> {{ driver[5] }}</p>
                    <p><strong>Expiration Period:</strong> {{ driver[6] }}</p>
                    <p><strong>Sponsor(s):</strong> {{ driver[7] }}</p>
                    <p><strong>Point Conversion:</strong> {{ driver[8] }}</p>
                </div>
            </div>
            <div class="sponsor-container" v-if="show_sponsors">
                <div class="sponsor-info" v-for="sponsor in sponsor_info" :key="sponsor">
                    <p><strong>Full Name:</strong></p>
                    <p><strong>Username:</strong> {{ sponsor[4] }}</p>
                    <p><strong>Email:</strong> {{ sponsor[3] }}</p>
                    <p><strong>Points Limit:</strong> {{ sponsor[5] }}</p>
                    <p><strong>Expiration Period:</strong> {{ sponsor[6] }}</p>
                    <p><strong>Sponsor(s):</strong> {{ sponsor[7] }}</p>
                    <p><strong>Point Conversion:</strong> {{ sponsor[8] }}</p>
                </div>
            </div>
            <div class="admin-container" v-if="show_admins">
                <div class="admin-info" v-for="admin in admin_info" :key="admin">
                    <p><strong>Full Name:</strong></p>
                    <p><strong>Username:</strong> {{ admin[4] }}</p>
                    <p><strong>Email:</strong> {{ admin[3] }}</p>
                    <p><strong>Points Limit:</strong> {{ admin[5] }}</p>
                    <p><strong>Expiration Period:</strong> {{ admin[6] }}</p>
                    <p><strong>Sponsor(s):</strong> {{ admin[7] }}</p>
                    <p><strong>Point Conversion:</strong> {{ admin[8] }}</p>
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
                    console.log(res.data.results);

                    for (const info of res.data.results.drivers) {
                        this.driver_info.push(info);
                    }

                    for (const info of res.data.results.sponsors) {
                        this.sponsor_info.push(info);
                    }

                    for (const info of res.data.results.admins) {
                        this.admin_info.push(info);
                    }
                }
            })
            .catch((error) => {
                console.log(error);
            })
    },

    methods: {
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
        background-color: #ff90b3;
    }

    .row {
        width: 100%;
        height: 45px;
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
        height: 67vh;
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
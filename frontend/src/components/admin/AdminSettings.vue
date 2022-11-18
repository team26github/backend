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
                <button @click="show_drivers = !show_drivers"><span>{{ (show_drivers ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_driver"><span>Add New Driver</span></button>
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
                <button @click="show_sponsors = !show_sponsors"><span>{{ (show_sponsors ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_sponsor"><span>Add New Sponsor</span></button>
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
                <button @click="show_admins = !show_admins;"><span>{{ (show_admins ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_admin"><span>Add New Admin</span></button>
            </div>
        </div>
        <!--
        <div class="row">
            <div class="sponsor-point-spending">
                <p><strong>View Points Spent by Sponsors</strong></p>
                <label class="sponsor-points">Choose a Sponsor:</label>
                <select class="sponsor-points" @change="get_driver($event)">
                    <option value="All" selected>All</option>
                    <option v-for="sponsor in sponsor_info" :key="sponsor">{{ sponsor.full_name }}</option>
                </select>
                <button @click="show_sponsor_points = !show_sponsor_points">{{ (show_sponsor_points ? "Hide" : "View") }}</button>
            </div> 
        </div>
        -->
        <div class="reports-container">
            <div class="admin-reports">
                <p><strong>View Admin Reports: </strong></p>
                <a href="https://app.powerbi.com/reportEmbed?reportId=f793ef90-40fc-44b6-8a7e-62879d982d19&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Power BI</a> 
            </div>
            <div class="admin-audit-log">
                <p><strong>View Audit Log: </strong></p>
                <a href="https://app.powerbi.com/reportEmbed?reportId=065f774f-7112-4118-85fb-bc9abe7ee704&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Audit Log in PowerBI</a> 
            </div>
        </div>
        <div class="info-row">
            <div class="driver-container" v-if="show_drivers">
                <div class="driver-info" v-for="driver in display_drivers()" :key="driver">
                    <p><strong>Full Name:</strong> {{ driver.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Username:</strong> {{ driver.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Email:</strong> {{ driver.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ driver.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ driver.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ driver.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ driver.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_driver[driver.full_name]"/></p>
                    <button v-if="!update_driver[driver.full_name]" @click="update_driver[driver.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(driver, new_info)" class="update-button">Update</button>
                </div>
            </div>
            <div class="sponsor-container" v-if="show_sponsors">
                <div class="sponsor-info" v-for="sponsor in display_sponsors()" :key="sponsor">
                    <p><strong>Full Name:</strong> {{ sponsor.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Username:</strong> {{ sponsor.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Email:</strong> {{ sponsor.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ sponsor.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ sponsor.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ sponsor.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ sponsor.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <button v-if="!update_sponsor[sponsor.full_name]" @click="update_sponsor[sponsor.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(sponsor, new_info)" class="update-button">Update</button>
                </div>
            </div>
            <div class="admin-container" v-if="show_admins">
                <div class="admin-info" v-for="admin in display_admins()" :key="admin">
                    <p><strong>Full Name:</strong> {{ admin.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Username:</strong> {{ admin.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Email:</strong> {{ admin.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ admin.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ admin.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ admin.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ admin.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_admin[admin.full_name]"/></p>
                    <button v-if="!update_admin[admin.full_name]" @click="update_admin[admin.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(admin, new_info)" class="update-button">Update</button>
                </div>
            </div>
            <!--Not quite finished here, sponsor information still needed from DB
            <div class="sponsor-point-container" v-if="show_sponsor_points">
                <div class="sponsor-point-info" v-for="sponsor in display_sponsor_points()" :key="sponsor">
                    <p><strong>Sponsor:</strong> {{ sponsor.full_name }}</p>
                    <p><strong>Total Points Spent:</strong> {{ sponsor.total_points_spent }}</p>
                </div>
            </div>
            -->
        </div>
    </div>
</template>

<script>
    import NavBar from '../misc/NavBar.vue';
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
            new_info: {
                'FullName': null,
                'Username': null,
                'Email': null,
                'PointsLimit': null,
                'ExpirationPeriod': null,
                'SponsorID': null,
                'DollarPointValue': null
            },
            show_drivers: false,
            show_sponsors: false,
            show_admins: false,
            selected_driver: 'All',
            selected_sponsor: 'All',
            selected_admin: 'All',
            update_driver: {},
            update_sponsor: {},
            update_admin: {},
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
        this.path = this.localhost_path;
        this.get_info();
    },

    methods: {
        get_driver(event) {
            this.selected_driver = event.target.value;
        },
        
        get_sponsor(event) {
            this.selected_sponsor = event.target.value;
        },

        get_admin(event) {
            this.selected_admin = event.target.value;
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
        },

        get_info() {
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

                            this.update_driver[driver.full_name] = false;
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

                            this.update_sponsor[sponsor.full_name] = false;
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

                            this.update_admin[admin.full_name] = false;
                            this.admin_info.push(admin);
                        }
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
        },

        update_info(old_info, new_info) {
            let data = {}

            for (let key of Object.keys(new_info)) {
                if (new_info[key] !== null) {
                    data[key] = new_info[key];
                }
            }

            axios.post(this.path + '/update-info', null, {params: {update_data: data, user_id: old_info.user_id}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        //window.alert('User information updated successfully');
                        
                        if (old_info.user_type === 'Driver') this.update_driver[old_info.full_name] = false;
                        else if (old_info.user_type === 'Sponsor') this.update_sponsor[old_info.full_name] = false;
                        else this.update_admin[old_info.full_name] = false;

                        this.new_info = {
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
        background: lightskyblue;
        transition: all 0.35s;
    }

    button:hover {
        color: white;
        cursor: pointer;
    }

    button:hover::after {
        width: 100%;
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
        border-style: solid none none none;
        border-color: black;
    }

    .driver-info p, .sponsor-info p, .admin-info p {
        margin-left: 5%;
        width: 100%;
    }

    .driver-info p input, .sponsor-info p input, .admin-info p input {
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
        width: 60px;
    }

    .reports-container {
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
    }
    .admin-reports-container {
        display: flex;
        justify-content: center;
        margin-bottom: 1rem;
    }

    .admin-reports {
        display: flex;
        flex-direction: column;
    }
</style>

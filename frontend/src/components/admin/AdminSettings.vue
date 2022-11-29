<template>
    <div class="settings-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <div class="row">
            <h1>Admin Settings</h1>
        </div>

        <!-- Row to hold driver profile information header, driver selection dropdown menu, 
            view button, and add new driver button -->
        <div class="row">
            <div class="driver-profiles-permissions">
                
                <!-- Header -->
                <p><strong>View Driver Profiles & Permissions</strong></p>

                <!-- Dropdown Menu -->
                <label class="drivers">Choose a Driver:</label>
                <select class="drivers" @change="get_driver($event)">
                    <option value="All" selected>All</option>
                    <option v-for="driver in driver_info" :key="driver">{{ driver.full_name }}</option>
                </select>

                <!-- View/Hide and Add New Driver Buttons -->
                <button @click="show_drivers = !show_drivers"><span>{{ (show_drivers ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_driver"><span>Add New Driver</span></button>
            </div> 
        </div>

        <!-- Row to hold sponsor profile information header, sponsor selection dropdown menu, 
            view button, and add new sponsor button -->
        <div class="row">
            <div class="sponsor-profiles-permissions">

                <!-- Header -->
                <p><strong>View Sponsor Profiles & Permissions</strong></p>

                <!-- Dropdown Menu -->
                <label class="sponsors">Choose a Sponsor:</label>
                <select class="sponsors" @change="get_sponsor($event)">
                    <option value="All" selected>All</option>
                    <option v-for="sponsor in sponsor_info" :key="sponsor">{{ sponsor.full_name }}</option>
                </select>

                <!-- View/Hide and Add New Sponsor Buttons -->
                <button @click="show_sponsors = !show_sponsors"><span>{{ (show_sponsors ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_sponsor"><span>Add New Sponsor</span></button>
            </div>
        </div>

        <!-- Row to hold admin profile information header, admin selection dropdown menu, 
            view button, and add new admin button -->
        <div class="row">
            <div class="admin-profiles-permissions">

                <!-- Header -->
                <p><strong>View Admin Profiles & Permissions</strong></p>

                <!-- Dropdown Menu -->
                <label class="admins">Choose an Admin:</label>
                <select class="admins" @change="get_admin($event)">
                    <option value="All" selected>All</option>
                    <option v-for="admin in admin_info" :key="admin">{{ admin.full_name }}</option>
                </select>

                <!-- View/Hide and Add New Admin Buttons -->
                <button @click="show_admins = !show_admins;"><span>{{ (show_admins ? "Hide" : "View") }}</span></button>
                <button @click="go_to_new_admin"><span>Add New Admin</span></button>
            </div>
        </div>

        <!-- Row to hold driver fees information header, selection dropdown menu, and view button -->
        <div class="row">
            <div class="driver-fees-container">

                <!-- Header -->
                <p><strong>View Driver Fees</strong></p>

                <!-- Dropdown Menu -->
                <label class="driver-fees">Choose a Driver:</label>
                <select class="driver-fees" @change="get_driver_fee($event)">
                    <option value="All" selected>All</option>
                    <option v-for="driver in driver_fee_info" :key="driver">{{ driver.full_name }}</option>
                </select>

                <!-- View/Hide Driver Fees Button -->
                <button @click="show_driver_fees = !show_driver_fees"><span>{{ (show_driver_fees ? "Hide" : "View") }}</span></button>
            </div>
        </div>

        <!-- Row to hold sponsor fees information header, selection dropdown menu, and view button -->
        <div class="row">
            <div class="sponsor-fees-container">

                <!-- Header -->
                <p><strong>View Sponsor Fees</strong></p>

                <!-- Dropdown Menu -->
                <label class="sponsor-fees">Choose a Sponsor:</label>
                <select class="sponsor-fees" @change="get_sponsor_fee($event)">
                    <option value="All" selected>All</option>
                    <option v-for="sponsor in sponsor_info" :key="sponsor">{{ sponsor.full_name }}</option>
                </select>

                <!-- Show/Hide Sponsor Fees Button -->
                <button @click="show_sponsor_fees = !show_sponsor_fees"><span>{{ (show_sponsor_fees ? "Hide" : "View") }}</span></button>
            </div>
        </div>

        <!-- Row to hold Admin Power BI Reports -->
        <div class="reports-container">
            <div class="admin-reports">
                <p><strong>View Admin Reports: </strong></p>
                <a href="https://app.powerbi.com/reportEmbed?reportId=f793ef90-40fc-44b6-8a7e-62879d982d19&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Admin Reports in Power BI</a> 
            </div>
            <div class="admin-audit-log">
                <p><strong>View Audit Log: </strong></p>
                <a href="https://app.powerbi.com/reportEmbed?reportId=065f774f-7112-4118-85fb-bc9abe7ee704&autoAuth=true&ctid=0c9bf8f6-ccad-4b87-818d-49026938aa97" target="_blank"> Audit Log in PowerBI</a> 
            </div>
        </div>

        <!-- Row to hold driver/sponsor/admin information once show buttons are clicked -->
        <div class="info-row">

            <!-- Driver information container that is only shown if the "View" button is clicked
                for driver information -->
            <div class="driver-container" v-if="show_drivers">

                <!-- Information section(s) that are shown once the "View" button is clicked
                    for driver information. Multiple divs will be built upon rendering of the component
                    based upon how many drivers are present in the database or if there is a specific driver
                    selected -->
                <div class="driver-info" v-for="driver in display_drivers()" :key="driver">
                    <p><strong>Full Name:</strong> {{ driver.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Username:</strong> {{ driver.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>User ID:</strong> {{ driver.user_id }}</p>
                    <p><strong>Email:</strong> {{ driver.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ driver.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ driver.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ driver.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_driver[driver.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ driver.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_driver[driver.full_name]"/></p>
                    
                    <!-- First <p></p> tag will be rendered if the driver has not updated their password in the past, 
                        otherwise the second <p></p> tag will be rendered with the date of each past password change -->
                    <p v-if="driver.password_updates.length === 0"><strong>Password Change Dates:</strong> No Past Changes</p>
                    <p v-else><strong>Password Change Dates:</strong>
                        <ul>
                            <!-- If there has been more than one password change for a driver in the past, then 
                                multiple list items will be rendered instead of just one -->
                            <li v-for="change in driver.password_updates" :key="change">{{ change }}</li>
                        </ul>
                    </p>

                    <!-- First button is used to pull up update information screen, and the second button is used
                        to send updated information to the database to be changed -->
                    <button v-if="!update_driver[driver.full_name]" @click="update_driver[driver.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(driver, new_info)" class="update-button">Update</button>
                </div>
            </div>

            <!-- Sponsor information container that is only shown if the "View" button is clicked
                for sponsor information -->
            <div class="sponsor-container" v-if="show_sponsors">

                <!-- Information section(s) that are shown once the "View" button is clicked
                    for sponsor information. Multiple divs will be built upon rendering of the component
                    based upon how many sponsors are present in the database or if there is a specific sponsor
                    selected -->
                <div class="sponsor-info" v-for="sponsor in display_sponsors()" :key="sponsor">
                    <p><strong>Full Name:</strong> {{ sponsor.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Username:</strong> {{ sponsor.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>User ID:</strong> {{ sponsor.user_id }}</p>
                    <p><strong>Email:</strong> {{ sponsor.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ sponsor.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ sponsor.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ sponsor.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    
                    <!-- First <p></p> tag will be rendered if the sponsor has no drivers associated with them,
                        otherwise the second <p></p> tag will be rendered with each of the sponsors' drivers' names -->
                    <p v-if="sponsor.drivers.length === 0"><strong>Drivers:</strong> No Drivers</p>
                    <p v-else><strong>Drivers:</strong>
                        <ul>
                            <!-- If there is more than one driver associated with the sponsor, then 
                                multiple list items will be rendered instead of just one -->
                            <li v-for="driver in sponsor.drivers" :key="driver">{{ driver.full_name }}</li>
                        </ul>
                    </p>
                    <p><strong>Point Conversion:</strong> {{ sponsor.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_sponsor[sponsor.full_name]"/></p>
                    
                    <!-- First <p></p> tag will be rendered if the sponsor has not updated their password in the past, 
                        otherwise the second <p></p> tag will be rendered instead -->
                    <p v-if="sponsor.password_updates.length === 0"><strong>Password Change Dates:</strong> No Past Changes</p>
                    <p v-else><strong>Password Change Dates:</strong>
                        <ul>
                            <!-- If there has been more than one password change for a sponsor in the past, then 
                                multiple list items will be rendered instead of just one -->
                            <li v-for="change in sponsor.password_updates" :key="change">{{ change }}</li>
                        </ul>
                    </p>

                    <!-- First button is used to pull up update information screen, and the second button is used
                        to send updated information to the databse to be changed -->
                    <button v-if="!update_sponsor[sponsor.full_name]" @click="update_sponsor[sponsor.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(sponsor, new_info)" class="update-button">Update</button>
                </div>
            </div>

            <!-- Admin information container that is only shown if the "View" button is clicked
                for admin information -->
            <div class="admin-container" v-if="show_admins">

                <!-- Information section(s) that are shown once the "View" button is clicked
                    for admin information. Multiple divs will be built upon rendering of the component
                    based upon how many admins are present in the database that are not the current user
                    or if there is a specific admin selected -->
                <div class="admin-info" v-for="admin in display_admins()" :key="admin">
                    <p><strong>Full Name:</strong> {{ admin.full_name }}<input type="text" placeholder="New Name" v-model="new_info['FullName']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Username:</strong> {{ admin.username }}<input type="text" placeholder="New Username" v-model="new_info['Username']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>User ID:</strong> {{ admin.user_id }}</p>
                    <p><strong>Email:</strong> {{ admin.email }}<input type="text" placeholder="New Email" v-model="new_info['Email']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Points Limit:</strong> {{ admin.points_limit }} points<input type="text" placeholder="New Points Limit" v-model="new_info['PointsLimit']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Expiration Period:</strong> {{ admin.expiration_period }} months<input type="text" placeholder="New Expiration Period" v-model="new_info['ExpirationPeriod']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Sponsor ID(s):</strong> {{ admin.sponsor_id }}<input type="text" placeholder="New Sponsor ID" v-model="new_info['SponsorID']" v-if="update_admin[admin.full_name]"/></p>
                    <p><strong>Point Conversion:</strong> {{ admin.dollar_point_value }} points = $1<input type="text" placeholder="New Conversion Rate" v-model="new_info['DollarPointValue']" v-if="update_admin[admin.full_name]"/></p>
                    
                    <!-- First <p></p> tag will be rendered if the admin has not updated their password in the past, 
                        otherwise the second <p></p> tag will be rendered instead -->
                    <p v-if="admin.password_updates.length === 0"><strong>Password Change Dates:</strong> No Past Changes</p>
                    <p v-else><strong>Password Change Dates:</strong>
                        <ul>
                            <!-- If there has been more than one password change for a sponsor in the past, then 
                                multiple list items will be rendered instead of just one -->
                            <li v-for="change in admin.password_updates" :key="change">{{ change }}</li>
                        </ul>
                    </p>

                    <!-- First button is used to pull up update information screen, and the second button is used
                        to send updated information to the databse to be changed -->
                    <button v-if="!update_admin[admin.full_name]" @click="update_admin[admin.full_name] = true" class="update-button">Update</button>
                    <button v-else @click="update_info(admin, new_info)" class="update-button">Update</button>
                </div>
            </div>

            <!-- Driver fee information container that is only shown if the "View" button is clicked
                for driver information -->
            <div class="driver-fees-info-container" v-if="show_driver_fees">
                
                <!-- Information section(s) that are shown once the "View" button is clicked
                    for driver fee information. Multiple divs will be built upon rendering of the component
                    based upon how many drivers have made purchases or if there is a specific driver
                    selected -->
                <div class="driver-fees-info" v-for="driver in display_driver_fees()" :key="driver">
                    <p><strong>Full Name:</strong> {{ driver.full_name }}</p>
                    <p><strong>User ID:</strong> {{ driver.user_id }}</p>
                    <p><strong>Date Range:</strong> {{ start_date }} to {{ end_date }}</p>
                    <p><strong>Fee Generated:</strong> {{ driver.fee_generated }} Points </p>
                </div>
            </div>


            <div class="sponsor-fees-info-container" v-if="show_sponsor_fees">
                
                <!-- Information section(s) that are shown once the "View" button is clicked
                    for sponsor fee information. Multiple divs will be built upon rendering of the component
                    based upon how many drivers (associated with the sponsor) have made purchases as well as
                    the sponsor purchases or if there is a specific sponsor selected -->
                <div class="sponsor-fees-info" v-for="sponsor in display_sponsor_fees()" :key="sponsor">
                    <p><strong>Full Name:</strong> {{ sponsor.full_name }}</p>
                    <p><strong>User ID:</strong> {{ sponsor.user_id }}</p>
                    <p><strong>Total Points Spent:</strong> {{ sponsor.fee_generated }} Points</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '../misc/NavBar.vue';
    import axios from 'axios';

    export default {
    
    // Component name
    name: "admin-settings",

    // Component specific variables and data
    data() {
        return {
            user_type: "admin",
            username: null,
            driver_info: [],
            sponsor_info: [],
            admin_info: [],
            driver_fee_info: [],
            sponsor_fee_info: [],
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
            show_driver_fees: false,
            show_sponsor_fees: false,
            start_date: "September 1st",
            end_date: "Today",
            selected_driver: 'All',
            selected_sponsor: 'All',
            selected_admin: 'All',
            selected_driver_fee: 'All',
            selected_sponsor_fee: 'All',
            update_driver: {},
            update_sponsor: {},
            update_admin: {},
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
    },

    // Mounted function is used for doing operations right after the component
    // Is mounted and right before the component is shown to the user
    mounted() {
        this.username = this.$route.params.username;
        this.path = this.production_path;
        this.get_info();
    },

    // Component specific methods
    methods: {

        // get_driver/sponsor/admin/driver_fee/sponsor_fee are methods
        // that get a specific selected user from the dropdown menus
        get_driver(event) {
            this.selected_driver = event.target.value;
        },
        
        get_sponsor(event) {
            this.selected_sponsor = event.target.value;
        },

        get_admin(event) {
            this.selected_admin = event.target.value;
        },

        get_driver_fee(event) {
            this.selected_driver_fee = event.target.value;
        },

        get_sponsor_fee(event) {
            this.selected_sponsor_fee = event.target.value;
        },

        // display_drivers/sponsors/admins/driver_fees/sponsor_fees returns information
        // about the selected user so that the template can render correctly. If "All"
        // is selected in the dropdown menu, then all users are returned, otherwise these
        // methods search through the information arrays and return the specified user and
        // their corresponding information from the array
        display_drivers() {
            if (this.selected_driver === 'All') return this.driver_info;
            else {
                for (let d of this.driver_info) {
                    if (d.full_name === this.selected_driver) return [d];
                }
                return [];
            }
        },

        display_sponsors() {
            if (this.selected_sponsor === 'All') return this.sponsor_info;
            else {
                for (let s of this.sponsor_info) {
                    if (s.full_name === this.selected_sponsor) return [s];
                }
                return [];
            }
        },

        display_admins() {
            if (this.selected_admin === 'All') return this.admin_info;
            else {
                for (let a of this.admin_info) {
                    if (a.full_name === this.selected_admin) return [a];
                }
                return [];
            }
        },

        display_driver_fees() {
            if (this.selected_driver_fee === 'All') return this.driver_fee_info;
            else {
                for (let d of this.driver_fee_info) {
                    if (d.full_name === this.selected_driver_fee) return [d];
                }
                return [];
            }
        },

        display_sponsor_fees() {
            console.log(this.selected_sponsor_fee);
            if (this.selected_sponsor_fee === 'All') return this.sponsor_fee_info;
            else {
                for (let s of this.sponsor_fee_info) {
                    if (s.full_name === this.selected_sponsor_fee) return [s];
                }
                return [];
            }
        },

        // go_to_new_driver/sponsor/admin routes the user from admin settings
        // to a new user page so they can add a new user
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

        // Gets display information from the database
        get_info() {

            // Axios API call to python backend to get driver/sponsor/admin information
            axios.get(this.path + '/info', { params: { username: this.username } })
                .then((res) => {
                    if (res.data.status === 'success') {

                        this.driver_info = [];
                        for (const info of res.data.results.drivers) {
                            let driver = {};

                            // Setting driver information based on information gathered
                            // from the database
                            driver['user_id'] = info[0];
                            driver['user_type'] = info[2];
                            driver['email'] = info[3];
                            driver['username'] = info[4];
                            driver['points_limit'] = info[5];
                            driver['expiration_period'] = info[6];
                            driver['sponsor_id'] = info[7];
                            driver['dollar_point_value'] = info[8];
                            driver['full_name'] = info[9];

                            // Setting driver password update information based on information
                            // gethered from the database
                            let pw_update = [];
                            for (const update of res.data.results.password_updates) {
                                if (parseInt(update[1]) === driver['user_id']) pw_update.push(update[0])
                            }
                            driver['password_updates'] = pw_update;

                            this.update_driver[driver.full_name] = false;
                            this.driver_info.push(driver);
                        }

                        this.sponsor_info = [];
                        for (const info of res.data.results.sponsors) {
                            let sponsor = {};

                            // Setting sponsor information based on information gathered
                            // from the database
                            sponsor['user_id'] = info[0];
                            sponsor['user_type'] = info[2];
                            sponsor['email'] = info[3];
                            sponsor['username'] = info[4];
                            sponsor['points_limit'] = info[5];
                            sponsor['expiration_period'] = info[6];
                            sponsor['sponsor_id'] = info[7];
                            sponsor['dollar_point_value'] = info[8];
                            sponsor['full_name'] = info[9];

                            // Setting sponsor password update information based on information
                            // gethered from the database
                            let pw_update = [];
                            for (const update of res.data.results.password_updates) {
                                if (parseInt(update[1]) === sponsor['user_id']) pw_update.push(update[0])
                            }
                            sponsor['password_updates'] = pw_update;

                            // Getting drivers associated with each sponsor based on information
                            // gethered from the database
                            let drivers = [];
                            for (const d of this.driver_info) {
                                if (d.sponsor_id === sponsor.user_id) drivers.push({'full_name': d.full_name, 'user_id': d.user_id});
                            }
                            sponsor['drivers'] = drivers;

                            this.update_sponsor[sponsor.full_name] = false;
                            this.sponsor_info.push(sponsor);
                        }

                        this.admin_info = [];
                        for (const info of res.data.results.admins) {
                            let admin = {};

                            // Setting admin information based on information gathered
                            // from the database. Only admins that are not the current
                            // user are displayed
                            admin['user_id'] = info[0];
                            admin['user_type'] = info[2];
                            admin['email'] = info[3];
                            admin['username'] = info[4];
                            admin['points_limit'] = info[5];
                            admin['expiration_period'] = info[6];
                            admin['sponsor_id'] = info[7];
                            admin['dollar_point_value'] = info[8];
                            admin['full_name'] = info[9];

                            // Setting admin password update information based on information
                            // gethered from the database
                            let pw_update = [];
                            for (const update of res.data.results.password_updates) {
                                if (parseInt(update[1]) === admin['user_id']) pw_update.push(update[0])
                            }
                            admin['password_updates'] = pw_update;

                            this.update_admin[admin.full_name] = false;
                            this.admin_info.push(admin);
                        }

                        // Setting driver fee information based on information gathered
                        // from the database
                        this.driver_fee_info = [];
                        for (const info of res.data.results.driver_fee) {
                            let driver_fee = {};
                            let index = -1;

                            // If the driver has already been added to the array, then the index
                            // of this specific driver in the array is found in this loop
                            for (let i = 0; i < this.driver_fee_info.length; i++) {
                                if (info[2] === this.driver_fee_info[i]['user_id']) { 
                                    index = i;
                                    break;
                                }
                            }

                            // If the driver of this specific purchase has already been added to 
                            // the array, then the cost from this specific purchase is added the 
                            // fee generated for this specific driver
                            if (index !== -1) {
                                this.driver_fee_info[index]['fee_generated'] += parseFloat(info[1]);
                            }

                            // If the driver for this specific purchase is NOT already in the array,
                            // then a new javascript object is created with this specific driver's
                            // full name, user ID, and this specific purchase's fee as the key/value pairs
                            else {
                                let full_name = info[0];

                                for (let i = 0; i < this.driver_info.length; i++) {
                                    if (this.driver_info[i].user_id === info[2]) {
                                        full_name = this.driver_info[i].full_name;
                                        driver_fee['full_name'] = full_name;
                                        driver_fee['fee_generated'] = parseFloat(info[1]);
                                        driver_fee['user_id'] = info[2];

                                        this.driver_fee_info.push(driver_fee);
                                    }
                                }
                            }
                        }

                        // Gets driver IDs for drivers who have made purchases in the past
                        let driver_ids = [];
                        for (const driver of this.driver_fee_info) driver_ids.push(driver.user_id);

                        // Adds drivers with no purchases to the display array
                        for (const driver of this.driver_info) {
                            let in_array = false;

                            for (let i = 0; i < driver_ids.length; i++) {
                                if (driver.user_id === driver_ids[i]) {
                                    in_array = true;
                                    break;
                                }
                            }

                            if (!in_array) {
                                this.driver_fee_info.push({'full_name': driver.full_name, 'fee_generated': 0, 'user_id': driver.user_id});
                            }
                        }

                        // Setting driver fee information based on information gathered
                        // from the database
                        this.sponsor_fee_info = [];
                        for (const sponsor of this.sponsor_info) {
                            let sponsor_fee = {
                                'full_name': sponsor.full_name,
                                'fee_generated': 0.0,
                                'user_id': sponsor.user_id
                            };

                            // Adding drivers' associated with this specific sponsor fees to the sponsor fee array
                            for (const driver of sponsor.drivers) {
                                for (let i = 0; i < this.driver_fee_info.length; i++) {
                                    if(driver.user_id === this.driver_fee_info[i].user_id || sponsor.user_id === this.driver_fee_info[i].user_id) {
                                        sponsor_fee.fee_generated += this.driver_fee_info[i].fee_generated;
                                    }
                                }
                            }

                            this.sponsor_fee_info.push(sponsor_fee);
                        }
                    }
                })
                .catch((error) => {
                    console.log(error);
                })
        },

        // Function that gets new/updated information from the user, then
        // sends that information to the backend/database to be changed
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
                        
                        // Determining if the user being updated is a driver, sponsor, or admin
                        if (old_info.user_type === 'Driver') this.update_driver[old_info.full_name] = false;
                        else if (old_info.user_type === 'Sponsor') this.update_sponsor[old_info.full_name] = false;
                        else this.update_admin[old_info.full_name] = false;

                        // Resetting the new_info javascript object
                        this.new_info = {
                            'FullName': null,
                            'Username': null,
                            'Email': null,
                            'PointsLimit': null,
                            'ExpirationPeriod': null,
                            'SponsorID': null,
                            'DollarPointValue': null
                        }

                        // Getting new information from the database so it can be displayed to the user
                        this.get_info();
                        
                    }
                })
                .catch((err) => {
                    console.log(err);
                })
        }
    },

    // Components used from external files
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

    .driver-profiles-permissions, 
    .sponsor-profiles-permissions, 
    .admin-profiles-permissions, 
    .driver-fees-container, 
    .sponsor-fees-container {
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .drivers, 
    .sponsors, .admins, 
    .driver-fees, 
    .sponsor-fees {
        margin-left: 5px;
    }

    .driver-container, 
    .sponsor-container, 
    .admin-container, 
    .driver-fees-info-container,
    .sponsor-fees-info-container {
        display: flex;
        flex-direction: column;
        width: 30%;
        height: 80%;
        overflow-y: auto;
        border-style: solid;
        border-color: black;
        align-items: center;
    }

    .driver-info, 
    .sponsor-info, 
    .admin-info, 
    .driver-fees-info,
    .sponsor-fees-info {
        display: flex;
        flex-direction: column;
        width: 100%;
        height: auto;
        align-items: left;
        border-style: solid none none none;
        border-color: black;
    }

    .driver-info p, 
    .sponsor-info p, 
    .admin-info p, 
    .driver-fees-info p,
    .sponsor-fees-info p {
        margin-left: 5%;
        width: auto;
    }

    .driver-info p input, 
    .sponsor-info p input, 
    .admin-info p input {
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

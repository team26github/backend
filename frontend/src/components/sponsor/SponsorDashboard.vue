<template>
    <div class="profile-container">
        <nav-bar :usertype="user_type" :username="username"></nav-bar>
        <br><br>

        <!-- Button to route user to add points to a driver as a sponsor page -->
        <div class="row">
            <div class="add-point-container">
                <button @click="go_to_add_points"><span>Add Points to Driver</span></button>
            </div>
        </div>

        <!-- Button to route user to remove points from a driver as a sponsor page -->
        <div class="row">
            <div class="remove-points-button">
                <button @click="go_to_remove_points"><span>Deduct Points from Driver</span></button>
            </div>
        </div>

        <!-- Button to route user to pending applications acceptance/rejection page -->
        <div class="row">
            <div class="pending-applications-button">
                <button @click="go_to_pending_applications"><span>Pending Applications</span></button>
            </div>
        </div>

        <!-- Button to route user to set a driver inactive as a sponsor page -->
        <div class="row">
            <div class="set-inactive-button">
                <button @click="go_to_set_inactive"><span>Set Drivers Inactive</span></button>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from '../misc/NavBar.vue';

    export default {

        // Component name
        name: 'SponsorDashboard',

        // Component specific variables and data
        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'sponsor',
                active: false
            }
        },

        // Component specific methods
        methods: {

            // Method to route sponsor to pending applications acceptance/rejection page
            go_to_pending_applications() {
                this.$router.push({
                    name: 'pending-applications',
                    params: { username: this.username }
                });
            },

            // Method to route sponsor to set driver inactive page
            go_to_set_inactive() {
                this.$router.push({
                    name: 'set-inactive',
                    params: { username: this.username }
                });
            },

            // Method to route sponsor to add points to a driver page
            go_to_add_points() {
                this.$router.push({
                    name: 'add-points',
                    params: { username: this.username }
                });
            },

            // Method to route sponsor to remove points from a driver page
            go_to_remove_points() {
                this.$router.push({
                    name: 'remove-points',
                    params: { username: this.username }
                });
            }
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {
            this.username = this.$route.params.username;
        },

        // Components used from external files
        components: {
            "nav-bar": NavBar
        }
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
        display: block;
        width: 200px;
        height: 40px;
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
</style>

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
                    <option value="None" selected>None</option>
                    <option value="Grant">Grant</option>
                    <option value="Rachel">Rachel</option>
                    <option value="Greg">Greg</option>
                    <option value="Kaitlyn">Kaitlyn</option>
                </select>
                <button>View</button>
            </div>
        </div>
        <div class="row">
            <div class="sponsor-profiles-permissions">
                <p><strong>View Sponsor Profiles & Permissions</strong></p>
                <label class="sponsors">Choose a Sponsor:</label>
                <select class="sponsors">
                    <option value="None" selected>None</option>
                    <option value="Grant">Grant</option>
                    <option value="Rachel">Rachel</option>
                    <option value="Greg">Greg</option>
                    <option value="Kaitlyn">Kaitlyn</option>
                </select>
                <button>View</button>
            </div>
        </div>
        <div class="row">
            <div class="admin-profiles-permissions">
                <p><strong>View Admin Profiles & Permissions</strong></p>
                <label class="admins">Choose an Admin:</label>
                <select class="admins">
                    <option value="None" selected>None</option>
                    <option value="Grant">Grant</option>
                    <option value="Rachel">Rachel</option>
                    <option value="Greg">Greg</option>
                    <option value="Kaitlyn">Kaitlyn</option>
                </select>
                <button>View</button>
            </div>
        </div>
        <div class="row">
            <div class="driver-container">{{ driver_info }}</div>
            <div class="sponsor-container">{{ sponsor_info }}</div>
            <div class="admin-container">{{ admin_info }}</div>
        </div>
    </div>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
    name: "admin-settings",
    data() {
        return {
            user_type: "admin",
            username: null,
            driver_info: null,
            sponsor_info: null,
            admin_info: null
        };
    },

    mounted() {
        this.username = this.$route.params.username;
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
        display: grid;
        place-items: center;
        width: 30%;
        height: 67vh;
        border-style: solid;
        border-color: black;
        align-items: center;
    }
</style>
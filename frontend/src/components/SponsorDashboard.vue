<template>
    <nav-bar :usertype="user_type" :userid="username"></nav-bar>
    <div class="row">
            <div class="add-point-container">
                <button @click="add_points"> Add Points to Driver</button>
            </div>
        </div>
        <div class="remove-points-container">
                <button @click="deduct_points">Deduct Points from Driver</button>
            </div>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'SponsorDashboard',

        data() {
            return {
                dashboard_name: 'Sponsor Dashboard',
                username: 'Sponsor1',
                user_type: 'sponsor',
                active: false
            }
        },

        methods: {
            add_points() {
                let add_point_val = window.prompt("Enter number of points to be added");
                this.points += add_point_val;
            },
            deduct_points() {
                let remove_point_val = window.prompt("Enter number of points to be removed");
                this.points -= remove_point_val;
                if (this.points < 0) {
                    window.alert("Total point value cannot go below 0")
                }
            }
        },

        components: {
            "nav-bar": NavBar
        }
    }
</script>
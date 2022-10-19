<template>
    <nav-bar :usertype="user_type" :username="username"></nav-bar>
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
        name: 'admin-dashboard',

        data() {
            return {
                dashboard_name: `${this.username}'s Dashboard`,
                username: null,
                user_type: 'admin',
                active: false,
                points: 0
            }
        },

        methods: {
            add_points() {
                let add_point_val = window.prompt("Enter number of points to be added");
                this.points += add_point_val;
                if (this.points > 1000000) {
                    window.alert("Total points cannot be greater than 1000000")
                }
                this.points -+ add_point_val;
            },
            deduct_points() {
                let remove_point_val = window.prompt("Enter number of points to be removed");
                this.points -= remove_point_val;
                if (this.points < 0) {
                    window.alert("Total point value cannot go below 0")
                }
                this.points += remove_point_val;
            }
        },

        mounted() {
            this.username = this.$route.params.username;
        },

        components: {
            "nav-bar": NavBar
        }
    }
</script>
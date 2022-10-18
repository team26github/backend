<template>
    <nav-bar :usertype="user_type" :userid="username"></nav-bar>
    <div class ="points-container">
            <div class="points">
                <p><strong>Points: </strong>{{ default_points }}</p>
            </div>
        </div>
</template>

<script>
    import NavBar from '../components/NavBar.vue';
    export default {
        name: 'driver-dashboard',

        data() {
            return {
                dashboard_name: 'Driver Dashboard',
                username: 'Driver1',
                user_type: 'driver',
                active: false,
                default_points: 0
            }
        },
        components: {
            "nav-bar": NavBar
        }
    }
</script>
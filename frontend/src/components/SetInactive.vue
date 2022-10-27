<template>
    <div class="profile-container">
        <form style="max-width:800px;margin:auto">
            <h1>Set Drivers Inactive</h1>

            <div>Select Driver:</div>

            <select name = "selected" required>
                <option disabled value="">Please select one driver application to review:</option>
                <option value="None">None</option>
                <option v-for="driver in drivers" :key="driver">{{driver}}</option>
            </select>

            <br><br>
        </form>
        <div class="sponsor-dashboard-button">
            <button @click="go_to_sponsor_dashboard">Return to Dashboard</button>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    export default {
        name: "set-inactive",

        data() {
            return {
                username: null,
                user_id: null,
                drivers: [],
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        methods: {
            onChange(e)
            {
                this.sponsor_selected=e.target.value
            },

            go_to_sponsor_dashboard() {
                this.$router.push({
                    name: 'sponsor-dashboard',
                    params: { username: this.username }
                })
            },

            fetchDrivers() {
                axios.get(this.path + '/get-drivers', { params: { user_id: this.user_id } })
                    .then((res) => {
                        if (res.data.status === 'success') {
                            for (const name of res.data.results) {
                                this.drivers.push(name[0]);
                            }
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            },
        },

        mounted() {
            this.path = this.localhost_path;
            this.username = this.$route.params.username;

            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        this.user_id = res.data.results[0][0];
                        this.fetchDrivers();
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },
    }
</script>

<style scoped>
    * {box-sizing: border-box;}

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

    .input-container {
    display: flex;
    width: 100%;
    margin-bottom: 15px;
    }

    /* Style the form icons */
    .icon {
    padding: 10px;
    background: #8c72e0;
    color: white;
    min-width: 50px;
    text-align: center;
    }

    /* Style the input fields */
    .input-field {
    width: 100%;
    padding: 10px;
    outline: none;
    }

    .input-field:focus {
    border: 2px solid #8c72e0;
    }
</style>
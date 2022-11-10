<template>
    <div class="profile-container">
        <form style="max-width:800px;margin:auto">
            <h1>Add Points to Drivers</h1>

            <div>Select Driver:</div>

            <select name = "selected" @change="onChange($event)" required>
                <option disabled value="">Please select a driver:</option>
                <option value="None">None</option>
                <option v-for="driver in drivers" :key="driver">{{driver}}</option>
            </select>

            <br><br>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Number of points to add" name="num_points" v-model="num_points" required><br><br>
            </div>
            <div class="input-container">
                <input class="input-field" type="text" placeholder="Reason for addition" name="num_points" v-model="last_name" required><br><br>
            </div>
            <button type="submit" class="btn" @click="submit_application" >Submit</button>
        </form>
        <div class="admin-dashboard-button">
            <button @click="go_to_admin_dashboard">Return to Dashboard</button>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    export default {
        name: "add-points-admin",

        data() {
            return {
                username: null,
                user_id: null,
                drivers: [],
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null,
                num_points: '',
                reason: '',
                driver_selected:''
            };
        },

        methods: {
            onChange(e)
            {
                this.driver_selected=e.target.value
            },

            go_to_admin_dashboard() {
                this.$router.push({
                    name: 'admin-dashboard',
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
            submit_application() {                 
                axios.post(this.path + '/add_points', null, {params: {num_points: this.num_points, reason: this.reason, driver: this.driver_selected, sponsor: this.user_id}}) 
                    .then((res) => {
                        if (res.data.status === "success") {
                            console.log("success");
                        }
                        else {
                            window.alert("Cannot add points.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },
        },

        mounted() {
            this.path = this.production_path;
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
        background-color: #ff90b3;
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

    .btn {
    background-color: #8c72e0;
    color: white;
    padding: 15px 20px;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
    }

    .btn:hover {
    opacity: 1;
    }
</style>
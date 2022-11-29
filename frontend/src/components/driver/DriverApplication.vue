<template>
    <form style="max-width:800px;margin:auto">
        <h1>Driver Application</h1>

        <div>Select Sponsor: {{ selected }}</div>

        <!-- <select name = "selected" @change="onChange($event)" v-model="selected" required>
            <option disabled value="">Please select one sponsor you would like to apply to</option>
            <option v-for="sponsor in sponsors" :key="sponsor">{{sponsor}}</option>
        </select> -->

        <!-- Sponsor selection dropdown menu -->
        <select name = "selected" v-model="selected" required>
            <option disabled value="">Please select one sponsor you would like to apply to</option>
            <option v-for="sponsor in sponsors" :key="sponsor">{{sponsor[0]}}</option>
        </select>

        <br><br>

        <!-- First Name Input -->
        <div class="input-container">
            <input class="input-field" type="text" placeholder="First Name" name="first_name" v-model="first_name" required><br><br>
        </div>

        <!-- Last Name Input -->
        <div class="input-container">
            <input class="input-field" type="text" placeholder="Last Name" name="last_name" v-model="last_name" required><br><br>
        </div>

        <!-- Username Input -->
        <div class="input-container">
            <input class="input-field" type="text" placeholder="Username" name="username" v-model="username" required><br><br>
        </div>

        <!-- Email Input -->
        <div class="input-container">
            <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
        </div>
        
        <!-- Password Input -->
        <div class="input-container">
            <input class="input-field" type="password" placeholder="Password" name="password" v-model="password" required><br><br>
        </div>

        <!-- Submission Button -->
        <button type="submit" class="btn" @click="submit_application" >Apply</button> 
        
        <br><br>
        <!-- Return to Login Route -->
        <div style="text-align:center"><a href="/login">Return to Login</a></div>
    </form>

</template>

<script>
    import axios from 'axios';

    export default {

        // Component Name
        name: "driver-application",

        // Component specific variables and data
        data() {
            return {
                status: null,
                first_name: '',
                last_name:'',
                username: '',
                password: '',
                email: '',
                user_type: '',
                sponsors: [],
                sponsor_selected: '',
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null
            };
        },

        // Mounted function is used for doing operations right after the component
        // Is mounted and right before the component is shown to the user
        mounted() {

            // Sets path for axios API calls to either localhost or production
            this.path = this.production_path;
        },

        // Component specific methods
        methods: {

            // Sets selected sponsor from dropdown menu
            onChange(e)
            {
                this.sponsor_selected=e.target.value
            },

            // Gets available sponsors for driver applications
            fetchSponsors() {

                // Axios API call to python backend to get available sponsors
                axios.get(this.path + '/get-sponsors', {params: {user_id: this.user_id}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            this.sponsors = res.data.results;
                        }
                        else {
                            console.log('Unsuccessful');
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            },

            // Method for submitting application
            submit_application() {              
                
                // Axios API call to python backend to add application to database
                axios.post(this.path + '/apply', null, {params: {email: this.email, first_name: this.first_name, last_name: this.last_name, username: this.username, password: this.password, sponsor: this.sponsor_selected}}) 
                    .then((res) => {
                        if (res.data.status === "success") {
                            console.log("success");
                        }
                        else {
                            window.alert("Cannot submit application.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },
        },
        
        // Method for getting available sponsors on creation of the component
        created:function(){
            this.fetchSponsors();
        },
    }

</script>

<style scoped>
    * {box-sizing: border-box;}

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

    /* Set a style for the submit button */
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

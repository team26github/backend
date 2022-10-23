<template>
    <form style="max-width:800px;margin:auto">
        <h1>Driver Application</h1>

        <div>Select Sponsor: {{ selected }}</div>

        <select v-model="selected" required>
            <option disabled value="">Please select one sponsor you would like to apply to</option>
            <option>{{sponsors}}</option>
        </select>

        <br><br>

        <div class="input-container">
            <input class="input-field" type="text" placeholder="First Name" name="first_name" v-model="first_name" required><br><br>
        </div>

        <div class="input-container">
            <input class="input-field" type="text" placeholder="Last Name" name="last_name" v-model="last_name" required><br><br>
        </div>

        <div class="input-container">
            <input class="input-field" type="text" placeholder="Username" name="username" v-model="username" required><br><br>
        </div>

        <div class="input-container">
            <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
        </div>
        
        <div class="input-container">
            <input class="input-field" type="password" placeholder="Password" name="password" v-model="password" required><br><br>
        </div>

        <!-- <button type="submit" class="btn">Apply</button> -->

        <button type="submit" class="btn" @click="submit_application" >Apply</button> 
    </form>

</template>

<script>
    import axios from 'axios';

    export default {
        name: "driver-application",

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
        };
        },

        methods: {
            fetchSponsors:function() {
                let path = 'http://localhost:5000/get-sponsors';

                axios.get(path, {params: {user_id: this.user_id}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            console.log(res.data);
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

            submit_application() { 
                const path = 'http://localhost:5000/apply';
                
                axios.get(path, {params: {request: 'email', email: this.email}})
                .then((res) => {
                    if (res.data.status === "success") {
                        axios.post(path, null, {params: {request: 'email', email: this.email}})
                        .then((res) => {
                            if (res.data.status === "success") {
                                window.alert("Application submitted");
                            }
                            else {
                                window.alert("Application not submitted");
                            }
                        })
                        .catch((error) => {
                            // esling-disable-next-line
                            console.log(error);
                        })
                    }
                    else {
                        window.alert("Account already created with that email");
                    }
                })
            },
        },
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
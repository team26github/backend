<template>
    <form style="max-width:800px;margin:auto">
        <h1>Driver Application</h1>

        <div>Select Sponsor: {{ selected }}</div>

        <select v-model="selected" required>
            <option disabled value="">Please select one sponsor you would like to apply to</option>
            <option>A</option>
            <option>B</option>
            <option>C</option>
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

        <button type="submit" class="btn">Apply</button>

        <!-- <button type="submit" class="btn" id="apply-button" @click.prevent="submit_application" :disabled="disabled">Apply</button>  -->
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
            production_path: "http://18.191.136.200",
            localhost_path: "http://localhost:5000",
            path: null
        };
        },

        mounted() {
            this.path = this.localhost_path;
        },

        methods: {
        submit_application() { 
            if (this.first_name === '') {
            this.status = 'First Name cannot be blank.'
            return;
            }
            else if (this.last_name === '') {
            this.status = 'Last Name cannot be blank.'
            return; 
            }
            else if (this.username === '') {
            this.status = 'Username cannot be blank.'
            return;
            }
            else if (this.password === '') {
            this.status = 'Password cannot be blank.'
            return;
            }
            else if (this.email === '') {
            this.status = 'Email cannot be blank.'
            return;
            }

            axios.get(this.path + '/apply', {params: {username: this.username, password: this.password}})
            .then((res) => {
            
                if (res.data.status === 'failure'){
                this.status = 'Incorrect Credentials';
                this.login_counter++;
                }
                else {
                this.status = 'Success'
                this.username = res.data.results[0][4];
                this.password = res.data.results[0][1];
                this.user_type = res.data.results[0][2];
                this.$router.push(`/${this.user_type.toLowerCase()}/${this.username}`);
                }
            },)
            .catch((error) => {
                // esling-disable-next-line
                console.log(error);
            })
            },
        }
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

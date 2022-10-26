<template>
    <div class="settings-container">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <form style="max-width:800px;margin:auto">
            <h1>New Driver</h1>

            <div>Select Sponsor: {{ selected }}</div>

            <select name = "selected" @change="onChange($event)" v-model="selected" required>
                <option disabled value="">Please select one sponsor you would like to apply to</option>
                <option v-for="sponsor in sponsors" :key="sponsor">{{sponsor}}</option>
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

            <button type="submit" class="btn" @click="create_driver" >Create</button> 
        </form>
    </div>

</template>

<script>
    import axios from 'axios';
    import NavBar from '../components/NavBar.vue';


    export default {
        name: "new-driver",

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
            sponsor_selected: ''
        };
        },

        methods: {
            onChange(e)
            {
                this.sponsor_selected=e.target.value
            },

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

            create_driver() { 
                const path = 'http://localhost:5000/new-driver';
                
                axios.post(path, null, {params: {email: this.email, first_name: this.first_name, last_name: this.last_name, username: this.username, password: this.password, sponsor: this.sponsor_selected}}) 
                    .then((res) => {
                        if (res.data.status === "success") {
                            console.log("success");
                        }
                        else {
                            window.alert("Cannot create driver.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },
        },
        created:function(){
            this.fetchSponsors();
        },
        components: { NavBar },
    }

</script>

<style scoped>
    * {box-sizing: border-box;}

    .settings-container {
        /* display: flex; */
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
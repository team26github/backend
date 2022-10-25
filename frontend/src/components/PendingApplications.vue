<template>
    <form style="max-width:800px;margin:auto">
        <h1>Pending Driver Applications</h1>

        <div>Select Driver: {{ selected }}</div>

        <select name = "selected" v-model="selected" required>
            <option disabled value="">Please select one application</option>
            <option v-for="driver in drivers" :key="driver">{{driver}}</option>
        </select>

        <br><br>
    </form>

    <p>{{ status }}</p>
      <a href="/sponsor/:username">
        <input type="button" value="Return to Sponsor Dashboard"/>
      </a>
</template>

<script>
    import axios from 'axios';
    export default {
        name: "pending-applications",

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
        };
        },

        methods: {
            onChange(e)
            {
                this.sponsor_selected=e.target.value
            },

            fetchDrivers:function() {
                let path = 'http://localhost:5000/get-drivers';

                axios.get(path, {params: {user_id: this.user_id}})
                    .then((res) => {
                        if (res.data.status === 'success') {
                            console.log(res.data);
                            this.drivers = res.data.results;
                        }
                        else {
                            console.log('Unsuccessful');
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
                },
            },
            created:function(){
                this.fetchDrivers();
        },
        mounted() {
            this.path = this.localhost_path;
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
</style>
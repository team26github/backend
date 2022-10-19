<template>
    <div class="profile-container">
        <NavBar :usertype="user_type" :userid="username"></NavBar>
        <h1>&nbsp;Sponsor Settings<br></h1>
        <div class="row">
            <div class="max_points">
                        <p><strong>Maximum Value of Driver Points: </strong>{{ max_points }}
                        <button @click="edit_max_points">Edit Maximum Points</button></p>
            </div>
        </div>  
        <div class="row">
            <div class="expiration_period">
                    <p><strong>Expiration Period of Driver Points: </strong>{{ expiration_period }} <strong> months </strong>
                    <button @click="edit_expiration">Edit Expiration Period</button></p>
            </div>
        </div> 
    </div>
</template>

<script>
    import axios from 'axios';
    import NavBar from './NavBar.vue';
    // import ButtonCounter from './ButtonCounter.vue'

    export default {
    name: "sponsor-settings",

    data() {
        return {
            user_type: "sponsor",
            username: "Sponsor1",
            max_points: 100000,
            expiration_period: 12,
        };
    },

    methods: {
        edit_max_points() {
            let path = 'http://localhost:5000/edit'
            let new_max_points = window.prompt("Enter maximum value of points");
            axios.get(path, {params: {request: 'maximum_points', username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {       
                        axios.post(path, null, {params: {request: 'maximum_points', max_points: new_max_points,}})
                            .then((res) => {
                                if (res.data.status === "success") {
                                    this.max_points = new_max_points;
                                    console.log("success");
                                }
                                else {
                                    window.alert("Maximum points change unsuccessful");
                                }
                            })
                            .catch((error) => {
                                // esling-disable-next-line
                                console.log(error);
                            })
                    }
                    else {
                        window.alert("Unable to make change.");
                    }
                })
                .catch((error) => {
                    // esling-disable-next-line
                    console.log(error);
                })
        },
       
        edit_expiration() {
                let path = 'http://localhost:5000/edit';
                let new_expiration_period = window.prompt("Enter new expiration period");
                axios.get(path, {params: {request: 'expiration_period', expiration_period: new_expiration_period}})
                .then((res) => {
                    if (res.data.status === "success") {
                        axios.post(path, null, {params: {request: 'expiration_period', expiration_period: new_expiration_period, userid: 3}})
                        .then((res) => {
                            if (res.data.status === "success") {
                                this.expiration_period = new_expiration_period;
                                window.alert("Expiration Period change successful");
                            }
                            else {
                                window.alert("Expiration Period change unsuccessful");
                            }
                        })
                        .catch((error) => {
                            // esling-disable-next-line
                            console.log(error);
                        })
                    }
                    else {
                        window.alert("Unable to make change.");
                    }
                })
            },
    },
    components: { NavBar}
}
</script>


<style scoped>
    .profile-container {
        display: flex;
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: #a9a9a9;
    }

    .row {
        width: 100%;
        height: 45px;
        display: flex;
        flex-direction: row;
        justify-content: center;
        gap: 1rem;
    }
    button {
        margin-right: 5px;
        margin-left: auto;
    }
    .user-id-container, .username-container, .password-container, .email-container, .user-type-container, .drivers-list-container {
        display: flex;
        width: 49%;
        border-style: solid;
        border-color: black;
        justify-content: center;
        align-items: center;
    }
    .password, .username, .email {
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
    }
</style>
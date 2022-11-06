<template>
    <div class="checkout">
        <NavBar :usertype="user_type" :username="username"></NavBar>
        <form style="max-width:800px;margin:auto">
            <h1>Checkout</h1>

            <div class="row">
                <div class="catalog-items">
                    <p><strong>Cart Items:</strong></p>
                    <p v-for="item in items" :key="item">&nbsp;{{ item }}</p>
                </div>
            </div>

            <p>Please enter the below information to complete your purchase</p>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="First Name" name="first_name" v-model="first_name" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Last Name" name="last_name" v-model="last_name" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Address" name="address" v-model="address" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="City" name="city" v-model="address_city" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="State Abbreviation" name="state" v-model="address_state" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Zip Code" name="zip_code" v-model="address_zip_code" required><br><br>
            </div>

            <div class="input-container">
                <input class="input-field" type="text" placeholder="Email" name="email" v-model="email" required><br><br>
            </div>

            <!-- <button id="myBtn" class="btn" @click="submit_purchase" :disabled="insufficient_balance()"> -->
            <button id="myBtn" class="btn" @click="submit_purchase">
                Pay #{{ this.purchase_total }} points
            </button>

        </form>
    </div>

</template>

<script>
    import axios from 'axios';
    import NavBar from '@/components/misc/NavBar.vue';

    export default {
        name: "cart-checkout",

        data() {
            return {
                status: null,
                first_name: '',
                last_name:'',
                username: '',
                address: '',
                address_city: '',
                address_state: '',
                address_zip_code: '',
                email: '',
                user_type: '',
                points_balance: '',
                items: [],
                items_total: '',
                points_total: '',
                production_path: "http://18.191.136.200",
                localhost_path: "http://localhost:5000",
                path: null,
                reason:'Purchase',
            };
        },

        mounted() {
            this.username = this.$route.params.username;
            this.items = this.$route.params.cart;
            this.path = this.localhost_path;

            console.log("params");
            console.log(this.$route.params.params);

            axios.get(this.path + '/userinfo', {params: {username: this.username}})
                .then((res) => {
                    if (res.data.status === 'success') {
                        console.log(res.data);
                        this.user_type = res.data.results[0][2];
                    }
                    else {
                        console.log('Unsuccessful');
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },

        methods: {

            submit_purchase() {                 
                axios.post(this.path + '/submit-purchase', null, {params: {first_name: this.first_name, last_name: this.last_name, address: this.address, address_city: this.address_city, address_state: this.address_state, address_zip_code: this.address_zip_code, email: this.email, items: this.items, items_total: this.items_total, points_total: this.points_total }}) 
                    .then((res) => {
                        if (res.data.status === "success") {
                            console.log("success");
                        }
                        else {
                            window.alert("Cannot submit purchase.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
                    this.remove_points_purchase();
            },

            remove_points_purchase() {
                axios.post(this.path + 'remove_points_purchase', null, {params: {points_total: this.points_total, reason: this.reason, email: this.email}}) 
                    .then((res) => {
                        if (res.data.status === "success") {
                            console.log("success");
                        }
                        else {
                            window.alert("Cannot remove points and complete purchase.");
                        }
                    })
                    .catch((error) => {
                        // esling-disable-next-line
                        console.log(error);
                    })
            },

            get_points_balance(){ //show records
                axios.get(this.path + '/userinfo', {params: {request: 'username'}})
                .then(function(response){
                        console.log(response);
                        this.points_balance = response.data.results[0][11];
                });
            },

            insufficient_balance () {
                if (this.get_points_balance() < this.points_total) {
                    return false;
                }
                else {
                    return true;
                }
            },
        },
        components: { NavBar }
    }

</script>

<style scoped>
    * {box-sizing: border-box;}

    .checkout{
        /* display: flex; */
        flex-direction: column;
        width: 98.5vw;
        height: 97.5vh;
        border-style: solid;
        border-color: black;
        gap: 1rem;
        background-color: #0096c7;
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

    #myBtn:disabled {
    cursor: not-allowed;
    opacity: 0.8;
    }
</style>
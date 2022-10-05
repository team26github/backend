<template>
    <div class="profile-container">
        <NavBar :usertype="user_type"></NavBar>
        <div class="row">
            <div class="user-id-container">
                <p><strong>UserID: </strong>{{ user_id }}</p>
            </div>
            <div class="username-container">
                <p><strong>Username: </strong>{{ username }}</p>
            </div>
        </div>
        <div class="row">
            <div class="password-container">
                <div class="password">
                    <p><strong>Password: </strong>{{ password_text }}</p>
                    <button @click="show_password">{{ button_text }}</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="email-container">
                <p><strong>Email: </strong>{{ email }}</p>
            </div>
            <div class="user-type-container">
                <p><strong>UserType: </strong>{{ user_type }}</p>
            </div>
        </div>
    </div>
</template>

<script>
    import NavBar from './NavBar.vue';

    export default {
        name: 'sponsor-profile',
        
        data() {
            return {
                user_id: 3,
                username: "Sponsor1",
                password: "Password3",
                password_text: "***********************",
                email: "sponsor1@email.com",
                user_type: "sponsor",
                button_text: "Show Password",
                password_active: false
            };
        },
        methods: {
            show_password() {
                if (this.password_active) {
                    this.password_text = "***********************";
                    this.password_active = false;
                    this.button_text = "Show Password";
                }
                else {
                    this.password_text = this.password;
                    this.password_active = true;
                    this.button_text = "Hide Password";
                }
            }
        },

        components: { NavBar }
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
    }

    .password {
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .password button {
        margin-left: auto;
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
        height: 50%;
        margin-right: 5px;
    }
    .user-id-container, .username-container, .password-container, .email-container, .user-type-container {
        display: flex;
        width: 49%;
        border-style: solid;
        border-color: black;
        justify-content: center;
        align-items: center;
    }

    .password-container p {
        margin-left: 5px;
    }
</style>
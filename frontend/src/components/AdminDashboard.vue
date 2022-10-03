<template>
    <h1>{{ dashboard_name }}</h1>
</template>

<script>
    export default {
        name: 'admin-dashboard',

        data() {
            return {
                dashboard_name: 'Admin Dashboard',
                active: false
            }
        }
    }
</script>
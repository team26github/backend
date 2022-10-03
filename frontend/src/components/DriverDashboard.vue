<template>
    <h1>{{ dashboard_name }}</h1>
</template>

<script>
    export default {
        name: 'driver-dashboard',

        data() {
            return {
                dashboard_name: 'Driver Dashboard',
                active: false
            }
        }
    }
</script>
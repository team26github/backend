<template>
    <h1>{{ dashboard_name }}</h1>
</template>

<script>
    export default {
        name: 'SponsorDashboard',

        data() {
            return {
                dashboard_name: 'Sponsor Dashboard',
                active: false
            }
        }
    }
</script>
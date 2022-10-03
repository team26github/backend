import { createWebHistory, createRouter } from 'vue-router';
import loginForm from '../components/loginForm.vue';
import DriverDashboard from '../components/DriverDashboard.vue';
import AdminDashboard from '../components/AdminDashboard.vue';
import SponsorDashboard from '../components/SponsorDashboard.vue';

const routes = [
    {
        path: 'https://spacebarcowboysbackend.herokuapp.com/login',
        name: 'login',
        component: loginForm
    },
    {
        path: 'https://spacebarcowboysbackend.herokuapp.com/',
        redirect: 'https://spacebarcowboysbackend.herokuapp.com/login'
    },
    {
        path: '/driver',
        name: 'driver-dashboard',
        component: DriverDashboard
    },
    {
        path: '/admin',
        name: 'admin-dashboard',
        component: AdminDashboard
    },
    {
        path: '/sponsor',
        name: 'sponsor-dashboard',
        component: SponsorDashboard
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;
import { createWebHistory, createRouter } from 'vue-router';
import loginForm from '../components/loginForm.vue';
import DriverDashboard from '../components/DriverDashboard.vue';
import AdminDashboard from '../components/AdminDashboard.vue';
import SponsorDashboard from '../components/SponsorDashboard.vue';
import NavBar from '../components/NavBar.vue';

const routes = [
    {
        path: '/login',
        name: 'login',
        component: loginForm
    },
    {
        path: '/',
        redirect: '/login'
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
    },
    {
        path: '/navbar',
        name: 'navbar',
        component: NavBar
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;
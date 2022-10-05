import { createWebHistory, createRouter } from 'vue-router';
import loginForm from '../components/loginForm.vue';
import DriverDashboard from '../components/DriverDashboard.vue';
import AdminDashboard from '../components/AdminDashboard.vue';
import SponsorDashboard from '../components/SponsorDashboard.vue';
import NavBar from '../components/NavBar.vue';
import DriverProfile from '../components/DriverProfile.vue';
import AdminProfile from '../components/AdminProfile.vue';
import SponsorProfile from '../components/SponsorProfile.vue';

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
    },
    {
        path: '/driver/profile',
        name: 'driver-profile',
        component: DriverProfile
    },
    {
        path: '/admin/profile',
        name: 'admin-profile',
        component: AdminProfile
    },
    {
        path: '/sponsor/profile',
        name: 'sponsor-profile',
        component: SponsorProfile
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;
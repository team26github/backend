import { createWebHistory, createRouter } from 'vue-router';
import loginForm from '../components/loginForm.vue';
import DriverDashboard from '../components/DriverDashboard.vue';
import AdminDashboard from '../components/AdminDashboard.vue';
import SponsorDashboard from '../components/SponsorDashboard.vue';
import NavBar from '../components/NavBar.vue';
import DriverProfile from '../components/DriverProfile.vue';
import AdminProfile from '../components/AdminProfile.vue';
import SponsorProfile from '../components/SponsorProfile.vue';
import DriverSettings from '../components/DriverSettings.vue';
import AdminSettings from '../components/AdminSettings.vue';
import SponsorSettings from '../components/SponsorSettings.vue';

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
        path: '/driver/:id',
        name: 'driver-dashboard',
        component: DriverDashboard
    },
    {
        path: '/admin/:id',
        name: 'admin-dashboard',
        component: AdminDashboard
    },
    {
        path: '/sponsor/:id',
        name: 'sponsor-dashboard',
        component: SponsorDashboard
    },
    {
        path: '/navbar',
        name: 'navbar',
        component: NavBar
    },
    {
        path: '/driver/:id/profile',
        name: 'driver-profile',
        component: DriverProfile
    },
    {
        path: '/admin/:id/profile',
        name: 'admin-profile',
        component: AdminProfile
    },
    {
        path: '/sponsor/:id/profile',
        name: 'sponsor-profile',
        component: SponsorProfile
    },
    {
        path: '/driver/:id/settings',
        name: 'driver-settings',
        component: DriverSettings
    },
    {
        path: '/admin/:id/settings',
        name: 'admin-settings',
        component: AdminSettings
    },
    {
        path: '/sponsor/:id/settings',
        name: 'sponsor-settings',
        component: SponsorSettings
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router;
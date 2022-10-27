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
import Catalog from '../components/Catalog.vue';
import DriverApplication from '../components/DriverApplication.vue';
import PendingApplications from '../components/PendingApplications.vue';
import NewDriver from '../components/NewDriver.vue';
import NewSponsor from '../components/NewSponsor.vue';
import NewAdmin from '../components/NewAdmin.vue';
import SetInactive from '../components/SetInactive.vue';
import SetInactiveAdmins from '../components/SetInactiveAdmins.vue';

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
        path: '/driver/:username',
        name: 'driver-dashboard',
        component: DriverDashboard
    },
    {
        path: '/admin/:username',
        name: 'admin-dashboard',
        component: AdminDashboard
    },
    {
        path: '/sponsor/:username',
        name: 'sponsor-dashboard',
        component: SponsorDashboard
    },
    {
        path: '/navbar',
        name: 'navbar',
        component: NavBar
    },
    {
        path: '/driver/:username/profile',
        name: 'driver-profile',
        component: DriverProfile
    },
    {
        path: '/admin/:username/profile',
        name: 'admin-profile',
        component: AdminProfile
    },
    {
        path: '/sponsor/:username/profile',
        name: 'sponsor-profile',
        component: SponsorProfile
    },
    {
        path: '/driver/:username/settings',
        name: 'driver-settings',
        component: DriverSettings
    },
    {
        path: '/admin/:username/settings',
        name: 'admin-settings',
        component: AdminSettings
    },
    {
        path: '/sponsor/:username/settings',
        name: 'sponsor-settings',
        component: SponsorSettings
    },
    {
        path: '/catalog/:username',
        name: 'catalog',
        component: Catalog
    },
    {
        path: '/driverapplication',
        name: 'driver-application',
        component: DriverApplication
    },
    {
        path: '/sponsor/:username/pendingapplications',
        name: 'pending-applications',
        component: PendingApplications
    },
    {
        path: '/admin/:username/new-driver',
        name: 'new-driver',
        component: NewDriver
    },
    {
        path: '/admin/:username/new-sponsor',
        name: 'new-sponsor',
        component: NewSponsor
    },
    {
        path: '/admin/:username/new-admin',
        name: 'new-admin',
        component: NewAdmin
    },
    {
        path: '/sponsor/:username/set-inactive',
        name: 'set-inactive',
        component: SetInactive
    },
    {
        path: '/sponsor/:username/set-inactive-admins',
        name: 'set-inactive-admins',
        component: SetInactiveAdmins
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
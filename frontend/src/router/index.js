import { createWebHistory, createRouter } from 'vue-router';
import loginForm from '../components/misc/loginForm.vue';
import DriverDashboard from '../components/driver/DriverDashboard.vue';
import AdminDashboard from '../components/admin/AdminDashboard.vue';
import SponsorDashboard from '../components/sponsor/SponsorDashboard.vue';
import NavBar from '../components/misc/NavBar.vue';
import DriverProfile from '../components/driver/DriverProfile.vue';
import AdminProfile from '../components/admin/AdminProfile.vue';
import SponsorProfile from '../components/sponsor/SponsorProfile.vue';
import DriverSettings from '../components/driver/DriverSettings.vue';
import AdminSettings from '../components/admin/AdminSettings.vue';
import SponsorSettings from '../components/sponsor/SponsorSettings.vue';
import Catalog from '../components/catalog/Catalog.vue';
import DriverApplication from '../components/driver/DriverApplication.vue';
import PendingApplications from '../components/sponsor/PendingApplications.vue';
import NewDriver from '../components/driver/NewDriver.vue';
import NewSponsor from '../components/sponsor/NewSponsor.vue';
import NewAdmin from '../components/admin/NewAdmin.vue';
import SetInactive from '../components/misc/SetInactive.vue';
import SetInactiveAdmins from '../components/misc/SetInactiveAdmins.vue';
import AddPoints from '../components/points/AddPoints.vue';
import RemovePoints from '../components/points/RemovePoints.vue';
import AddPointsAdmin from '../components/points/AddPointsAdmin.vue';
import RemovePointsAdmin from '../components/points/RemovePointsAdmin.vue';
import Cart from '../components/catalog/Cart.vue';
import CartCheckout from '../components/catalog/CartCheckout.vue';

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
        path: '/:username/new-sponsor',
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
    {
        path: '/sponsor/:username/add-points',
        name: 'add-points',
        component: AddPoints
    },
    {
        path: '/sponsor/:username/remove-points',
        name: 'remove-points',
        component: RemovePoints
    },
    {
        path: '/sponsor/:username/add-points-admin',
        name: 'add-points-admin',
        component: AddPointsAdmin
    },
    {
        path: '/sponsor/:username/remove-points-admin',
        name: 'remove-points-admin',
        component: RemovePointsAdmin
    },
    {
        path: '/driver/:username/cart',
        name: 'cart',
        component: Cart
    },
    {
        path: '/driver/:username/checkout',
        name: 'cart-checkout',
        component: CartCheckout
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
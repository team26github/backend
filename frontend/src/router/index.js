import Vue from 'vue';
import Router from 'vue-router';
import { loginForm } from '../components/loginForm.js';

Vue.use(Router);

export default new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/login',
            name: 'login',
            components: loginForm
        }
    ]
});
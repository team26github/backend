import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index.js';
import { DataStore } from '@aws-amplify/datastore';
import { Todo } from './models';

createApp(App).use(router).mount('#app');

await DataStore.save(
    new Todo({
		"Description": "Lorem ipsum dolor sit amet"
	})
);
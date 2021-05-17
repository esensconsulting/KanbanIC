import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

/**
 * @dfinity/agent requires this. Can be removed once it's fixed
 */
window.global = window

createApp(App).use(router).mount('#app')




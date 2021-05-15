import { AuthClient } from "@dfinity/auth-client";
import { createApp } from 'vue'
import App from './App.vue'
import { initAgents } from './agent.js'
import { Actor, HttpAgent } from "@dfinity/agent"


/**
 * @dfinity/agent requires this. Can be removed once it's fixed
 */
window.global = window

async function init() {
    const authClient = await AuthClient.create();
    if (await authClient.isAuthenticated()) {
        await handleAuthenticated(authClient);
    }
    console.log("lol");
    await authClient.login({
        // identityProvider: "http://identity.localhost",
        identityProvider: "http://localhost:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai",
        onSuccess: async () => {
            console.log("lol1");
            handleAuthenticated(authClient);
        },
    });
};

async function handleAuthenticated(authClient) {
    const identity = await authClient.getIdentity();
    const agentOptions = {
        host: "http://localhost:8000",
        identity: identity
    }
    const agent = new HttpAgent(agentOptions);
    initAgents(agent);
}
init().then(e => createApp(App).mount('#app'))



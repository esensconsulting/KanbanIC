<template>
  <div>
    <img alt="Vue logo" src="./assets/logo.png" />
    <router-view />
  </div>
</template>

<script>
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent } from "@dfinity/agent"
import { defineComponent } from "vue";
import { initAgents } from './agent.js'
import router from './router'

export default defineComponent({
  name: "App",
  setup: () => {
    async function authenticate() {
      const authClient = await AuthClient.create();
      if (await authClient.isAuthenticated()) {
        await handleAuthenticated(authClient);
      } else {
        console.log(import.meta.env);
        await authClient.login({
          identityProvider:
            `${import.meta.env.VITE_INTERNET_IDENTITY_URL}`,
          onSuccess: async () => {
            router.go();
          },
        });
      }
    }

    async function handleAuthenticated(authClient) {
      const identity = await authClient.getIdentity();
      const agentOptions = {
        host: "http://localhost:8000",
        identity: identity,
      };
      const agent = new HttpAgent(agentOptions);
      initAgents(agent);
      
    }
    authenticate();
  },
});
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

<template>
  <div>
    <img alt="Vue logo" src="./assets/logo.png" />
    <router-view v-if="dataReady" />
  </div>
</template>

<script>
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent } from "@dfinity/agent";
import { initAgents } from "./agent.js";
import router from "./router";

export default {
  name: "App",
  data() {
    return {
      dataReady: false,
    };
  },
  methods: {
    handleAuthenticated: async (authClient) => {
      const identity = await authClient.getIdentity();
      const agentOptions = {
        host: "http://localhost:8000",
        identity: identity,
      };
      const agent = new HttpAgent(agentOptions);
      initAgents(agent);
    },
  },
  async mounted() {
    const authClient = await AuthClient.create();
    if (await authClient.isAuthenticated()) {
      await this.handleAuthenticated(authClient);
    } else {
      console.log(import.meta.env);
      await authClient.login({
        identityProvider: `${import.meta.env.VITE_INTERNET_IDENTITY_URL}`,
        onSuccess: async () => {
          router.go();
        },
      });
    }
    this.dataReady = true;
  },
};
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

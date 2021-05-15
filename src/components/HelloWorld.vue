<template>
  <h1>{{ msg }}</h1>

  <p>
    A simple way to manage your daily tasks and projects. Collaborate easily and
    securily.
  </p>
  <p>We are building on the Internet Computer !</p>
  <p>{{principal}}</p>
  <button class="demo-button" @click="increment()">
    Anticipation counter is: {{ count }} 
  </button>
</template>

<script>
import { ref, onMounted, defineComponent } from "vue";
import { counter } from "../agent";

export default defineComponent({
  name: "HelloWorld",
  props: {
    msg: {
      type: String,
      required: true,
    },
  },
  setup: () => {
    
    const count = ref(0);
    let principal = ref("");

    const refreshCounter = async () => {
      const res = await counter.getValue();
      count.value = res.toString();
    };

    const increment = async () => {
      console.log("opts",counter)
      await counter.increment();
      refreshCounter();
    };

    onMounted(() => {
      counter.getPrincipal().then(res => {
        principal.value = res
      });
      refreshCounter()
    });

    return { increment, count, principal };
  },
});
</script>

<style scoped>
a {
  color: rgb(26, 117, 255);
}

label {
  margin: 0 0.5em;
  font-weight: bold;
}

code {
  background-color: #eee;
  padding: 2px 4px;
  border-radius: 4px;
  color: #304455;
}

.demo-button {
  font-size: calc(10px + 2vmin);
  background: linear-gradient(237.86deg, #532885 -20%, #ee1f7a 124%);
  padding: 0 2em;
  border-radius: 60px;
  font-size: 0.7em;
  line-height: 40px;
  outline: 0;
  border: 0;
  cursor: pointer;
  text-transform: uppercase;
  font-weight: 900;
  color: white;
}
</style>

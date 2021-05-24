<template>
  <h1>About</h1>
</template>

<script>
export default {
  name: "About",
  props: {},
  setup: () => {
    return {};
  },
};
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

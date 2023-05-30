<template>
  <div>
    <p>called api.</p>
    <hr>
    <pre>{{ data }}</pre>
  </div>
</template>

<script lang="ts" setup>
  const { $apiDomain } = useNuxtApp();
  const { data } = await useFetch(`${$apiDomain}/api/ditto`);
</script>

export default defineNuxtPlugin(() => ({
  provide: {
    apiDomain: process.server ? 'http://localhost:3000' : '',
  },
}));

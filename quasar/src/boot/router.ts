// import VueRouter from 'vue-router';
import { boot } from 'quasar/wrappers';

// declare interface boot<TStore = any> {
//   (callback: {router:VueRouter, store}): any
// }
export default boot(({ router, store }) => {
  router.beforeEach((to, from, next) => {
    store
      .dispatch('users/checkSignIn')
      .then(() => {
        next();
      })
      .catch(() => {
        next();
      });
    // if (store.state.users.checkSignIn) {
    //   store.commit('users/setCheckSignIn', false);
    //   store
    //     .dispatch('users/getUsers')
    //     .then(() => {
    //       const user = store.state.users.users[0];
    //       if (user) {
    //         store.commit('users/signIn', user);
    //       }
    //       next();
    //     })
    //     .catch(() => {
    //       next();
    //     });
    // } else {
    //   next();
    // }
  });
  router.beforeEach((to, from, next) => {
    if (store.state.users.authenticated) {
      next();
    } else if (to.name === 'home') {
      next();
    } else if (to.name === 'sign_in') {
      next();
    } else {
      next({ name: 'sign_in', query: { redirect: to.fullPath } });
    }
  });
});

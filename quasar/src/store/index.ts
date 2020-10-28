import { store } from 'quasar/wrappers';
import Vuex from 'vuex';

// import example from './module-example';
// import { ExampleStateInterface } from './module-example/state';
import { UserState } from './users/state';
// import bookmarks from './bookmarks';
import users from './users';

/*
 * If not building with SSR mode, you can
 * directly export the Store instantiation
 */

export interface StoreInterface {
  // Define your own store structure, using submodules if needed
  // example: ExampleStateInterface;
  users: UserState;
  // Declared as unknown to avoid linting issue. Best to strongly type as per the line above.
  // example: unknown;
}
declare interface NodeModule {
  hot: {
    accept(path?: string[], callback?: () => void): void;
  };
}
declare const module: NodeModule;

export default store(function ({ Vue }) {
  Vue.use(Vuex);

  const Store = new Vuex.Store<StoreInterface>({
    modules: {
      // example
      // bookmarks,
      users,
    },

    // enable strict mode (adds overhead!)
    // for dev mode only
    strict: !!process.env.DEV
  });

  if (!!process.env.DEV && module.hot) {
    // module.hot.accept(['./bookmarks'], () => {
    //   const newModule = require('./bookmarks').default
    //   Store.hotUpdate({ modules: { bookmarks: newModule } })
    // })
    module.hot.accept(['./users'], () => {
      const newModule = require('./users').default
      Store.hotUpdate({ modules: { users: newModule } })
    })
  }
  return Store;
});

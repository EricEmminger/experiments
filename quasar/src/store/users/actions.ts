import axios from 'axios';
import { ActionTree } from 'vuex';
import { StoreInterface } from '../index';
import { UserState } from './state';
import { Feed, Item, Profile, User } from 'components/models';
import { v4 as uuidv4 } from 'uuid';

const baseUrl = 'http://api.spa.test';
axios.defaults.baseURL = baseUrl;
axios.defaults.withCredentials = true;

const actions: ActionTree<UserState, StoreInterface> = {
  catchAxiosError({ commit }, error) {
    let status = -1;
    let text = `${error}`;
    if (error.response) {
      status = error.response.status;
      text = error.response.statusText;
    }
    if (status === 401) {
      commit('signOut');
      commit('error', 'Sign in to continue.');
    }
    commit('error', `${status} ${text}`);
    return Promise.reject(error);
  },
  async checkSignIn({ commit, dispatch, state }) {
    if (state.checkSignIn) {
      commit('setCheckSignIn', false);
      await dispatch('getUsers')
        .then(() => {
          const user = state.users[0];
          if (user) {
            commit('signIn', user);
          }
        })
        .catch((error) => {
          commit('setErrors', []);
          return Promise.reject(error);
        });
    }
  },
  async getCurrentProfile({ commit, dispatch, state }) {
    if (!state.currentProfile) {
      await dispatch('getProfiles');
      commit('setCurrentProfile', state.profiles[0]);
    }
  },
  async getFeeds({ commit, dispatch, getters, state }) {
    if (!state.feeds.length) {
      await dispatch('getCurrentProfile');
      const profileId: number = getters.currentProfile.id;
      commit('setLoading', true);
      await axios
        .get(
          `/api/v1/feeds.json?include=subscriptions&filter[subscriptions.profile_id]=${profileId}`
        )
        .then((response) => {
          commit('setFeeds', response.data.data);
          commit('setLoading', false);
        })
        .catch((error) => {
          commit('setLoading', false);
          return dispatch('catchAxiosError', error);
        });
    }
  },
  async getItem({ commit, dispatch, getters, state }, id: string) {
    if (!state.item || state.item.id !== id) {
      commit('setItem', getters.findItem(id));
      if (!state.item) {
        commit('setLoading', true);
        // await axios
        //   .get(`/api/v1/items/${id}.json?include=profile,reactions`)
        //   .then((response) => {
        //     commit('setItem', response.data.data);
        //     commit('setLoading', false);
        //   })
        //   .catch((error) => {
        //     commit('setLoading', false);
        //     return dispatch('catchAxiosError', error);
        //   });
        let response = await Item.includes('profile').find(id)
        let item = response.data // Item instance
        commit('setItem', response.data);
        commit('setLoading', false);
      }
    }
  },
  async getItems({ commit, dispatch, getters, state }) {
    if (!state.items.length) {
      await dispatch('getCurrentProfile');
      const profileId: number = getters.currentProfile.id;
      commit('setLoading', true);
      // await axios
      //   .get(
      //     `/api/v1/items.json?include=profile,reactions&filter[profile_id]=${profileId}&filter[reactions.profile_id]=${profileId}&filter[reactions.kind]=open`
      //   )
      //   .then((response) => {
      //     commit('setItems', response.data.data);
      //     commit('setLoading', false);
      //   })
      //   .catch((error) => {
      //     commit('setLoading', false);
      //     return dispatch('catchAxiosError', error);
      //   });
        let response = await Item.includes('profile').where({profileId}).all()
        // response.data // array of Item instances
        commit('setItems', response.data);
        commit('setLoading', false);
        // console.log(`data ${JSON.stringify(response.data)}`, );
        // console.log(`meta ${JSON.stringify(response.meta)}`, );
        // console.log(`raw ${JSON.stringify(response.raw)}`, );
        // console.log(`response ${JSON.stringify(response)}`, );
  }
  },
  async getProfile({ commit, dispatch, getters, state }, id: string) {
    if (!state.profile || state.profile.id !== id) {
      commit('setProfile', getters.findProfile(id));
      if (!state.profile) {
        commit('setLoading', true);
        await axios
          .get(`/api/v1/profiles/${id}.json`)
          .then((response) => {
            commit('setProfile', response.data.data);
            commit('setLoading', false);
          })
          .catch((error) => {
            commit('setLoading', false);
            return dispatch('catchAxiosError', error);
          });
      }
    }
  },
  async getProfiles({ commit, dispatch, state }) {
    if (!state.profiles.length) {
      commit('setLoading', true);
      // `/api/v1/feeds.json?include=subscriptions&filter[subscriptions.profile_id]=${profileId}`
      // await axios
      //   .get('/api/v1/profiles.json?include=feeds')
      //   .then((response) => {
      //     commit('setProfiles', response.data.data);
      //     commit('setLoading', false);
      //   })
      //   .catch((error) => {
      //     commit('setLoading', false);
      //     return dispatch('catchAxiosError', error);
      //   });
        let response = await Profile.includes(['items','subscriptions']).all()
        
        // response.data // array of Profile instances
        commit('setProfiles', response.data);
        commit('setLoading', false);
        // console.log(`data ${JSON.stringify(response.data)}`, );
        // console.log(`meta ${JSON.stringify(response.meta)}`, );
        // console.log(`raw ${JSON.stringify(response.raw)}`, );
        // console.log(`response ${JSON.stringify(response)}`, );
    }
  },
  async getUser({ commit, dispatch, getters, state }, id: number) {
    if (!state.user || state.user.id !== id) {
      commit('setUser', getters.findUser(id));
      if (!state.user) {
        commit('setLoading', true);
        await axios
          .get(`/api/v1/users/${id}.json`)
          .then((response) => {
            commit('setUser', response.data.data);
            commit('setLoading', false);
          })
          .catch((error) => {
            commit('setLoading', false);
            return dispatch('catchAxiosError', error);
          });
      }
    }
  },
  async getUsers({ commit, dispatch, state }) {
    if (!state.users.length) {
      commit('setLoading', true);
      await axios
        .get('/api/v1/users.json')
        .then((response) => {
          commit('setUsers', response.data.data);
          commit('setLoading', false);
        })
        .catch((error) => {
          commit('setLoading', false);
          return dispatch('catchAxiosError', error);
        });
    }
  },
  async publishItem({ commit, dispatch, getters }, item: Item) {
    await dispatch('saveItem', item);
    await dispatch('getCurrentProfile');
    const profileId: number = getters.currentProfile.id;
    const feed: Feed = getters.currentProfile.feeds[0];
    commit('setLoading', true);
    await axios
      .put(`/api/v1/items/${item.id}.json`, {
        data: {
          type: 'items',
          attributes: {
            guid: `http://spa.test/profiles/${profileId}/items/${item.id}`,
            published: 'now',
          },
          relationships: {
            syndications: {
              data: {
                // 'temp-id': 'syndication',
                type: 'syndications',
                method: 'create',
              },
            },
          },
          included: [
            {
              // 'temp-id': 'syndication',
              type: 'syndications',
              attributes: {
                'feed_id': feed.id,
                'item_id': item.id,
              },
            },
          ],
        },
      })
      .then((response) => {
        const attributes = response.data.data.attributes;
        attributes.id = response.data.data.id;
        item = attributes;
        commit('setLoading', false);
      })
      .catch((error) => {
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async createItem({ commit, dispatch, getters }, item: Item) {
    await dispatch('getCurrentProfile');
    // if(!item.profile_id){}
    const profileId: number = getters.currentProfile.id;
    const uuid = uuidv4(); // ⇨ '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'
    commit('setLoading', true);
    await axios
      .post('/api/v1/items.json?include=profile', {
        data: {
          type: 'items',
          attributes: {
            // 'temp-id': 'item',
            guid: `http://spa.test/profiles/${profileId}/drafts/${uuid}`,
            'content_text': item.content,
            'profile_id': profileId,
          },
        },
      })
      .then((response) => {
        const attributes = response.data.data.attributes;
        attributes.id = response.data.data.id;
        commit('setDraft', { content: '' });
        commit('unshiftItem', attributes);
        commit('setLoading', false);
      })
      .catch((error) => {
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async updateItem({ commit, dispatch }, item: Item) {
    commit('setLoading', true);
    await axios
      .put(`/api/v1/items/${item.id}.json?include=profile,reactions`, {
        data: {
          type: 'items',
          attributes: {
            'content_text': item.content,
            // id: item.id,
          },
          id: item.id,
        },
      })
      .then((response) => {
        const attributes = response.data.data.attributes;
        attributes.id = response.data.data.id;
        commit('setDraft', { content: '' });
        commit('updateItem', attributes);
        commit('setLoading', false);
      })
      .catch((error) => {
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async saveItem({ dispatch }, item: Item) {
    if (item.id) {
      await dispatch('updateItem', item);
    } else {
      await dispatch('createItem', item);
    }
  },
  async signIn({ commit, dispatch }, user: User) {
    commit('setLoading', true);
    await axios
      .post('/users/sign_in.json', {
        user,
      })
      .then((response) => {
        user.id = response.data.id;
        user.email = response.data.email;
        commit('signIn', user);
        commit('setLoading', false);
      })
      .catch((error) => {
        const invalid = 'Email address and/or password are invalid.';
        commit('setErrors', []);
        commit('error', `${invalid}`);
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async signOut({ commit, dispatch }) {
    commit('setLoading', true);
    await axios
      .delete('/users/sign_out.json')
      .then(() => {
        commit('signOut');
        commit('setLoading', false);
      })
      .catch((error) => {
        const invalid = 'Sign out failed';
        commit('setErrors', []);
        commit('error', `${invalid}`);
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async subscribe({ commit, dispatch, getters }, feed: Feed) {
    await dispatch('getCurrentProfile');
    const profileId: number = getters.currentProfile.id;
    // if (!state.currentProfile) {
    //   await dispatch('getProfiles');
    //   state.currentProfile = state.profiles[0];
    // }
    commit('setLoading', true);
    await axios
      .post('/api/v1/subscriptions.json', {
        data: {
          type: 'subscriptions',
          attributes: {
            'profile_id': profileId,
            'feed_id': feed.id,
          },
        },
      })
      .then((response) => {
        const attributes = response.data.data.attributes;
        attributes.id = response.data.data.id;
        feed.subscriptions.push(attributes);
        commit('setLoading', false);
      })
      .catch((error) => {
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
  async unsubscribe({ commit, dispatch }, feed: Feed) {
    commit('setLoading', true);
    await axios
      .delete(`/api/v1/subscriptions/${feed.subscriptions[0].id}.json`)
      .then(() => {
        feed.subscriptions.pop();
        commit('setLoading', false);
      })
      .catch((error) => {
        commit('setLoading', false);
        return dispatch('catchAxiosError', error);
      });
  },
};

export default actions;

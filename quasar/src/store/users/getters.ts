import { GetterTree } from 'vuex';
import { StoreInterface } from '../index';
import { UserState } from './state';

const getters: GetterTree<UserState, StoreInterface> = {
  currentProfile: (state) => {
    return state.currentProfile ? state.currentProfile : state.profiles[0];
  },
  currentUserId: (state) => {
    return state.currentUser ? state.currentUser.id : null;
  },
  findItem: (state) => (id: string) => {
    return state.items.find((item) => item.id === id);
  },
  findProfile: (state) => (id: string) => {
    return state.profiles.find((profile) => profile.id === id);
  },
  findUser: (state) => (id: number) => {
    return state.users.find((user) => user.id === id);
  },
};

export default getters;

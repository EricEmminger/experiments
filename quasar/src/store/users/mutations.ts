import { MutationTree } from 'vuex';
import { UserState } from './state';
import { Error, Feed, Item, Profile, User } from 'components/models';

const mutation: MutationTree<UserState> = {
  error(state: UserState, message: string) {
    state.errors.push({ id: state.errors.length + 1, message: message });
  },
  setCheckSignIn(state: UserState, checkSignIn: boolean) {
    state.checkSignIn = checkSignIn;
  },
  setCurrentProfile(state: UserState, currentProfile: Profile) {
    state.currentProfile = currentProfile;
  },
  setDraft(state: UserState, draft: Item) {
    state.draft = draft;
  },
  setDraftContent(state: UserState, content: string) {
    state.draft.content = content;
  },
  setErrors(state: UserState, errors: Error[]) {
    state.errors = errors;
  },
  setFeeds(state: UserState, feeds: Feed[]) {
    state.feeds = feeds;
  },
  setItem(state: UserState, item: Item) {
    state.item = item;
  },
  setItems(state: UserState, items: Item[]) {
    state.items = items;
  },
  setLoading(state: UserState, loading: boolean) {
    state.loading = loading;
  },
  setProfile(state: UserState, profile: Profile) {
    state.profile = profile;
  },
  setProfiles(state: UserState, profiles: Profile[]) {
    state.profiles = profiles;
  },
  setUser(state: UserState, user: User) {
    state.user = user;
  },
  setUsers(state: UserState, users: User[]) {
    state.users = users;
  },
  signIn(state: UserState, user: User) {
    state.authenticated = true;
    state.currentUser = user;
    state.currentUser.password = '';
    state.errors = [];
  },
  signOut(state: UserState) {
    state.authenticated = false;
    state.currentUser = null;
    // state.currentUser.id = 0;
    // state.currentUser.email = '';
    // state.currentUser.password = '';
    // state.errors = [];
    state.loading = false;
    state.user = null;
    state.users = [];
  },
  unshiftItem(state: UserState, item: Item) {
    // if(state.items.find())
    state.items.unshift(item);
  },
  updateItem(state: UserState, item: Item) {
    // state.items.find((item) => item.id === id);
    const index = state.items.findIndex((element) => element.id === item.id)
    if(index){
    state.items[index] = item}
    state.item = item
  },
};

export default mutation;

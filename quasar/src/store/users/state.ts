import { Error, Feed, Item, Profile, User } from 'components/models';

export interface UserState {
  authenticated: boolean;
  checkSignIn: boolean;
  currentProfile: Profile | null | undefined;
  currentUser: User | null | undefined;
  draft: Item | null | undefined;
  errors: Error[];
  feeds: Feed[];
  item: Item | null | undefined;
  items: Item[];
  loading: boolean;
  profile: Profile | null | undefined;
  profiles: Profile[];
  user: User | null | undefined;
  users: User[];
}

const state: UserState = {
  authenticated: false,
  checkSignIn: true,
  // { id: 0, email: '', errors: [], password: '' }
  currentProfile: null,
  currentUser: null,
  draft: null,
  errors: [],
  feeds: [],
  item: null,
  items: [],
  loading: false,
  profile: null,
  profiles: [],
  user: null,
  users: [],
};

export default state;

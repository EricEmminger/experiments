<template>
  <q-layout view="hHh lpR fFf" class="bg-grey-1">
    <q-header elevated class="bg-white text-grey-8" height-hint="64">
      <q-toolbar class="GNL__toolbar">
        <q-btn
          flat
          dense
          round
          @click="leftDrawerOpen = !leftDrawerOpen"
          aria-label="Menu"
          icon="menu"
          class="q-mr-sm"
        />

        <q-toolbar-title
          v-if="$q.screen.gt.xs"
          shrink
          class="row items-center no-wrap"
        >
          <span class="q-ml-sm">Experiments</span>
        </q-toolbar-title>

        <q-space />

        <q-input
          class="GNL__toolbar-input"
          outlined
          dense
          v-model="search"
          color="bg-grey-7 shadow-1"
          placeholder="Search for topics, locations & sources"
        >
          <template v-slot:prepend>
            <q-icon v-if="search === ''" name="search" />
            <q-icon
              v-else
              name="clear"
              class="cursor-pointer"
              @click="search = ''"
            />
          </template>
          <template v-slot:append>
            <q-btn flat dense round aria-label="Menu" icon="arrow_drop_down">
              <q-menu anchor="bottom right" self="top right">
                <div class="q-pa-md" style="width: 400px">
                  <div class="text-body2 text-grey q-mb-md">
                    Narrow your search results
                  </div>

                  <div class="row items-center">
                    <div class="col-3 text-subtitle2 text-grey">
                      Exact phrase
                    </div>
                    <div class="col-9 q-pl-md">
                      <q-input dense v-model="exactPhrase" />
                    </div>

                    <div class="col-3 text-subtitle2 text-grey">Has words</div>
                    <div class="col-9 q-pl-md">
                      <q-input dense v-model="hasWords" />
                    </div>

                    <div class="col-3 text-subtitle2 text-grey">
                      Exclude words
                    </div>
                    <div class="col-9 q-pl-md">
                      <q-input dense v-model="excludeWords" />
                    </div>

                    <div class="col-3 text-subtitle2 text-grey">Website</div>
                    <div class="col-9 q-pl-md">
                      <q-input dense v-model="byWebsite" />
                    </div>

                    <div class="col-12 q-pt-lg row justify-end">
                      <q-btn
                        flat
                        dense
                        no-caps
                        color="grey-7"
                        size="md"
                        style="min-width: 68px"
                        label="Search"
                        v-close-popup
                      />
                      <q-btn
                        flat
                        dense
                        no-caps
                        color="grey-7"
                        size="md"
                        style="min-width: 68px"
                        @click="onClear"
                        label="Clear"
                        v-close-popup
                      />
                    </div>
                  </div>
                </div>
              </q-menu>
            </q-btn>
          </template>
        </q-input>

        <q-space />

        <div class="q-gutter-sm row items-center no-wrap">
          <q-btn round dense flat color="grey-8" icon="notifications">
            <q-badge color="red" text-color="white" floating>2</q-badge>
            <q-tooltip>Notifications</q-tooltip>
          </q-btn>
          <q-btn round flat>
            <q-avatar size="26px">
              <q-icon name="person" />
            </q-avatar>
            <!-- <q-tooltip>Account</q-tooltip> -->
            <q-menu auto-close>
              <q-list style="min-width: 100px" v-if="authenticated">
                <q-item :to="`/users/${currentUser.id}`">
                  <q-item-section
                    >Signed in as {{ currentUser.email }}</q-item-section
                  >
                </q-item>
                <q-separator />
                <!-- <q-item clickable>
                  <q-item-section>Settings</q-item-section>
                </q-item>
                <q-separator /> -->
                <q-item clickable @click="signOut">
                  <q-item-section>Sign out</q-item-section>
                </q-item>
              </q-list>
              <q-list style="min-width: 100px" v-else>
                <!-- <q-item>
                  <q-item-section>Account</q-item-section>
                </q-item>
                <q-separator /> -->
                <!-- v-for="link in accountMenuItems" :key="link.text" -->
                <q-item to="/users/sign_in">
                  <q-item-section>Sign in</q-item-section>
                </q-item>
              </q-list>
            </q-menu>
          </q-btn>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
      content-class="bg-white"
      :width="280"
    >
      <q-scroll-area class="fit">
        <q-list padding class="text-grey-8">
          <q-item
            class="GNL__drawer-item"
            v-ripple
            v-for="link in links1"
            :key="link.text"
            :to="link.to"
          >
            <q-item-section avatar>
              <q-icon :name="link.icon" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{ link.text }}</q-item-label>
            </q-item-section>
          </q-item>

          <q-separator inset class="q-my-sm" />

          <q-item
            class="GNL__drawer-item"
            v-ripple
            v-for="link in links2"
            :key="link.text"
            clickable
          >
            <q-item-section avatar>
              <q-icon :name="link.icon" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{ link.text }}</q-item-label>
            </q-item-section>
          </q-item>

          <q-separator inset class="q-my-sm" />

          <q-item
            class="GNL__drawer-item"
            v-ripple
            v-for="link in links3"
            :key="link.text"
            clickable
          >
            <q-item-section>
              <q-item-label>
                {{ link.text }}
                <q-icon v-if="link.icon" :name="link.icon" />
              </q-item-label>
            </q-item-section>
          </q-item>

          <div class="q-mt-md">
            <div class="flex flex-center q-gutter-xs">
              <a
                class="GNL__drawer-footer-link"
                href="javascript:void(0)"
                aria-label="Privacy"
                >Privacy</a
              >
              <span>·</span>
              <a
                class="GNL__drawer-footer-link"
                href="javascript:void(0)"
                aria-label="Terms"
                >Terms</a
              >
              <span>·</span>
              <a
                class="GNL__drawer-footer-link"
                href="javascript:void(0)"
                aria-label="About"
                >About</a
              >
            </div>
          </div>
        </q-list>
      </q-scroll-area>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script lang="ts">
import Vue from 'vue';
import { mapState } from 'vuex';
import { fasGlobeAmericas, fasFlask } from '@quasar/extras/fontawesome-v5';

export default Vue.extend({
  name: 'MainLayout',
  computed: {
    ...mapState('users', ['authenticated', 'currentUser']),
    // accountMenuItems() {
    //   if (authenticated) {
    //     return [
    //       { icon: 'person', text: 'Signed in as email address', to: '/users/sign_in' },
    //       { icon: 'person', text: 'Settings', to: '/api/users/sign_out' }
    //     ];
    //   } else {
    //     return [
    //       { icon: 'person', text: 'Sign in', to: '/users/sign_in' },
    //       { icon: 'person', text: 'Sign out', to: '/api/users/sign_out' }
    //     ];
    //   }
    // },
  },
  data() {
    return {
      leftDrawerOpen: false,
      search: '',
      showAdvanced: false,
      showDateOptions: false,
      exactPhrase: '',
      hasWords: '',
      excludeWords: '',
      byWebsite: '',
      byDate: 'Any time',
      links1: [
        { icon: 'bookmarks', text: 'Bookmarks', to: '/bookmarks' },
        { icon: 'drafts', text: 'Drafts', to: '/drafts' },
        { icon: 'rss_feed', text: 'Feeds', to: '/feeds' },
        { icon: 'list', text: 'Items', to: '/items' },
        // { icon: 'person', text: 'Feed Items', to: '/feed-items' },
        { icon: 'people', text: 'Profiles', to: '/profiles' },
        { icon: 'people', text: 'Users', to: '/users' },
        // { icon: 'web', text: 'Top stories' },
        // { icon: 'search', text: 'Saved searches' }
      ],
      links2: [
        { icon: 'flag', text: 'Canada' },
        { icon: fasGlobeAmericas, text: 'World' },
        { icon: 'place', text: 'Local' },
        { icon: 'domain', text: 'Business' },
        { icon: 'memory', text: 'Technology' },
        { icon: 'local_movies', text: 'Entertainment' },
        { icon: 'directions_bike', text: 'Sports' },
        { icon: fasFlask, text: 'Science' },
        { icon: 'fitness_center', text: 'Health ' },
      ],
      links3: [
        { icon: '', text: 'Language & region' },
        { icon: '', text: 'Settings' },
        { icon: 'open_in_new', text: 'Get the Android app' },
        { icon: 'open_in_new', text: 'Get the iOS app' },
        { icon: '', text: 'Send feedback' },
        { icon: 'open_in_new', text: 'Help' },
      ],
    };
  },
  methods: {
    onClear() {
      this.exactPhrase = '';
      this.hasWords = '';
      this.excludeWords = '';
      this.byWebsite = '';
      this.byDate = 'Any time';
    },
    // changeDate(option) {
    //   this.byDate = option;
    //   this.showDateOptions = false;
    // },
    signOut() {
      // console.log('signOut');
      this.$store
        .dispatch('users/signOut')
        .then(() => {
          if (this.authenticated) {
            this.$q.notify({
              message: 'Sign out failed',
              position: 'top',
              type: 'negative',
            });
          } else {
            this.$q.notify({
              message: 'Signed out successfully',
              position: 'top',
              type: 'positive',
            });
            this.$router.push({ name: 'home' });
          }
        })
        .catch(() => {
          this.$q.notify({
            message: 'Sign out failed',
            position: 'top',
            type: 'negative',
          });
        });
    },
  },
});
</script>

<style lang="sass">
.GNL

  &__toolbar
    height: 64px

  &__toolbar-input
    width: 55%

  &__drawer-item
    line-height: 24px
    border-radius: 0 24px 24px 0
    margin-right: 12px

    .q-item__section--avatar
      .q-icon
        color: #5f6368

    .q-item__label
      color: #3c4043
      letter-spacing: .01785714em
      font-size: .875rem
      font-weight: 500
      line-height: 1.25rem

  &__drawer-footer-link
    color: inherit
    text-decoration: none
    font-weight: 500
    font-size: .75rem

    &:hover
      color: #000
</style>

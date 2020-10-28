<template>
  <q-page padding>
    <q-toolbar style="max-width: 400px">
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="rss_feed" label="Feeds" to="/feeds" />
      </q-breadcrumbs>
      <!-- <q-toolbar-title>
        Feeds
      </q-toolbar-title> -->
      <q-space />
      <q-btn
        flat
        round
        dense
        icon="add"
        :to="{
          name: 'feedNew',
          params: { id: null },
        }"
      />
    </q-toolbar>
    <div class="q-pa-md q-gutter-md" style="max-width: 400px">
      <q-banner
        class="text-white bg-red"
        v-for="error in errors"
        :key="error.id"
      >
        {{ error.message }}
      </q-banner>
      <q-banner v-if="loading" class="text-white bg-info">
        Loading...
      </q-banner>
      <q-list bordered separator>
        <feed-item
          v-for="feed in feeds"
          :key="feed.id"
          :feed="feed"
          :profile="profile"
        ></feed-item>
      </q-list>
    </div>
  </q-page>
</template>

<script lang="ts">
import Vue from 'vue';
import { mapActions, mapGetters, mapMutations, mapState } from 'vuex';
import {
  QPage,
  QToolbar,
  QBreadcrumbs,
  QBreadcrumbsEl,
  QBanner,
  QList
} from 'quasar';
import FeedItem from '../components/FeedItem.vue';
import { Feed, Profile } from '../components/models';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QBanner,
    QList,
    FeedItem,
  },
  computed: {
    ...mapGetters('users', ['currentProfile']),
    ...mapState('users', ['errors', 'loading']),
  },
  data() {
    const feeds: Feed[] = [];
    const profile: Profile = null
    return { feeds, profile };
  },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Feeds - SPA',
  },
  methods: {
    ...mapActions('users', ['getCurrentProfile', 'getFeeds']),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    async loadData() {
      await this.getCurrentProfile();
      const profileId = this.currentProfile.id;
      // this.getFeeds();
      //`/api/v1/feeds.json?include=subscriptions&filter[subscriptions.profile_id]=${profileId}`

      let feedsProxy = await Feed.includes('subscriptions')
        .where({ subscriptions: { profileId } })
        .all();
      this.feeds = feedsProxy.data;
      let profileProxy = await Profile.find(profileId)
      this.profile = profileProxy.data
    },
  },
});
</script>

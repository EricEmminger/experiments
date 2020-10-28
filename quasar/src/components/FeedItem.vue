<template>
  <q-item :to="{ name: 'feed', params: { id: feed.id } }">
    <q-item-section>
      <q-item-label>{{ feed.title }}</q-item-label>
      <q-item-label caption lines="2">{{ feed.summary }}</q-item-label>
      <q-item-label caption>{{ feed.url }}</q-item-label>
    </q-item-section>
    <q-item-section side top>
      <q-item-label caption>{{
        subscribed ? 'subscribed' : 'unsubscribed'
      }}</q-item-label>
      <q-checkbox v-model="subscribed" :disable="loading" />
    </q-item-section>
  </q-item>
</template>

<script lang="ts">
import Vue from 'vue';
import { mapActions, mapGetters, mapMutations, mapState } from 'vuex';
import { QItem, QItemSection, QItemLabel, QCheckbox } from 'quasar';
import { Feed, Subscription } from '../components/models';

export default Vue.extend({
  name: 'FeedItem',
  components: {
    QItem,
    QItemSection,
    QItemLabel,
    QCheckbox,
  },
  props: {
    feed: Object,
    profile: Object,
  },
  computed: {
    ...mapGetters('users', ['currentProfile']),
    ...mapState('users', ['errors', 'loading', 'profiles']),
    subscribed: {
      get(): boolean {
        return this.feed.subscriptions.length > 0;
      },
      set(value: boolean) {
        console.log(`set subscribed ${value}`);
        if (value) {
          this.subscribe(this.feed);
        } else {
          this.unsubscribe(this.feed);
        }
      },
    },
  },
  watch: {
    subscribed: function (value, was) {
      console.log(`watch subscribed ${value} was ${was}`);
    },
  },
  methods: {
    ...mapActions('users', ['getCurrentProfile']),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    async subscribe(feed: Feed) {
      // const feedId = feed.id;
      // await this.getCurrentProfile();
      const profile = this.profile;
      let subscription = new Subscription({ feed, profile });
      // , mute:false, notify:true
      // subscription.feed = feed
      // subscription.profile = profile
      // subscription.attributes.feedId = feed.id
      // subscription.attributes.profileId = profile.id
      // profile.subscriptions.push(subscription);
      console.log(subscription)
      // let success = await profile.save()
      // post.save({ with: "comments.id" })
      let success = await subscription.save({ with: ["feed.id",'profile.id'] }); // POST /subscriptions
      console.log(success); // true/false
      if (success) {
        feed.subscriptions.push(subscription);
      }
    },
    async unsubscribe(feed: Feed){
      let subscription = feed.subscriptions[0]
      // subscription.isMarkedForDestruction = true
      let success = await subscription.destroy()
      console.log(success); // true/false
      if (success) {
        feed.subscriptions.pop()
        // feed.save({with:'subscriptions.id'})
      }
    }
  },
});
</script>

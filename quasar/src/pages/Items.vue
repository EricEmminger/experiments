<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el
          icon="view_list"
          label="Feeds"
          to="/feeds"
          v-if="this.$route.params.id"
        />
        <q-breadcrumbs-el
          icon="rss_feed"
          :label="label"
          :to="{
            name: 'feed',
            params: { id: this.$route.params.id },
          }"
          v-if="this.$route.params.id"
        />
        <q-breadcrumbs-el icon="list" label="Items" />
      </q-breadcrumbs>
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
      <template v-if="items.length">
        <item-card
          v-for="item in items"
          :key="item.id"
          :item="item"
        ></item-card>
        <q-list bordered separator>
          <q-item
            v-for="item in items"
            :key="item.id"
            :to="{ name: 'item', params: { id: item.id } }"
          >
            <q-item-section>
              <q-item-label overline>{{ item.profile.name }}</q-item-label>
              <q-item-label lines="1">{{ item.title }}</q-item-label>
              <q-item-label caption lines="2">{{
                item.contentPlain
              }}</q-item-label>
              <q-item-label caption>{{ item.published }}</q-item-label>
            </q-item-section>
            <q-item-section side top>
              <q-item-label caption v-if="item.reactions.length"
                >seen</q-item-label
              >
              <q-item-label caption v-else>unseen</q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </template>
      <q-banner v-else class="text-white bg-info">
        There are no items to show.
      </q-banner>
      <!-- <template v-else></template> -->
    </div>
  </q-page>
</template>

<script lang="ts">
import axios from 'axios';
import Vue from 'vue';
import { mapActions, mapGetters, mapMutations, mapState } from 'vuex';
import {
  QBanner,
  QBreadcrumbs,
  QBreadcrumbsEl,
  QCard,
  QCardSection,
  QItem,
  QItemLabel,
  QItemSection,
  QList,
  QPage,
  QToolbar
} from 'quasar';
import ItemCard from '../components/ItemCard.vue';
import { Item } from '../components/models';

export default Vue.extend({
  components: {
    QBanner,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QCard,
    QCardSection,
    QItem,
    QItemLabel,
    QItemSection,
    QList,
    QPage,
    QToolbar,
    ItemCard,
  },
  props: ['scope'],
  computed: {
    ...mapGetters('users', ['currentProfile']),
    ...mapState('users', ['errors', 'loading']),
    label: function () {
      return 'Feed ' + this.$route.params.id;
    },
  },
  data() {
    const items: Item[] = [];
    return { items };
  },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Items - SPA',
  },
  methods: {
    ...mapActions('users', ['getCurrentProfile']),
    ...mapMutations('users', ['setItems', 'setLoading']),
    async loadData() {
      await this.getCurrentProfile();
      const profileId = this.currentProfile.id;
      let s = Item.includes(['profile', 'reactions']);
      if (this.scope === 'drafts') {
        let response = await s
          .where({ profileId })
          .where({ draft: true })
          .all();
        this.items = response.data; // array of Item instances
        // this.setItems(response.data);
      } else {
        // includes({syndications:{feeds: 'subscriptions'}})
        // .where({ syndications:{feeds: { subscriptions: { profileId } }} })
        s = s
          .where({ subscriptionId: profileId })
          // .where({ draft: false })
          .where({ reactions: { kind: 'open',profileId } });
        let url =
          'http://api.spa.test/api/v1/items.json?include=profile,reactions&filter[profile_id]=1&filter[reactions.profile_id]=1&filter[reactions.kind]=open';
        if (this.$route.params.id) {
          url =
            'http://api.spa.test/api/v1/items.json?include=profile,reactions&filter[feed_id]=' +
            this.$route.params.id +
            '&filter[reactions.profile_id]=1&filter[reactions.kind]=open';
        }
        // axios.get(url).then((response) => {
        //   this.items = response.data.data;
        // });
        let response = await s.all();
        this.items = response.data; // array of Item instances
      }
    },
  },
});
</script>

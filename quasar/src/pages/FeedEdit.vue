<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="rss_feed" label="Feeds" to="/feeds" />
        <q-breadcrumbs-el
          v-if="this.id"
          icon="description"
          :label="`Feed ${id}`"
          :to="{
            name: 'feed',
            params: { id: this.id },
          }"
        />
        <q-breadcrumbs-el
          v-if="this.id"
          icon="edit"
          label="Edit"
          :to="{
            name: 'feedEdit',
            params: { id: this.id },
          }"
        />
        <q-breadcrumbs-el
          v-else
          icon="create"
          label="Create"
          :to="{
            name: 'feedNew',
          }"
        />
      </q-breadcrumbs>
    </q-toolbar>
    <q-form
      @submit.prevent="save"
      class="q-pa-md q-gutter-md"
      style="max-width: 400px"
      autofocus
    >
      <q-banner
        class="text-white bg-red"
        v-for="error in feed.errors"
        :key="error.id"
      >
        {{ error.fullMessage }}
      </q-banner>
      <q-banner v-if="loading" class="text-white bg-info">
        Loading...
      </q-banner>
      <q-input
        v-model="feed.url"
        type="url"
        label="URL"
        hint="URL"
        :rules="[(val) => !!val || 'URL is required']"
        lazy-rules
        filled
        :disable="loading"
        :loading="loading"
      />
      <q-btn
        type="submit"
        icon="save"
        label="Save"
        :disable="loading"
        :loading="loading"
        color="primary"
        class=""
      />
    </q-form>
    <div class="q-pa-md q-gutter-md" style="max-width: 400px">
      <template v-if="feed">
        <q-card flat bordered>
          <q-item>
            <q-item-section>
              <q-card-actions> </q-card-actions>
            </q-item-section>
          </q-item>
        </q-card>
      </template>
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
  QCard,
  QCardActions,
  QBtn
} from 'quasar';
import { Feed } from '../components/models';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QBanner,
    QCard,
    QCardActions,
    QBtn,
  },
  props: ['id'],
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['draft', 'errors', 'item', 'loading']),
    // content: {
    //   get() {
    //     return this.$store.state.users.draft.content;
    //   },
    //   set(value) {
    //     this.$store.commit('users/setDraftContent', value);
    //   },
    // },
  },
  data() {
    const feed = new Feed();
    return {
      // passwordType: true,
      feed,
    };
  },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Edit Feed - SPA',
  },
  methods: {
    ...mapActions('users', [
      'getCurrentProfile',
      'getItem',
      'publishItem',
      'saveItem',
    ]),
    ...mapMutations('users', ['setDraft', 'setLoading']),
    async loadData() {
      // await this.getCurrentProfile();
      if (this.id) {
        let response = await Feed.find(this.id);
        this.feed = response.data;

        // this.getItem(this.id).then(() => {
        //   this.setDraft({ ...this.item });
        // });
      } else {
      }
      // this.getItems().then(() => {});
    },
    publish() {
      // this.publishItem(this.draft).then(() => {
      // });
    },
    async save() {
      // let feed = new Feed({ title: 'My Feed' });
      let success = await this.feed.save(); // POST /feeds
      console.log(success); // true/false

      // feed.title = 'Updated Title';
      // success = await feed.save(); // PUT /feeds/:id
      // console.log(success); // true/false

      if (success) {
        this.$q.notify({
          message: `Saved feed ${this.feed.id}`,
          position: 'top',
          type: 'positive',
        });
        this.$router.push({
          name: 'feed',
          params: { id: this.feed.id },
        });
      } else {
        this.$q.notify({
          message: 'Save failed',
          position: 'top',
          type: 'negative',
        });
      }

      // this.saveItem(this.draft).then(() => {
      // });
    },
  },
});
</script>

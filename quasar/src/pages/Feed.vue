<template>
  <q-page class="row">
    <div class="q-pa-md row items-start q-gutter-md">
      <q-card class="my-card" flat bordered>
        <q-card-section horizontal>
          <q-card-section class="q-pt-xs">
            <div class="text-overline">Overline</div>
            <div class="text-h5 q-mt-sm q-mb-xs">{{ feed.title }}</div>
            <div class="text-caption text-grey">{{ feed.summary }}</div>
          </q-card-section>

          <q-card-section class="col-5 flex flex-center">
            <q-img
              class="rounded-borders"
              src="https://cdn.quasar.dev/img/parallax2.jpg"
            />
          </q-card-section>
        </q-card-section>

        <q-separator />

        <q-card-actions>
          <q-btn flat round icon="event" />
          <q-btn flat>
            7:30PM
          </q-btn>
          <q-btn
            flat
            color="primary"
            :to="{ name: 'feed_items', params: { id: id } }"
          >
            Items
          </q-btn>
        </q-card-actions>
      </q-card>
    </div>
    <q-card class="my-card">
      <q-card-section>
        <div class="text-h6">{{ feed.title }}</div>
        <div class="text-subtitle2">{{ feed.summary }}</div>
      </q-card-section>
    </q-card>
    <q-list bordered separator style="max-width: 350px">
      <q-item>
        <q-item-section>
          <q-item-label>{{ feed.title }}</q-item-label>
          <q-item-label caption>{{ feed.summary }}</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
    <div class="q-pa-md" style="max-width: 350px"></div>
  </q-page>
</template>

<script lang="ts">
import axios from 'axios';
import Vue from 'vue';

export default Vue.extend({
  computed: {
    id: function() {
      return this.$route.params.id;
    }
  },
  data() {
    const feed = { title: '' };
    const title = 'Feed - SPA';
    return { feed, title };
  },
  meta: {
    title: 'Feed - SPA'
  },
  methods: {
    loadData() {
      axios
        .get(
          'http://api.spa.test/api/v1/feeds/' +
            this.$route.params.id +
            '.json',
          {
            withCredentials: true
          }
        )
        .then(response => {
          this.feed = response.data.data;
          this.title =
            'Feed ' +
            this.$route.params.id +
            ': ' +
            this.feed.title +
            ' - SPA';
        })
        .catch(error => {
          console.log(error);
          if (error.response.status === 401) {
            console.log('response.status === 401; redirect to /users/sign_in');
            this.$router.replace('/users/sign_in');
          }
        });
    },
    createReaction(kind: string) {
      axios
        .post(
          'http://api.spa.test/api/v1/reactions',
          {
            data: {
              type: 'reactions',
              attributes: {
                'profile_id': '1',
                'item_id': this.$route.params.id,
                kind: kind
              }
            }
          },
          {
            withCredentials: true
          }
        )
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
          if (error.response.status === 401) {
            console.log('response.status === 401; redirect to /users/sign_in');
            this.$router.replace('/users/sign_in');
          }
        });
    }
  },
  created: function() {
    this.loadData();
    // this.createReaction('open');
  }
});
</script>

<style lang="sass">
h2
  font-size: 1.5rem
  line-height: 2rem
  letter-spacing: normal
  font-weight: 400
h3
  font-size: 1.25rem
  line-height: 2rem
  letter-spacing: .0125em
  font-weight: 500
</style>

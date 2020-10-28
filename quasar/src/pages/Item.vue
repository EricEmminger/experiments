<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="list" label="Items" to="/items" />
        <q-breadcrumbs-el
          icon="description"
          :label="`Item ${id}`"
          :to="{
            name: 'item',
            params: { id: this.id },
          }"
        />
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
      <template v-if="item">
        <item-card :item="item"></item-card>
        <q-card>
          <q-card-section>
            <div class="text-h6">{{ item.title }}</div>
            <div class="text-subtitle2">{{ item.published }}</div>
          </q-card-section>
          <q-card-section class="q-pt-none" v-html="item.content_safe">
          </q-card-section>
        </q-card>
        <q-list bordered separator>
          <q-item>
            <q-item-section>
              <q-item-label>{{ item.title }}</q-item-label>
              <q-item-label v-html="item.content_safe"></q-item-label>
              <q-item-label caption>{{ item.published }}</q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </template>
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
  props: ['id'],
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['errors', 'item', 'loading']),
  },
  // data() {
  //   const item = {};
  //   return { item };
  // },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
    // this.createReaction('open');
  },
  meta: {
    title: 'Item - SPA',
  },
  methods: {
    ...mapActions('users', [
      'getCurrentProfile',
      'getItem',
      'publishItem',
      'saveItem',
    ]),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    async loadData() {
      await this.getCurrentProfile();
      await this.getItem(this.id);
      // axios
      //   .get(
      //     'http://api.spa.test/api/v1/items/' + this.$route.params.id + '.json',
      //     {
      //       withCredentials: true,
      //     }
      //   )
      //   .then((response) => {
      //     this.item = response.data.data;
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //     if (error.response.status === 401) {
      //       console.log('response.status === 401; redirect to /users/sign_in');
      //       this.$router.replace('/users/sign_in');
      //     }
      //   });
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
                kind: kind,
              },
            },
          },
          {
            withCredentials: true,
          }
        )
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
          if (error.response.status === 401) {
            console.log('response.status === 401; redirect to /users/sign_in');
            this.$router.replace('/users/sign_in');
          }
        });
    },
  },
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

<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="people" label="Users" to="/users" />
        <q-breadcrumbs-el icon="person" :label="`User ${id}`" />
      </q-breadcrumbs>
    </q-toolbar>
    <div class="q-pa-md q-gutter-md" style="max-width: 400px;">
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
      <q-card v-if="user" class="my-card" flat bordered>
        <q-card-section horizontal>
          <q-card-section class="q-pt-xs">
            <div class="text-overline">Overline</div>
            <div class="text-h5 q-mt-sm q-mb-xs">{{ user.email }}</div>
            <div class="text-caption text-grey">id {{ user.id }}</div>
            <div class="text-caption text-grey">
              created_at {{ user.created_at }}
            </div>
            <div class="text-caption text-grey">
              current_sign_in_at {{ user.current_sign_in_at }}
            </div>
            <div class="text-caption text-grey">
              current_sign_in_ip {{ user.current_sign_in_ip }}
            </div>
            <div class="text-caption text-grey">
              last_sign_in_at {{ user.last_sign_in_at }}
            </div>
            <div class="text-caption text-grey">
              last_sign_in_ip {{ user.last_sign_in_ip }}
            </div>
            <div class="text-caption text-grey">
              updated_at {{ user.updated_at }}
            </div>
          </q-card-section>
        </q-card-section>
        <q-separator />
        <q-card-actions>
          <q-btn flat color="primary" to="/profiles">
            Profiles
          </q-btn>
        </q-card-actions>
      </q-card>
    </div>
    <div class="q-pa-md row items-start q-gutter-md"></div>
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
  QCardSection,
  QSeparator,
  QCardActions,
  QBtn
} from 'quasar';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QBanner,
    QCard,
    QCardSection,
    QSeparator,
    QCardActions,
    QBtn
  },
  props: ['id'],
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['errors', 'loading', 'user'])
  },
  watch: {
    $route: 'loadData'
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'User - SPA'
  },
  methods: {
    ...mapActions('users', ['getUser']),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    loadData() {
      // this.loading = true;
      // this.$store.commit('users/setLoading', true);
      // this.setLoading(true);
      // this.$store.commit('users/setErrors', []);
      // this.setErrors([]);
      // this.$store.dispatch('users/getUser', this.id).then(() => {
      this.getUser(this.id).then(() => {
        // this.loading = false;
        // this.$store.commit('users/setLoading', false);
        // this.setLoading(false);
      });
    }
  }
});
</script>

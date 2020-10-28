<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="people" label="Users" to="/users" />
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
      <q-list bordered separator>
        <q-item
          v-for="user in users"
          :key="user.id"
          :to="{ name: 'user', params: { id: user.id } }"
        >
          <q-item-section>
            <q-item-label>{{ user.email }}</q-item-label>
            <q-item-label caption lines="2">{{ user.id }}</q-item-label>
            <q-item-label>created_at {{ user.created_at }}</q-item-label>
          </q-item-section>
        </q-item>
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
  QList,
  QItem,
  QItemSection,
  QItemLabel
} from 'quasar';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QBanner,
    QList,
    QItem,
    QItemSection,
    QItemLabel,
  },
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['errors', 'loading', 'users']),
  },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Users - SPA',
  },
  methods: {
    ...mapActions('users', ['getUsers']),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    loadData() {
      // this.setLoading(true);
      this.getUsers().then(() => {
        // this.setLoading(false);
      });
    },
  },
});
</script>

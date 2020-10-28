<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el label="Home" icon="home" to="/" />
      </q-breadcrumbs>
    </q-toolbar>
    <div class="q-pa-md q-gutter-md" style="max-width: 400px;">
      <template v-if="authenticated">
        <q-banner class="bg-primary text-white">
          Signed in as {{ currentUser.email }}
          <!-- <template v-slot:action>
            <q-btn
              type="submit"
              label="Sign out"
              color="primary"
              @click="signOut"
            />
          </template> -->
        </q-banner>
      </template>
      <template v-else>
        <p>
          Welcome! <router-link to="/users/sign_in">Sign in</router-link> to
          continue.
        </p>
        <q-banner class="bg-primary text-white">
          Welcome! Sign in to continue.
          <template v-slot:action>
            <q-btn label="Sign in" color="primary" to="/users/sign_in" />
          </template>
        </q-banner>
      </template>
      <!-- <q-form @submit.prevent="signOut">
        <q-btn type="submit" label="Sign out" color="primary" />
      </q-form> -->
    </div>
  </q-page>
</template>

<script lang="ts">
import Vue from 'vue';
import { mapState } from 'vuex';
import {
  QPage,
  QBtn,
  QBanner,
  QToolbar,
  QBreadcrumbs,
  QBreadcrumbsEl
} from 'quasar';

export default Vue.extend({
  components: {
    QPage,
    QBtn,
    QBanner,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl
  },
  computed: {
    ...mapState('users', ['authenticated', 'currentUser'])
  },
  meta: {
    title: 'SPA'
  },
  methods: {
  }
});
</script>

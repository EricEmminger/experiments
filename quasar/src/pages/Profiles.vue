<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="people" label="Profiles" to="/profiles" />
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
      <q-select
        v-model="selected"
        :options="profiles"
        :option-label="(profile) => `${profile.name} (${profile.url})`"
        option-value="id"
        label="Current Profile"
        filled
      />
      <q-list bordered separator>
        <q-item
          v-for="profile in profiles"
          :key="profile.id"
          :to="{ name: 'profile', params: { id: profile.id } }"
        >
          <q-item-section>
            <!-- <q-item-label>{{ profile.label }}</q-item-label> -->
            <q-item-label>{{ profile.name }}</q-item-label>
            <q-item-label>private? {{ profile.private }}</q-item-label>
            <q-item-label>{{ profile.url }}</q-item-label>
            <q-item-label>Owned by User {{ profile.user_id }}</q-item-label>
          </q-item-section>
          <!-- <q-item-section side top>
            <q-item-label caption>{{
              profile.id === currentProfile.id ? 'current' : 'not current'
            }}</q-item-label>
            <q-btn
              type="button"
              :icon="
                profile.id === currentProfile.id
                  ? 'radio_button_checked'
                  : 'radio_button_unchecked'
              "
              label="Switch"
              :disable="loading"
              :loading="loading"
              color="primary"
              @click.prevent="setCurrent(profile)"
            />
          </q-item-section> -->
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
    ...mapGetters('users', []),
    ...mapState('users', ['currentProfile','errors', 'loading', 'profiles']),
    selected: {
      get() {
        return this.currentProfile;
      },
      set(value) {
        // console.log(value)
        this.setCurrentProfile(value);
      },
    },
    // options() {
    //   return this.profiles.map((profile) => {
    //     label: profile.url;
    //     value: profile.id;
    //   });
    // },
    // current: { profile.id === this.currentProfile.id}
  },
  // data() {
  //   return { selected: null };
  // },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Profiles - SPA',
  },
  methods: {
    ...mapActions('users', ['getProfiles']),
    ...mapMutations('users', ['setCurrentProfile','setErrors', 'setLoading']),
    async loadData() {
      await this.getProfiles().then(() => {
        // this.selected = this.profiles[0];
      });
    },
    // setCurrent(profile) {
    //   console.log(`setCurrent(profile) ${profile.id}`);
    //   this.setCurrentProfile().then(() => {
    //   });
    // },
  },
});
</script>

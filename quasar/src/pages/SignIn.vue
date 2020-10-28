<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="login" label="Sign in" to="/users/sign_in" />
      </q-breadcrumbs>
    </q-toolbar>
    <q-form
      @submit.prevent="submit"
      class="q-pa-md q-gutter-md"
      style="max-width: 400px"
      autofocus
    >
      <q-banner
        class="text-white bg-red"
        v-for="error in errors"
        :key="error.id"
      >
        {{ error.message }}
      </q-banner>
      <q-input
        v-model="user.email"
        type="email"
        label="Email address"
        hint="Email address"
        :rules="[(val) => !!val || 'Email address is required']"
        lazy-rules
        :disable="loading"
        filled
        autocomplete="email"
      />
      <q-input
        v-model="user.password"
        :type="passwordType ? 'password' : 'text'"
        label="Password"
        hint="Password"
        :rules="[(val) => !!val || 'Password is required']"
        lazy-rules
        :disable="loading"
        filled
        autocomplete="current-password"
      >
        <template v-slot:append>
          <q-icon
            :name="passwordType ? 'visibility_off' : 'visibility'"
            class="cursor-pointer"
            @click="passwordType = !passwordType"
          />
        </template>
      </q-input>
      <div class="row">
        <div class="col">
          <q-btn
            type="submit"
            icon="login"
            label="Sign in"
            :disable="loading"
            :loading="loading"
            color="primary"
            class=""
          />
        </div>
        <div class="col">
          <q-checkbox
            v-model="user.remember_me"
            label="Remember me"
            :disable="loading"
            class=""
          />
          <!-- true-value="1"
          false-value="0" -->
        </div>
      </div>
    </q-form>
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
  QForm,
  QBanner,
  QInput,
  QIcon,
  QBtn,
  QCheckbox
} from 'quasar';
import { User } from '../components/models';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QForm,
    QBanner,
    QInput,
    QIcon,
    QBtn,
    QCheckbox,
  },
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['authenticated', 'currentUser', 'errors', 'loading']),
  },
  data() {
    const user: User = {
      email: 'EricEmminger@gmail.com',
      password: '',
      'remember_me': true,
    };
    return {
      passwordType: true,
      user,
    };
  },
  meta: {
    title: 'Sign in - SPA',
  },
  // created() {},
  methods: {
    ...mapActions('users', ['signIn']),
    ...mapMutations('users', ['setErrors', 'setLoading']),
    submit() {
      this.signIn(this.user)
        .then(() => {
          if (this.authenticated) {
            this.$q.notify({
              message: `Signed in as ${this.currentUser.email}`,
              position: 'top',
              type: 'positive',
            });
            if (this.$route.query.redirect) {
              this.$router.push(this.$route.query.redirect);
            } else {
              this.$router.push({
                name: 'user',
                params: { id: this.currentUser.id },
              });
            }
          } else {
            this.$q.notify({
              message: 'Sign in failed',
              position: 'top',
              type: 'negative',
            });
          }
        })
        .catch(() => {
          this.$q.notify({
            message: 'Sign in failed',
            position: 'top',
            type: 'negative',
          });
        });
    },
  },
});
</script>

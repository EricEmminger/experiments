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
        <q-breadcrumbs-el
          icon="edit"
          label="Edit"
          :to="{
            name: 'itemEdit',
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
        <q-card flat bordered>
          <q-item>
            <q-item-section>
              <q-form>
                <q-input
                  v-model="content"
                  type="textarea"
                  label="Write something..."
                  hint=""
                  filled
                  autogrow
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
                  @click.prevent="save"
                />
                <q-btn
                  type="submit"
                  icon="publish"
                  label="Publish"
                  :disable="loading"
                  :loading="loading"
                  color="primary"
                  class=""
                  @click.prevent="publish"
                />
              </q-form>
              <q-card-actions> </q-card-actions>
              <div class="row items-center justify-between no-wrap">
                <div class="row items-center">
                  <q-icon
                    name="repeat"
                    color="grey-4"
                    class="q-mr-sm"
                    size="18px"
                  />
                  <q-skeleton type="text" width="30px" />
                </div>
              </div>
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
    content: {
      get() {
        return this.$store.state.users.draft.content;
      },
      set(value) {
        this.$store.commit('users/setDraftContent', value);
      },
    },
  },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Edit Item - SPA',
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
      await this.getCurrentProfile();
      this.getItem(this.id).then(() => {
        this.setDraft({ ...this.item });
      });
      // this.getItems().then(() => {});
    },
    publish() {
      // this.publishItem(this.draft).then(() => {
      // });
    },
    save() {
      this.saveItem(this.draft).then(() => {
        this.$q.notify({
          message: `Saved item ${this.id}`,
          position: 'top',
          type: 'positive',
        });
        this.$router.push({
          name: 'item',
          params: { id: this.id },
        });
      });
    },
  },
});
</script>

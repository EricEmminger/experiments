<template>
  <q-page padding>
    <q-toolbar>
      <q-breadcrumbs>
        <q-breadcrumbs-el icon="home" to="/" />
        <q-breadcrumbs-el icon="people" label="Profiles" to="/profiles" />
        <q-breadcrumbs-el icon="person" :label="`Profile ${id}`" />
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
      <template v-if="profile">
        <q-card flat bordered>
          <q-item>
            <q-item-section avatar>
              <q-skeleton type="QAvatar" />
            </q-item-section>
            <q-item-section>
              <q-item-label>
                {{ profile.name }}
              </q-item-label>
              <q-item-label caption>
                {{ profile.url }}
              </q-item-label>
            </q-item-section>
          </q-item>
          <q-item> description </q-item>
          <q-item>
            <q-item-section avatar> </q-item-section>
            <q-item-section>
              <q-list>
                <q-item clickable>
                  <q-item-section avatar>
                    <q-icon color="primary" name="phone" />
                  </q-item-section>
                  <q-item-section>
                    <q-item-label>727-813-1234</q-item-label>
                    <q-item-label caption>mobile</q-item-label>
                  </q-item-section>
                </q-item>

                <q-item clickable>
                  <q-item-section avatar>
                    <q-icon color="red" name="local_gas_station" />
                  </q-item-section>
                  <q-item-section>
                    <q-item-label>Gas Station</q-item-label>
                    <q-item-label caption>Fill your gas tank.</q-item-label>
                  </q-item-section>
                </q-item>

                <q-item clickable>
                  <q-item-section avatar>
                    <q-icon color="amber" name="local_movies" />
                  </q-item-section>
                  <q-item-section>
                    <q-item-label>Cinema XYZ</q-item-label>
                    <q-item-label caption>Watch a movie.</q-item-label>
                  </q-item-section>
                </q-item>
              </q-list>
            </q-item-section>
          </q-item>
          <q-separator />
          <q-card-actions>
            <q-btn flat color="primary" to="/profiles"> Profiles </q-btn>
          </q-card-actions>
        </q-card>
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
        <item-card v-for="item in items" :key="item.id" :item="item"></item-card>
        <q-card v-if="!items.length" flat bordered>
          <q-item>
            <q-item-section avatar>
              <q-skeleton type="QAvatar" />
            </q-item-section>
            <q-item-section>
              <q-item-label>
                <q-skeleton type="text" />
              </q-item-label>
              <q-item-label caption>
                <q-skeleton type="text" width="80%" />
              </q-item-label>
            </q-item-section>
          </q-item>
          <q-item>
            <q-item-section>
              <q-skeleton height="150px" class="q-mb-sm" />
              <div class="row items-center justify-between no-wrap">
                <div class="row items-center">
                  <q-icon
                    name="chat_bubble_outline"
                    color="grey-4"
                    class="q-mr-sm"
                    size="18px"
                  />
                  <q-skeleton type="text" width="30px" />
                </div>
                <div class="row items-center">
                  <q-icon
                    name="repeat"
                    color="grey-4"
                    class="q-mr-sm"
                    size="18px"
                  />
                  <q-skeleton type="text" width="30px" />
                </div>
                <div class="row items-center">
                  <q-icon
                    name="favorite_border"
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
  QSeparator,
  QCardActions,
  QBtn
} from 'quasar';
import ItemCard from '../components/ItemCard.vue';
import { Item } from '../components/models';

export default Vue.extend({
  components: {
    QPage,
    QToolbar,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QBanner,
    QCard,
    QSeparator,
    QCardActions,
    QBtn,
    ItemCard,
  },
  props: ['id'],
  computed: {
    ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['draft', 'errors', 'items', 'loading', 'profile']),
    content: {
      get() {
        return this.$store.state.users.draft.content;
      },
      set(value) {
        this.$store.commit('users/setDraftContent', value);
      },
    },
  },
  // data() {
  //   const items: Item[] = [];
  //   return { items };
  // },
  watch: {
    $route: 'loadData',
  },
  created() {
    this.loadData();
  },
  meta: {
    title: 'Profile - SPA',
  },
  methods: {
    ...mapActions('users', [
      'getCurrentProfile',
      'getItems',
      'getProfile',
      'publishItem',
      'saveItem',
    ]),
    ...mapMutations('users', ['setItems', 'setLoading']),
    async loadData() {
      await this.getCurrentProfile();
      await this.getProfile(this.id);
      // await this.getItems();
      let response = await Item.includes('profile').where({profileId: this.id}).all()
      // this.items = response.data // array of Item instances
      this.setItems(response.data);
    },
    publish() {
      this.publishItem(this.draft).then(() => {
        // this.profile.items.unshift(this.draft);
      });
    },
    save() {
      this.saveItem(this.draft).then(() => {
        // this.profile.items.unshift(this.draft);
      });
    },
  },
});
</script>

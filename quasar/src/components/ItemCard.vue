<template>
  <q-card flat bordered>
    <q-item :to="{ name: 'item', params: { id: item.id } }">
      <q-item-section avatar>
        <q-btn round :to="`/profiles/${item.profile.id}`">
          <q-avatar>
            <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
          </q-avatar>
        </q-btn>
        <!-- <q-skeleton type="QAvatar" /> -->
      </q-item-section>
      <q-item-section>
        <q-item-label>
          <q-btn
            :label="item.profile.name"
            :to="`/profiles/${item.profile.id}`"
            text-color="black"
            color="white"
            flat
            dense
            no-caps
            padding="none"
          />
          <!-- <q-skeleton type="text" /> -->
        </q-item-label>
        <q-item-label >
          {{ item.profile.url }}
          <!-- <q-skeleton type="text" /> -->
        </q-item-label>
        <q-item-label caption>
          {{ item.published || item.updatedAt }}
        </q-item-label>
      </q-item-section>
      <q-item-section side top>
        <q-badge outline color="primary" label="Draft" v-if="!item.published" />
          <!-- :to="`/items/${item.id}/edit`" -->
        <q-btn
          icon="edit"
          label="Edit"
          color="primary"
          size="sm"
          flat
          dense
          :to="{
            name: 'itemEdit',
            params: { id: item.id },
          }"
          type="button"
          v-if="editable"
        />
        <!-- <q-item-label caption>Draft - Edit</q-item-label> -->
        <!-- <q-item-label caption>5 min ago</q-item-label> -->
        <!-- <q-icon name="star" color="yellow" /> -->
      </q-item-section>
    </q-item>
    <!-- <q-item :to="{ name: 'item', params: { id: item.id } }">
      <q-item-section class="ellipsis">
        {{ item.title }}
      </q-item-section>
    </q-item> -->
    <q-item :to="{ name: 'item', params: { id: item.id } }">
      <q-item-section class="">
        <q-item-label overline>{{ item.title }}</q-item-label>
        <q-item-label lines="1">{{ item.contentPlain }}</q-item-label>
        
      </q-item-section>
    </q-item>
    <q-item :to="{ name: 'item', params: { id: item.id } }">
      <q-item-section class="">
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
            <q-icon name="repeat" color="grey-4" class="q-mr-sm" size="18px" />
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

<script lang="ts">
import Vue from 'vue';
import { mapActions, mapGetters, mapMutations, mapState } from 'vuex';
import {
  QAvatar,
  QBadge,
  QBtn,
  QCard,
  QIcon,
  QItem,
  QItemLabel,
  QItemSection,
  QSkeleton
} from 'quasar';
import { Item } from '../components/models';
import { PropType } from '@vue/composition-api';

export default Vue.extend({
  name: 'ItemCard',
  components: {
    QAvatar,
    QBadge,
    QBtn,
    QCard,
    QIcon,
    QItem,
    QItemLabel,
    QItemSection,
    QSkeleton,
  },
  props: {
    item: (Object as unknown) as PropType<Item>,
  },
  computed: {
    // ...mapGetters('users', ['currentUserId']),
    ...mapState('users', ['profiles']),
    // editable():{
    //   // !!
    //   return this.item.editable(this.profiles)
    // },
    editable: {
      get(): boolean {
        return this.item.editable(this.profiles)===true
      },
      // set(value: boolean) {
      //   console.log('set value: ' + value);
      //   if (value) {
      //     this.subscribe(this.feed);
      //   } else {
      //     this.unsubscribe(this.feed);
      //   }
      // },
    },
  },
  watch: {
    // subscribed: function (value, was) {
    //   console.log('watch value: ' + value + ', was: ' + was);
    // },
  },
  methods: {
    // ...mapActions('users', ['subscribe', 'unsubscribe']),
    // ...mapMutations('users', ['setErrors', 'setLoading']),
  },
});
</script>

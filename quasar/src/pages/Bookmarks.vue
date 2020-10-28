<template>
  <q-page class="row">
    <div class="q-pa-md" style="max-width: 350px">
      <q-list bordered separator>
        <q-item-label header>Bookmarks</q-item-label>
        <!-- <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id">
          <q-item-section>Arch Linux</q-item-section>
        </q-item> -->

        <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id" tag="a" :href="bookmark.url">
          <!-- <q-item-section avatar>
            <q-avatar>
              <img src="https://wiki.archlinux.org/favicon.ico">
              <img :src="bookmark.url+'favicon.ico'">
            </q-avatar>
          </q-item-section> -->
          <!-- <q-item-section avatar>
            <q-avatar color="primary" text-color="white">
              A
            </q-avatar>
          </q-item-section> -->
          <q-item-section>
            <q-item-label>{{bookmark.name}}</q-item-label>
            <q-item-label caption>{{bookmark.url}}</q-item-label>
          </q-item-section>
        </q-item>

        <!-- <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id">
          <q-item-section>
            <q-item-label overline>Arch Linux</q-item-label>
            <q-item-label>Item with caption</q-item-label>
          </q-item-section>
        </q-item> -->
      </q-list>
    </div>
  <!-- <div class="q-pa-md bg-grey-10 text-white">
    <q-list dark bordered separator style="max-width: 318px">
      <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id">
        <q-item-section>Single line item</q-item-section>
      </q-item>

      <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id">
        <q-item-section>
          <q-item-label>Item with caption</q-item-label>
          <q-item-label caption>Caption</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-ripple v-for="bookmark in bookmarks" :key="bookmark.id">
        <q-item-section>
          <q-item-label overline>OVERLINE</q-item-label>
          <q-item-label>Item with caption</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </div> -->
    <!-- <ul>
      <li v-for="bookmark in bookmarks" :key="bookmark.id">
        ID: {{ bookmark.id }}<br />Name: {{ bookmark.name }}<br />URL:
        {{ bookmark.url }}
      </li>
    </ul> -->
  </q-page>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
// Vue.prototype.$axios = axios;
import { Bookmark } from 'components/models';
export default Vue.extend({
  name: 'PageBookmarks',
  computed: {
    // bookmarks () {
    //   return this.$store.state.bookmarks.bookmarks
    // }
  },
  data() {
    const bookmarks: Bookmark[] = [
      { id: 1, name: 'name', url: 'http://localhost:3000/bookmarks' }
    ];
    return { bookmarks };
    // return {  };
  },
  meta: {
    title: 'Bookmarks - SPA'
  },
  methods: {
    loadData() {
      // const token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTkxNjEwMTE3LCJleHAiOjE1OTE2Mzg5MTcsImp0aSI6IjE1Nzc1OGQ2LWFmZDEtNGY3Mi1hMmM4LTlmY2Y4Nzc2MTUyOCJ9.iaJWgo8Fhhuz2mHtXvIS_-TX5QyxKMtETtxVGs8R494'
      // this.$axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
      axios
        .get('http://api.spa.test/api/v1/bookmarks.json', {
          withCredentials: true
        })
        .then((response) => {
          this.bookmarks = response.data.data;
        })
        .catch((error) => {
          console.log(error);
          if (error.response.status === 401) {
            console.log('response.status === 401; redirect to /users/sign_in');
            this.$router.replace('/users/sign_in');
          }
          // this.$q.notify({
          //   color: 'negative',
          //   position: 'top',
          //   message: 'Loading failed',
          //   icon: 'report_problem'
          // })
        });
    }
  },
  created: function() {
    this.loadData();
    // Alias the component instance as `vm`, so that we
    // can access it inside the promise function
    // const vm = this

    // Fetch our array of posts from an API
    // this.bookmarks = () => fetch('http://localhost:3000/bookmarks.json')
    //   .then(function(response) {
    //     return response.json()
    //   })
    //   .then(function(data) {
    //     // vm.bookmarks = data
    //     return data
    //   })
  }
});
</script>

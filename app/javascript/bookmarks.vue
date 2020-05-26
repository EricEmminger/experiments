<template>
  <ol>
    <li v-for="bookmark in bookmarks" v-bind:key="bookmark.id" v-bind:bookmark="bookmark">ID: {{bookmark.id}}<br>Name: {{bookmark.name}}<br>URL: {{bookmark.url}}</li>
  </ol>
</template>

<script>
export default {
  data: function () {
    return {
      bookmarks: [{id: 1, name: 'name', url: 'http://localhost:3000/bookmarks'}]
    }
  },
  created: function() {
    // Alias the component instance as `vm`, so that we
    // can access it inside the promise function
    var vm = this
    // Fetch our array of posts from an API
    fetch("/bookmarks.json")
      .then(function(response) {
        return response.json()
      })
      .then(function(data) {
        vm.bookmarks = data
      })
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

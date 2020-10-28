import { RouteConfig } from 'vue-router';

const routes: RouteConfig[] = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', name: 'home', component: () => import('pages/Index.vue') },
      // { path: 'bookmarks', children: [
      //   {path:'',component: () => import('pages/Bookmarks.vue')}
      //   ]
      // }
    ],
  },
  {
    path: '/bookmarks',
    component: () => import('layouts/MainLayout.vue'),
    children: [{ path: '', component: () => import('pages/Bookmarks.vue') }],
  },
  {
    path: '/drafts',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'drafts',
        component: () => import('pages/Items.vue'),
        props: { scope: 'drafts' },
      },
      {
        path: ':id',
        name: 'draft',
        component: () => import('pages/Item.vue'),
        props: true,
      },
      {
        path: ':id/edit',
        name: 'draftEdit',
        component: () => import('pages/ItemEdit.vue'),
        props: true,
      },
    ],
  },
  {
    path: '/feeds',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'feeds',
        component: () => import('pages/Feeds.vue'),
      },
      {
        path: 'new',
        name: 'feedNew',
        component: () => import('pages/FeedEdit.vue'),
        // props: true,
      },
      {
        path: ':id',
        name: 'feed',
        component: () => import('pages/Feed.vue'),
      },
      {
        path: ':id/edit',
        name: 'feedEdit',
        component: () => import('pages/FeedEdit.vue'),
        props: true,
      },
      {
        path: ':id/items',
        name: 'feed_items',
        component: () => import('pages/Items.vue'),
        props: { scope: 'feed_items' },
      },
    ],
  },
  // {
  //   path: '/feed-items',
  //   component: () => import('layouts/MainLayout.vue'),
  //   children: [{ path: '', component: () => import('pages/FeedItems.vue') }]
  // },
  {
    path: '/items',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'items',
        component: () => import('pages/Items.vue'),
        props: { scope: 'items' },
      },
      {
        path: ':id',
        name: 'item',
        component: () => import('pages/Item.vue'),
        props: true,
      },
      {
        path: ':id/edit',
        name: 'itemEdit',
        component: () => import('pages/ItemEdit.vue'),
        props: true,
      },
    ],
  },
  {
    path: '/profiles',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'profiles',
        component: () => import('pages/Profiles.vue'),
      },
      {
        path: ':id',
        name: 'profile',
        component: () => import('pages/Profile.vue'),
        props: true,
      },
    ],
  },
  {
    path: '/users',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        name: 'users',
        component: () => import('pages/Users.vue'),
      },
      {
        path: 'sign_in',
        name: 'sign_in',
        component: () => import('pages/SignIn.vue'),
      },
      {
        path: ':id',
        name: 'user',
        component: () => import('pages/User.vue'),
        props: true,
      },
    ],
  },
];

// Always leave this as last one
routes.push({
  path: '*',
  component: () => import('pages/Error404.vue'),
});

export default routes;

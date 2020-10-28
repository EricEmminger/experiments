export interface Bookmark {
  id: number;
  name: string;
  url: string;
}

export interface Error {
  id: number;
  message: string;
}

// export interface Feed {
//   id: string;
//   subscriptions: Subscription[];
// }

// export interface Item {
//   content: string;
//   id?: string;
// }

export interface Meta {
  totalCount: number;
}

// export interface Profile {
//   id: string;
// }

// export interface Subscription {
//   id: string;
// }

export interface Todo {
  id: number;
  content: string;
}

export interface User {
  email: string;
  // errors: Error[];
  id?: number;
  password?: string;
  remember_me?: boolean;
}

import {
  Model,
  SpraypaintBase,
  Attr,
  BelongsTo,
  HasMany,
  // HasOne
  // etc
} from 'spraypaint';

@Model()
export class ApplicationRecord extends SpraypaintBase {
  static baseUrl = 'http://api.spa.test';
  static apiNamespace = '/api/v1';
  static clientApplication = 'spa';
}

import { MiddlewareStack } from 'spraypaint';

const middleware = new MiddlewareStack();
middleware.beforeFilters.push((url, options) => {
  // options.headers["CUSTOM-HEADER"] = "whatever"
  options.credentials = 'include';
});
// middleware.afterFilters.push((response, json) => {
//   if (response.status === 401) {
//     window.location.href = "/login"
//     throw("abort")
//   }
// })

ApplicationRecord.middlewareStack = middleware;

@Model()
export class Feed extends ApplicationRecord {
  static jsonapiType = 'feeds';
  @Attr() authors: string;
  @Attr() format: string;
  @Attr() generator: string;
  @Attr() published: string;
  @Attr() summary: string;
  @Attr() tags: string;
  @Attr() title: string;
  @Attr() updated: string;
  @Attr() url: string;
  @Attr({ persist: false }) createdAt: string;
  @Attr({ persist: false }) updatedAt: string;
  @BelongsTo() profile: Profile;
  @HasMany() subscriptions: Subscription[];
}

@Model()
export class Item extends ApplicationRecord {
  static jsonapiType = 'items';

  @Attr() attachments: string;
  @Attr() authors: string;
  @Attr() content: string;
  @Attr() contentHtml: string;
  @Attr() contentPlain: string;
  @Attr() contentSafe: string;
  @Attr() contentText: string;
  @Attr() externalUrl: string;
  @Attr() guid: string;
  @Attr() published: string;
  @Attr() summary: string;
  @Attr() tags: string;
  @Attr() title: string;
  @Attr() updated: string;
  @Attr({ persist: false }) createdAt: string;
  @Attr({ persist: false }) updatedAt: string;
  @BelongsTo() profile: Profile;
  @HasMany() reactions: Reaction[];

  editable(profiles: Profile[]){
    //  return false
    // item.guid.startsWith('http://spa.test/') && profiles.some((profile)=>profile.id===item.profile.id)
    return this.guid.startsWith('http://spa.test/') && profiles.some((profile)=>profile.id===this.profile.id)
  }
  // @Attr() profile_id: number
  // @Attr() profiles: Profile[]
  // @BelongsTo() person: Person[]
  // @BelongsTo('people') owner: Person[]
  // @BelongsTo(Person) owner: Person[]
  // @BelongsTo() profile: Profile
  // @HasOne() profiles: Profile[]

  // def content
  //   content_html || content_text || summary
  // get content() : string {
  //   return this.contentHtml || this.contentText || this.summary
  // }
}

@Model()
export class Profile extends ApplicationRecord {
  static jsonapiType = 'profiles';

  @Attr({ persist: false }) createdAt: string;
  @Attr() name: string;
  @Attr() private: boolean;
  @Attr({ persist: false }) updatedAt: string;
  @Attr() url: string;
  @Attr() user_id: number;

  // @HasMany() dogs: Dog[]
  @HasMany() feeds: Feed[];
  @HasMany() items: Item[];
  @HasMany() reactions: Reaction[];
  @HasMany() subscriptions: Subscription[];
}

@Model()
export class Reaction extends ApplicationRecord {
  static jsonapiType = 'reactions';

  @Attr({ persist: false }) createdAt: string;
  // @Attr() kind: string
  @Attr({ persist: false }) updatedAt: string;

  @BelongsTo() item: Item;
  @BelongsTo() profile: Profile;
}

@Model()
export class Subscription extends ApplicationRecord {
  static jsonapiType = 'subscriptions';

  @Attr({ persist: false }) createdAt: string;
  @Attr() mute: boolean
  @Attr() notify: boolean
  @Attr({ persist: false }) updatedAt: string;

  @BelongsTo() feed: Feed;
  @BelongsTo() profile: Profile;
}

# Install/bundle gems from Gemfile
bundle
# Seed initial data
rails db:seed
# Start rails server
rails server
# Start quasar development server
quasar dev
# Start rails console in a sandbox
rails console --sandbox
# Run resque workers to work the job QUEUE via rake task
QUEUE=* rake resque:work
# Generate job
rails generate job Oops
# Destroy job
rails destroy job Oops

# Generate model/scaffold/migration
rails generate scaffold Feed url:string:index format:string title:string summary:string generator:string updated:datetime published:datetime authors:text tags:text
rails generate scaffold Item guid:string:index external_url:string title:string summary:string updated:datetime published:datetime content_html:text content_text:text authors:text tags:text attachments:text
rails generate model Profile user:references url:string:index name:string private:boolean
rails generate model Reaction profile:references item:references kind:string
rails generate model Subscription profile:references feed:references notify:boolean mute:boolean
rails generate model Syndication feed:references item:references shared:boolean
rails generate migration AddProfileRefToFeeds profile:references
rails generate migration AddProfileRefToItems profile:references

# Add index to migration
# add_index :feeds, :url, unique: true
# add_index :items, :guid, unique: true
# add_index :profiles, :url, unique: true
# add_index :subscriptions, [:profile_id, :feed_id], unique: true
# add_index :syndications, [:feed_id, :item_id], unique: true

# Migrate migration
rails db:migrate
# Rollback migration
rails db:rollback

# Generate graphiti:resource for model
rails generate graphiti:resource Feed url:string format:string title:string summary:string generator:string updated:datetime published:datetime authors:string tags:string
rails generate graphiti:resource Item guid:string external_url:string title:string summary:string updated:datetime published:datetime content_html:string content_text:string authors:string tags:string attachments:string
rails generate graphiti:resource Profile url:string name:string private:boolean
rails generate graphiti:resource Reaction profile_id:integer item_id:integer kind:string
rails generate graphiti:resource Subscription notify:boolean mute:boolean
rails generate graphiti:resource Syndication feed_id:integer item_id:integer shared:boolean
rails generate graphiti:resource User email:string current_sign_in_at:datetime last_sign_in_at:datetime current_sign_in_ip:string last_sign_in_ip:string created_at:datetime updated_at:datetime

# Generate store module (format TypeScript)
quasar new store -f ts users
# Generate boot file (format TypeScript)
quasar new boot -f ts router

# Install redis
sudo pacman -S redis
# Enable redis service
sudo systemctl enable redis.service
# Start redis service
sudo systemctl start redis.service

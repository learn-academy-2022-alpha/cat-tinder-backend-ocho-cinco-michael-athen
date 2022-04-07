### README

        Terminal Command and Actions Running List
        $ rails new cat-tinder-backend -d postgresql -T
        $ cd cat-tinder-backend
        $ rails db:create
        $ bundle add rspec-rails
        $ rails generate rspec:install
        $ rails server
        $ rails generate resource Cat name:string age:integer enjoys:text image:text
        $ rails db:migrate
        Add Cats to Seed File
        $ rails db:seed
        Updated application controller to to allow requests from applications outside the Rails application
        Added gem 'rack-cors', :require => 'rack/cors' to Gemfile
        Added new file cors.rb to the initializers folder
        $ bundle


## Challenge: Cat Tinder API Setup
# As a developer, I can create a new Rails application with a Postgresql database.
        
        $ rails new cat-tinder-backend -d postgresql -T
        $ cd cat-tinder-backend
        $ rails db:create

# As a developer, I can create a RSpec testing suite in my Rails application.
        
        $ bundle add rspec-rails
        $ rails generate rspec:install

# As a developer, I can add a resource for Cat that has a name, an age, what the cat enjoys doing, and an image.
        
        $ rails generate resource Cat name:string age:integer enjoys:text image:text
        $ rails db:migrate

## Challenge: Cat Tinder API Seeds
# As a developer, I can add cat seeds to the seeds.rb file.
```ruby
                cats = [
                {
                name: 'Felix',
                age: 2,
                enjoys: 'Long naps on the couch, and a warm fire.',
                image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
                },
                {
                name: 'Homer',
                age: 12,
                enjoys: 'Food mostly, really just food.',
                image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
                },
                {
                name: 'Jack',
                age: 5,
                enjoys: 'Furrrrociously hunting bugs.',
                image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
                }
                ]

                cats.each do |each_cat|
                Cat.create each_cat
                puts "creating cat #{each_cat}"
                end
```

# As a developer, I can run the rails command to add cats to database.
              
        $ rails db:seed

## Challenge: Cat Tinder API CORS
# As a developer, I can enable my controller to accept requests from outside applications.
```ruby
                class ApplicationController < ActionController::Base
                        skip_before_action :verify_authenticity_token
                end
```
# As a developer, I can add the CORS gem to my Rails application.
```ruby
        gem 'rack-cors', :require => 'rack/cors'
```
# As a developer, I can add the cors.rb file to my application.
        
        $ cd initializers
        $ touch cor.rb
        $ bundle
```ruby
                # Avoid CORS issues when API is called from the frontend app.
                # Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

                # Read more: https://github.com/cyu/rack-cors

                Rails.application.config.middleware.insert_before 0, Rack::Cors do
                allow do
                origins '*'  # <- change this to allow requests from any domain while in development.

                resource '*',
                headers: :any,
                methods: [:get, :post, :put, :patch, :delete, :options, :head]
                end
                end
```
# README

        Terminal Command and Actions Running List
        $ rails new cat-tinder-backend -d postgresql -T
        $ cd cat-tinder-backend
        $ rails db:create
        $ bundle add rspec-rails
        $ rails generate rspec:install
        $ rails server
        $ rails generate resource Cat name:string age:integer enjoys:text image:text
        $ rails db:migrate
        $ rspec spec
        Add Cats to Seed File
        $ rails db:seed
        Updated application controller to to allow requests from applications outside the Rails application
        Added gem 'rack-cors', :require => 'rack/cors' to Gemfile
        Added new file cors.rb to the initializers folder
        $ bundle


## Challenge: Cat Tinder API Setup
### As a developer, I can create a new Rails application with a Postgresql database.

        $ rails new cat-tinder-backend -d postgresql -T
        $ cd cat-tinder-backend
        $ rails db:create

### As a developer, I can create a RSpec testing suite in my Rails application.

        $ bundle add rspec-rails
        $ rails generate rspec:install

### As a developer, I can add a resource for Cat that has a name, an age, what the cat enjoys doing, and an image.

        $ rails generate resource Cat name:string age:integer enjoys:text image:text
        $ rails db:migrate

## Challenge: Cat Tinder API Seeds
### As a developer, I can add cat seeds to the seeds.rb file.
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

### As a developer, I can run the rails command to add cats to database.

        $ rails db:seed

## Challenge: Cat Tinder API CORS
### As a developer, I can enable my controller to accept requests from outside applications.
```ruby
        class ApplicationController < ActionController::Base
         skip_before_action :verify_authenticity_token
        end
```
### As a developer, I can add the CORS gem to my Rails application.
```ruby
        gem 'rack-cors', :require => 'rack/cors'
```
### As a developer, I can add the cors.rb file to my application.

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

### Challenge: Cat Tinder API Endpoints

### As a developer, I can add an index request spec to my application.
``` ruby
        describe "GET /index" do
          it "gets a list of cats" do
            Cat.create(
              name: 'Garfield',
              age: 9,
              enjoys: 'Eating lasagna',
              image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
            )

            get '/cats'
            cat = JSON.parse(response.body)
            expect(response).to have_http_status(200)
            expect(cat.length).to eq 1
            end
        end
```

### As a developer, I can add an index endpoint to my application.
```ruby
        def index
          cats = Cat.all
          render json: cats
        end
```

### As a developer, I can add a create request spec to my application.
```ruby
        describe "POST /create" do
          it "creates a cat" do
            cat_params = {
              cat: {
                name: 'Neo',
                age: 9,
                enjoys: 'Attention from humans.',
                image: 'https://cdn.pixabay.com/photo/2019/06/09/12/56/cat-4262034_1280.jpg'
              }
            }

            post '/cats', params: cat_params
            expect(response).to have_http_status(200)

            cat = Cat.first
            expect(cat.name).to eq 'Neo'
            expect(cat.age).to eq 9
            expect(cat.enjoys).to eq 'Attention from humans.'
            expect(cat.image).to eq 'https://cdn.pixabay.com/photo/2019/06/09/12/56/cat-4262034_1280.jpg'
          end
        end
```
### As a developer, I can add a create endpoint to my application.
```ruby
        def create
          cat = Cat.create(strong_cat_params)
          if cat.valid?
            render json: cat
          else
            render json: cat.errors
          end
        end
```
### Stretch Goals
### As a developer, I can add an update request spec to my application.
```ruby
      describe "UPDATE /patch" do
        it "updates a cat" do
          Cat.create(
            name: 'Garfield',
            age: 9,
            enjoys: 'Eating lasagna',
            image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
          )
          cat_garfield = Cat.first

          cat_params = {
            cat: {
              name:'Garfield',
              age: 10,
              enjoys: 'Eating lasagna',
              image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
            }
          }
          patch "/cats/#{cat_garfield.id}", params: cat_params
          cat_mystery = Cat.find(cat_garfield.id)
          expect(response).to have_http_status(200)
          expect(cat_mystery.age).to eq 10
        end
      end
```
### As a developer, I can add an update endpoint to my application.
```ruby
      def update
        cat = Cat.find(params[:id])
        cat.update(strong_cat_params)
        if cat.valid?
          render json: cat
        else
          render json: cat.errors
        end
      end
```
### As a developer, I can add a destroy request spec to my application.
```ruby
      describe "DELETE /destroy" do
        it "deletes a cat" do
          Cat.create(
            name: 'Garfield',
            age: 9,
            enjoys: 'Eating lasagna',
            image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
          )
          cat_garfield = Cat.first
          delete "/cats/#{cat_garfield.id}"
          expect(response).to have_http_status(200)
          cats = Cat.all
          expect(cats).to be_empty
        end
      end
```
### As a developer, I can add a destroy endpoint to my application.
```ruby
      def destroy
        cat = Cat.find(params[:id])
        if cat.destroy
          render json: cat
        else
          render json: cat.errors
        end
      end

      private
      def strong_cat_params
        params.require(:cat).permit(:name, :age, :enjoys, :image)
      end
    end
```
### Challenge: Cat Tinder API Validations
### As a developer, I can add the appropriate model specs that will ensure an incomplete cat throws an error.
```ruby
    it "should validate name" do
      cat = Cat.create age:4, enjoys:"Sleeping", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
      p cat.errors[:name]
      expect(cat.errors[:name]).to_not be_empty
    end
    it "should validate age" do
      cat = Cat.create name:"Mike", enjoys:"Sleeping", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
      p cat.errors[:age]
      expect(cat.errors[:age]).to_not be_empty
    end
    it "should validate enjoys" do
      cat = Cat.create name:"Mike", age:4, image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
      p cat.errors[:enjoys]
      expect(cat.errors[:enjoys]).to_not be_empty
    end
    it "should validate image" do
      cat = Cat.create name:"Mike", age:4, enjoys:"Sleeping"
      p cat.errors[:image]
      expect(cat.errors[:image]).to_not be_empty
    end
```

### As a developer, I can add the appropriate model validations to ensure the user submits a name, an age, what the cat enjoys, and an image.
```ruby
    validates :name, :age, :enjoys, :image, presence: true
```

### As a developer, I can add the appropriate model specs that will ensure a cat enjoys entry is at least 10 characters long.
```ruby
    it "enjoys should be at least 10 characters long" do
      cat = Cat.create name:"Mike", age:4, enjoys:"Sleeping", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
      p cat.errors[:enjoys]
      expect(cat.errors[:enjoys]).to_not be_empty
end
```

### As a developer, I can add a validation to assure that will ensure a cat enjoys entry is at least 10 characters long.
```ruby
    validates :enjoys, length: { minimum: 10 }
```
### As a developer, I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if a new cat is not valid.
```ruby
    describe "cat should have valid attributes" do
      it "doesn't create a cat without a name" do
        cat_params = {
          cat: {
            age:4,
            enjoys:"Sleeping",
            image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
          }
        }
        post '/cats', params: cat_params
        cat = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(cat['name']).to include "can't be blank"
      end
      it "doesn't create a cat without a age" do
        cat_params = {
          cat: {
            name:"Mike",
            enjoys:"Sleeping",
            image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
          }
        }
        post '/cats', params: cat_params
        cat = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(cat['age']).to include "can't be blank"
      end
      it "doesn't create a cat without a enjoys" do
        cat_params = {
          cat: {
            name:"Mike",
            age:4,
            image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
          }
        }
        post '/cats', params: cat_params
        cat = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(cat['enjoys']).to include "can't be blank"
      end
      it "doesn't create a cat without a image" do
        cat_params = {
          cat: {
            name:"Mike",
            age:4,
            enjoys:"Sleeping"
          }
        }
        post '/cats', params: cat_params
        cat = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(cat['image']).to include "can't be blank"
      end
    end
```

### As a developer, I can add the appropriate request spec that will look for a 422 error if the create validations are not met.
```ruby
    def create
      cat = Cat.create(strong_cat_params)
      if cat.valid?
        render json: cat
      else
        render json: cat.errors, status:422
      end
    end
```

### STRETCH: As a developer, I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if an updated cat is not valid.
```ruby
    it "does not update a cat with no name" do
      Cat.create(
        name: 'Garfield',
        age: 9,
        enjoys: 'Eating lasagna',
        image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
      )
      cat_garfield = Cat.first

      cat_params = {
        cat: {
          name:"",
          age: 9,
          enjoys: 'Eating lasagna',
          image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
        }
      }
      patch "/cats/#{cat_garfield.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['name']).to include "can't be blank"
    end
    it "does not update a cat with no age" do
      Cat.create(
        name: 'Garfield',
        age: 9,
        enjoys: 'Eating lasagna',
        image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
      )
      cat_garfield = Cat.first

      cat_params = {
        cat: {
          name:"Garfield",
          age: "",
          enjoys: 'Eating lasagna',
          image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
        }
      }
      patch "/cats/#{cat_garfield.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['age']).to include "can't be blank"
    end
    it "does not update a cat with no enjoys" do
      Cat.create(
        name: 'Garfield',
        age: 9,
        enjoys: 'Eating lasagna',
        image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
      )
      cat_garfield = Cat.first

      cat_params = {
        cat: {
          name:"Garfield",
          age: 9,
          enjoys: "",
          image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
        }
      }
      patch "/cats/#{cat_garfield.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['enjoys']).to include "can't be blank"
    end
    it "does not update a cat with enjoys being less than 10 characters" do
      Cat.create(
        name: 'Garfield',
        age: 9,
        enjoys: 'Eating lasagna',
        image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
      )
      cat_garfield = Cat.first

      cat_params = {
        cat: {
          name:"Garfield",
          age: 9,
          enjoys: "Sleep",
          image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
        }
      }
      patch "/cats/#{cat_garfield.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['enjoys']).to include "is too short (minimum is 10 characters)"
    end
    it "does not update a cat with no image" do
      Cat.create(
        name: 'Garfield',
        age: 9,
        enjoys: 'Eating lasagna',
        image: 'https://live.staticflickr.com/7174/6599346995_4d7efdf923_c.jpg'
      )
      cat_garfield = Cat.first

      cat_params = {
        cat: {
          name:"Garfield",
          age: 9,
          enjoys: "",
          image: ""
        }
      }
      patch "/cats/#{cat_garfield.id}", params: cat_params
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['image']).to include "can't be blank"
    end
```
### STRETCH: As a developer, I can add the appropriate request spec that will look for a 422 error if the update validations are not met.

```ruby
    def update
      cat = Cat.find(params[:id])
      cat.update(strong_cat_params)
      if cat.valid?
        render json: cat
      else
        render json: cat.errors, status:422
      end
    end
```

require 'rails_helper'

RSpec.describe "Cats", type: :request do
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
    it "doesn't create a cat if the enjoys input is less than 10 characters" do
    cat_params = {
      cat: {
        name:"Mike",
        age:4,
        enjoys:"Sleeping",
        image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
      }
    }
    post '/cats', params: cat_params
    cat = JSON.parse(response.body)
    expect(response).to have_http_status(422)
    expect(cat['enjoys']).to include "is too short (minimum is 10 characters)"
  end
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
end
end

require 'rails_helper'

RSpec.describe Cat, type: :model do
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
  it "enjoys should be at least 10 characters long" do
    cat = Cat.create name:"Mike", age:4, enjoys:"Sleeping", image:"https://upload.wikimedia.org/wikipedia/commons/3/38/Adorable-animal-cat-20787.jpg"
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end

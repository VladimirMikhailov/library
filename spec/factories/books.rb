FactoryGirl.define do
  factory :book, class: "Library::Book" do
    name { FFaker::Name.name }
  end
end

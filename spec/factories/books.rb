FactoryGirl.define do
  factory :book, class: "Library::Book" do
    name { FFaker::Name.name }
    published_at { rand(Library::Book::PUBLISHMENTS) }
  end
end

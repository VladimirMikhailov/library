FactoryGirl.define do
  factory :top_author_publishments, class: "Hash" do
    name { FFaker::Name.name }
    publishments { { "1940" => 3 } }

    initialize_with { attributes.stringify_keys }
  end
end

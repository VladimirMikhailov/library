FactoryGirl.define do
  factory :author, class: "Library::Author" do
    transient { book nil }

    name { FFaker::Name.name }

    after(:create) do |author, evaluator|
      if evaluator.book
        FactoryGirl.create(
          :books_author,
          author_id: author.id,
          book_id: evaluator.book.id
        )
      end
    end
  end
end

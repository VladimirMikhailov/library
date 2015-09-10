FactoryGirl.define do
  factory :author, class: "Library::Author" do
    transient { books [] }

    name { FFaker::Name.name }

    after(:create) do |author, evaluator|
      evaluator.books.each do |book|
        FactoryGirl.create(
          :books_author,
          author_id: author.id,
          book_id: book.id
        )
      end
    end
  end
end

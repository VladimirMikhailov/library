FactoryGirl.define do
  factory :books_author, class: "Library::BooksAuthor" do
    author
    book
  end
end

describe "Book creating", feature: true do
  let(:book_name) { "New book" }

  before do
    Capybara.app = Library::BooksController
  end

  specify "creating book from index path" do
    visit "/books"

    expect(page).not_to have_content(book_name)

    find(:create_new_book).click
    submit_form

    expect(page).to have_content(book_name)
  end

  specify "create book with invalid data" do
    visit "/books/new"
    submit_form(name: "")

    expect(page).to have_label_text(:name, "can't be blank")
  end

  def submit_form(name: book_name)
    fill_in :name, with: name
    click_on "Add"
  end
end

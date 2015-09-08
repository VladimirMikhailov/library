describe "Book creating", feature: true do
  let(:book_name) { "New book" }

  before do
    Capybara.app = Library::BooksController
  end

  specify "create book" do
    visit "/books"

    expect(page).not_to have_content(book_name)

    find(:create_new_book).click
    submit_form

    expect(page).to have_content(book_name)
  end

  def submit_form
    fill_in :name, with: book_name
    click_on "Add"
  end
end

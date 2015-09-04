describe "Visit to the books list page", feature: true do
  before do
    Capybara.app = Library::BooksController
  end

  specify "the books list content" do
    create(:book, name: "My book")
    visit "/books"

    expect(page).to have_content("My book")
  end

  specify "the books list page when no books available" do
    visit "/books"

    expect(page).to have_content("No books available")
  end

  specify "the books list content paginated by 2" do
    stub_const("Library::BooksController::PER_PAGE", 2)
    3.times { |i| create(:book, name: "My #{i} book") }

    visit "/books"

    expect(page).not_to have_content("My 2 book")
  end
end

describe "Pagination on the books page", feature: true do
  before do
    Capybara.app = Library::BooksController
    stub_const("Library::PaginatableQuery::PER_PAGE", 2)
    3.times { |i| create(:book, id: i + 1, name: "My book #{i}") }

    visit "/books"
  end

  specify "sees only first page content", :js do
    expect(page).to have_content("My book 0")
    expect(page).not_to have_content("My book 3")
  end
end

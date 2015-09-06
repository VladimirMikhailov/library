describe "Pagination on the books page", feature: true do
  before do
    Capybara.app = Library::BooksController
    stub_const("Library::BooksController::PER_PAGE", 2)

    3.times { |i| create(:book, id: i + 1, name: "My book #{i}") }
  end

  specify "visit first page" do
    visit "/books"

    expect(page).to have_first_page_controls
    expect(page).not_to have_content("My book 2")
  end

  specify "visit second page" do
    visit "/books"

    click_on("Next")

    expect(page).to have_content("My book 2")
  end

  specify "visit first page from last" do
    visit "/books?last_seen_id=2"
    expect(page).to have_last_page_controls

    click_on("Previous")

    expect(page).to have_content("My book 0")
  end
end

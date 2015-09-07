describe "Book deleting", feature: true do
  before do
    Capybara.app = Library::BooksController
    stub_const("Library::BooksController::PER_PAGE", 2)
  end

  let!(:book) { create(:book) }

  specify "delete by clicking on control button" do
    visit "/books"

    find(:delete_book_icon, book.name).click

    expect(page).not_to have_content(book.name)
  end

  specify "delete and stay on the same page" do
    deleted, _, visible_after_delete = create_list(:book, 3)

    visit "/books?last_seen_id=#{book.id}"
    expect(page).not_to have_content(visible_after_delete.name)

    find(:delete_book_icon, deleted.name).click

    expect(page).to have_content(visible_after_delete.name)
  end
end

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

  specify "update graphs stats" do
    book = create(:book, name: "Hey", published_at: "1950")
    create(:books_first_letter, id: "H", count: 1)
    create(:books_publishment_year, id: "1950", count: 20)
    book_attributes = { name: "Hey", published_at: "1950" }

    visit "/books"

    expect { find(:delete_book_icon, book.name).click }.to change_graphs_stats(**book_attributes).by(-1)
  end

  specify "delete and stay on the same page" do
    deleted, _, visible_after_delete = create_list(:book, 3)

    visit "/books?last_seen_id=#{book.id}"
    expect(page).not_to have_content(visible_after_delete.name)

    find(:delete_book_icon, deleted.name).click
    expect(page).to have_content(visible_after_delete.name)
  end
end

describe "Book creating", feature: true do
  let(:book_name) { "New book" }

  specify "create book with invalid data" do
    visit "/books/new"
    submit_form(name: "")

    expect(page).to have_label_text(:name, "can't be blank")
  end

  specify "update graphs stats" do
    create(:books_first_letter, id: "N", count: 12)
    create(:books_publishment_year, id: "2014", count: 200)

    visit "/books/new"

    book_attributes = { name: "New book", published_at: "2014" }

    expect { submit_form(**book_attributes) }.to change_graphs_stats(**book_attributes).by(1)
  end

  def submit_form(name: book_name, published_at: "1940")
    fill_in :name, with: name
    fill_in :published_at, with: published_at
    click_on "Add"
  end
end

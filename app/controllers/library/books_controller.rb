module Library
  class BooksController < ApplicationController
    include BooksHelpers

    register Sinatra::MultiRoute

    PER_PAGE = 20

    get "/", "/books" do
      slim(
        :"books/index",
        last_seen_id: last_seen_id,
        direction: direction,
        books: books
      )
    end

    delete "/books/:id" do |id|
      book = Book.find(id)
      book.destroy

      redirect(books_path(last_seen_id: last_seen_id, direction: direction))
    end

    private

    def books
      PaginatableQuery.new(
        Book.all,
        per_page: PER_PAGE,
        last_seen_id: last_seen_id,
        direction: direction
      )
    end

    def last_seen_id
      params[:last_seen_id]
    end

    def direction
      params[:direction].to_s
    end
  end
end

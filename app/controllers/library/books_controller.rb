module Library
  class BooksController < ApplicationController
    include Assetpackable
    include BooksHelpers

    register Sinatra::MultiRoute

    PER_PAGE = 30

    get "/", "/books" do
      slim(
        index_template,
        layout: !request.xhr?,
        locals: {
          last_seen_id: last_seen_id,
          direction: direction,
          books: books
        }
      )
    end

    get "/books/new" do
      slim(:"books/new", locals: { book: BookFormPresenter.new(Book.new) })
    end

    post "/books" do
      book = Book.new(book_params)

      if book.save
        UpdateGraphsStatsJob.enqueue(book.id, "increment")
        redirect books_path
      else
        slim(:"books/new", locals: { book: BookFormPresenter.new(book) })
      end
    end

    delete "/books/:id" do |id|
      book = Book.find(id)

      Book.transaction do
        DeleteBookJob.enqueue(book.id)
        book.update_attributes!(deleted_at: Time.now.utc)
      end

      redirect(books_path(last_seen_id: last_seen_id, direction: direction))
    end

    private

    def index_template
      request.xhr? ? :"books/collection" : :"books/index"
    end

    def book_params
      (params["book"] || {}).slice("name", "published_at", "author_ids")
    end

    def books
      @books ||= PaginatableQuery.new(
        Book.active,
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

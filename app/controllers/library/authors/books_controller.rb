module Library
  module Authors
    class BooksController < ApplicationController
      include Assetpackable
      include BooksHelpers

      register Sinatra::MultiRoute

      get "/books/new" do
        slim(:"books/new", locals: { book: BookPresenter.new(Book.new) })
      end

      post "/books" do
        book = Book.new(book_params)

        if book.save
          UpdateGraphsStatsJob.enqueue(book.id, "increment")
          redirect books_path
        else
          slim(:"books/new", locals: { book: BookPresenter.new(book) })
        end
      end

      delete "/books/:id" do |id|
        book = Book.find(id)

        Book.transaction do
          DeleteBookJob.enqueue(book.id)
          book.update_attributes!(deleted_at: Time.now.utc)
        end

        redirect(books_path)
      end

      private

      def book_params
        (params["book"] || {}).slice("name", "published_at", "author_ids")
      end
    end
  end
end

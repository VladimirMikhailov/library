module Library
  class BooksController < ApplicationController
    register Sinatra::MultiRoute

    PER_PAGE = 30

    set :views, proc { File.join(root, "../../views/books") }

    get "/", "/books" do
      slim(:index, books: books)
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

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
      Book.order(:id).limit(PER_PAGE)
    end
  end
end

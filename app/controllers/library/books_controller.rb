module Library
  class BooksController < ApplicationController
    include Assetpackable
    include BooksHelpers

    register Sinatra::MultiRoute

    get "/", "/books" do
      books ||= PaginatableQuery.new(Book.active, params)

      slim(
        index_template,
        layout: !request.xhr?,
        locals: { books: books }
      )
    end

    private

    def index_template
      request.xhr? ? :"books/collection" : :"books/index"
    end
  end
end

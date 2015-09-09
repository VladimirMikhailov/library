module Library
  class BooksAuthor < ActiveRecord::Base
    belongs_to :author
    belongs_to :book
  end
end

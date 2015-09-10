module Library
  class Author < ActiveRecord::Base
    has_many :books_authors
    has_many :books, through: :books_authors
  end
end

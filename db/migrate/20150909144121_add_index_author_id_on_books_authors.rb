class AddIndexAuthorIdOnBooksAuthors < ActiveRecord::Migration
  def change
    add_index :books_authors, :author_id
    add_index :books_authors, :book_id
  end
end

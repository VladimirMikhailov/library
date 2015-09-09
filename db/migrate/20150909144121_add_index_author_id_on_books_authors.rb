class AddIndexAuthorIdOnBooksAuthors < ActiveRecord::Migration
  def change
    add_index :books_authors, :author_id
  end
end

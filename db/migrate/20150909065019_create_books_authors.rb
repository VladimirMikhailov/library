class CreateBooksAuthors < ActiveRecord::Migration
  def change
    create_table :books_authors, id: false do |table|
      table.references :author
      table.references :book
    end
  end
end

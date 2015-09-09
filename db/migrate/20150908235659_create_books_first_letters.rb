class CreateBooksFirstLetters < ActiveRecord::Migration
  def change
    create_table :books_first_letters, id: false do |table|
      table.string :id, null: false
      table.integer :count, null: false, default: 0
    end

    add_index :books_first_letters, :id, unique: true
  end
end

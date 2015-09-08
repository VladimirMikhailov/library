class CreateBooksPublishmentYears < ActiveRecord::Migration
  def change
    create_table :books_publishment_years do |table|
      table.integer :count, null: false, default: 0
    end
  end
end

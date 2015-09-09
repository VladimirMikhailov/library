class AddPublishmentsCountColumnToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :publishments_count, :integer, null: false, default: 0
    add_index :authors, :publishments_count
  end
end

class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name, default: "", null: false
      t.integer :published_at, null: false, default: 1940
    end
  end
end

desc "Generate relationships between books and authors"
task :generate_books_authors do
  progressbar = ProgressBar.create(title: "Generate Books Authors", total: 40)
  bulk_save = Library::BulkSave.new(table: :books_authors, columns: %i(book_id author_id))
  buffer = Library::ContentBuffer.new(bulk_save: bulk_save)

  drop_indexes

  40.times do |i|
    book_id = (i * 1_000_000)

    buffer.save(times: 1_000_000) do
      book_authors(book_id += 1)
    end

    progressbar.increment
  end

  create_indexes
end

def drop_indexes
  migration.remove_index :books_authors, :author_id
  migration.remove_index :books_authors, :book_id
end

def create_indexes
  migration.add_index :books_authors, :author_id
  migration.add_index :books_authors, :book_id
end

def migration
  ActiveRecord::Migration.new
end

def book_authors(book_id)
  result = ""

  rand(1..3).times do
    result << "#{book_id},#{author_id}\n"
  end

  result.slice(0..-2)
end

def author_id
  rand(1..5_000_000)
end

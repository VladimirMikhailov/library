desc "Refresh the number of books published by author"
task :refresh_authors_publishments_counts do
  Library::BooksAuthor.transaction do
    create_tmp_table_and_lock
    insert_into_new_table
    add_primary_key_and_indexes
    replace_tables
  end

  Library::TopAuthorsPublishmentsGraph.update!
end

def replace_tables
  Library::BooksAuthor.connection.execute(<<-SQL)
    DROP TABLE #{Library::Author.table_name};
    ALTER TABLE authors_new RENAME TO #{Library::Author.table_name};
  SQL
end

def add_primary_key_and_indexes
  Library::BooksAuthor.connection.execute(
    "ALTER TABLE authors_new  ADD PRIMARY KEY (id);"
  )

  ActiveRecord::Migration.new.add_index(:authors_new, :publishments_count)
end

def create_tmp_table_and_lock
  Library::BooksAuthor.connection.execute(<<-SQL)
    CREATE TABLE authors_new AS SELECT * FROM authors LIMIT 0;
    LOCK TABLE #{Library::Author.table_name} IN SHARE MODE;
  SQL
end

def insert_into_new_table
  Library::BooksAuthor.connection.execute(<<-SQL)
    WITH authors_publishments(author_id, count) AS (
      SELECT author_id, COUNT(*)
      FROM #{Library::BooksAuthor.table_name} GROUP BY author_id
    )

    INSERT INTO authors_new(id, name, publishments_count)
    SELECT authors.id, authors.name, authors_publishments.count
    FROM authors, authors_publishments
    WHERE authors.id = authors_publishments.author_id;
  SQL
end

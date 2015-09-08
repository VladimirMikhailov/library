desc "Refresh the number of books has been published by years"
task :refresh_books_publishment_years do
  Library::BooksPublishmentYear.delete_all

  Library::BooksPublishmentYear.connection.execute(<<-SQL)
    WITH books_grouped_by_published_at AS (
      SELECT published_at, COUNT(#{Library::Book.primary_key})
      FROM #{Library::Book.table_name}
      GROUP BY published_at
    )

    INSERT INTO #{Library::BooksPublishmentYear.table_name}(id, count)
      SELECT * FROM books_grouped_by_published_at
      ORDER BY published_at;
  SQL
end

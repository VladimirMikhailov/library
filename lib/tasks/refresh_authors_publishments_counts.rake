desc "Refresh the number of books published by author"
task :refresh_authors_publishments_counts do
  Library::BooksAuthor.connection.execute(<<-SQL)
    WITH authors_publishments(author_id, count) AS (
      SELECT author_id, COUNT(*)
      FROM #{Library::BooksAuthor.table_name}
      GROUP BY author_id
    )

    UPDATE authors SET publishments_count = count
    FROM authors_publishments
    WHERE authors_publishments.author_id = authors.id
  SQL
end

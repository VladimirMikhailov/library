desc "Refresh the number of books grouped by first letter"
task :refresh_books_first_letters do
  Library::BooksFirstLetter.delete_all

  Library::BooksFirstLetter.connection.execute(<<-SQL)
    WITH books_grouped_by_first_letter(code, count) AS (
      SELECT ASCII(name), COUNT(#{Library::Book.primary_key})
      FROM #{Library::Book.table_name}
      WHERE ASCII(name) BETWEEN 65 AND 122
      GROUP BY ASCII(name)
    ), normalized_books_groups(first_letter, count) AS (
      SELECT UPPER(CHR(code)), SUM(count)
      FROM books_grouped_by_first_letter
      GROUP BY UPPER(CHR(code))
    )

    INSERT INTO #{Library::BooksFirstLetter.table_name}(id, count)
      SELECT * FROM normalized_books_groups
      ORDER BY first_letter;
  SQL
end

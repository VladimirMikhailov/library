module Library
  class UpdateAuthorsPublishmentsCounts
    include Interactor
    include IncrementableDecrementable

    def call
      Author
        .where(id: authors_ids)
        .update_all(<<-SQL)
          publishments_count =
            GREATEST(
              publishments_count #{increment_or_decrement_sign} #{CHANGE_BY},
              0
            )
        SQL
    end

    private

    def authors_ids
      BooksAuthor.where(book_id: context.book.id).pluck(:author_id)
    end
  end
end

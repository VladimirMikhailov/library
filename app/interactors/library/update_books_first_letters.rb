module Library
  class UpdateBooksFirstLetters
    include Interactor
    include IncrementableDecrementable

    def call
      BooksFirstLetter
        .where(id: name)
        .update_all("count = GREATEST(count #{increment_or_decrement_sign} #{CHANGE_BY}, 0)")
    end

    private

    def name
      context.book.name.slice(0).upcase
    end
  end
end

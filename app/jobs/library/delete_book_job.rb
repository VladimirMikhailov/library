module Library
  class DeleteBookJob < Que::Job
    def run(book_id)
      book = Book.find(book_id)

      ActiveRecord::Base.transaction do
        UpdateGraphsStats.call(book: book, action: "decrement")
        book.destroy
      end
    end
  end
end

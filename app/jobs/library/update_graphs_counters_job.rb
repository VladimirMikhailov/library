module Library
  class UpdateGraphsStatsJob < Que::Job
    def run(book_id, action)
      book = Book.find(book_id)

      ActiveRecord::Base.transaction do
        UpdateGraphsStats.call(book: book, action: action)
      end
    end
  end
end

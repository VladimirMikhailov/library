module Library
  class ListOfAuthors
    attr_reader :limit, :bulk_save
    private :limit, :bulk_save

    def initialize(limit: 5_000_000)
      @limit = limit
      @bulk_save = BulkSave.new(table: :authors)
    end

    def generate!
      bulk_save.save { authors }
    end

    private

    def authors
      authors = ''
      limit.times { authors << author }

      authors
    end

    def author
      "#{FFaker::Name.name}\n"
    end
  end
end

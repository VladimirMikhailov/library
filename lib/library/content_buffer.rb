module Library
  class ContentBuffer
    attr_reader :bulk_save
    private :bulk_save

    def initialize(bulk_save:)
      @bulk_save = bulk_save
    end

    def save(times:)
      return unless block_given?

      items = ""

      bulk_save.save(
        times.times { items << "#{yield}\n" } && items
      )
    end
  end
end

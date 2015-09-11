module Library
  class TopAuthorsPublishments
    TOP = 10

    class AuthorPublishments
      attr_accessor :id, :name, :publishments
      private :name, :publishments

      def initialize(id, name)
        @id = id
        @name = name
        @publishments = {}
      end

      def add(published_at, count)
        publishments[published_at] = count
      end

      def to_h
        { name: name, publishments: publishments }
      end
    end

    attr_accessor :author_publishments
    private :author_publishments

    def initialize
      @author_publishments = Hash[authors.map { |author| [author.id, author] }]
    end

    def all
      publishments.each do |(author_id, *publishments)|
        author_publishments[author_id].add(*publishments)
      end

      author_publishments.values.map(&:to_h)
    end

    private

    def publishments
      Book.joins(:books_authors)
        .where(books_authors: { author_id: author_ids })
        .group("author_id, published_at")
        .pluck("author_id, published_at, COUNT(published_at)")
    end

    def author_ids
      author_publishments.keys
    end

    def authors
      Author.order("publishments_count DESC")
        .where("publishments_count > 0")
        .limit(TOP)
        .pluck(:id, :name)
        .map { |author| AuthorPublishments.new(*author) }
    end
  end
end

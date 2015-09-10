module Library
  class GraphsSerializer < ActiveModel::Serializer
    attributes :publishments_by_years,
      :top_authors_publishments,
      :books_by_first_letters

    def initialize(options)
      super({}, options)
    end

    private

    def publishments_by_years
      options[:publishments_by_years]
    end

    def top_authors_publishments
      options[:top_authors_publishments]
    end

    def books_by_first_letters
      options[:books_by_first_letters]
    end
  end
end

module Library
  describe TopAuthorsPublishments do
    describe "#all" do
      let!(:author) do
        create(
          :author,
          books: create_books_published_at(1940, 2015),
          publishments_count: 2
        )
      end

      let!(:author1) do
        create(
          :author,
          books: create_books_published_at(2000, 1990, 1990),
          publishments_count: 3)
      end

      subject(:result) { described_class.new.all }

      it "returns books published by author by year" do
        expect(result).to eq([
          { name: author1.name, publishments: { 2000 => 1, 1990 => 2 } },
          { name: author.name, publishments: { 1940 => 1, 2015 => 1 } }
        ])
      end
    end

    def create_books_published_at(*dates)
      dates.map { |date| create(:book, published_at: date) }
    end
  end
end

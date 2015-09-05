module Library
  describe PaginatableQuery do
    describe "#all" do
      let(:per_page) { 2 }
      let(:direction) { "asc" }
      let(:last_seen_id) { nil }

      let!(:first_book) { create(:book, id: 1) }
      let!(:second_book) { create(:book, id: 2) }
      let!(:last_book) { create(:book, id: 3) }

      let(:first_page_books) { [first_book, second_book] }
      let(:all_books) { first_page_books << last_book }

      subject(:records) do
        described_class.new(
          Book.all,
          per_page: per_page,
          direction: direction,
          last_seen_id: last_seen_id
        )
      end

      context "when it is no last seen id" do
        let(:last_seen_id) { nil }

        it "returns records having id bigger then 0" do
          expect(records.all).to eq_records(first_page_books)
        end
      end

      context "when per page attributes is nil" do
        let(:per_page) { nil }

        it "returns PER_PAGE records" do
          expect(records.all).to eq_records(all_books)
        end
      end

      context "when direction param is not ASC or DESC" do
        let(:direction) { "buzz" }

        it "returns records in ASC direction" do
          expect(records.all).to eq_records(first_page_books)
        end
      end

      context "when last_seen_id is the last element from the first page" do
        let(:last_seen_id) { second_book.id }

        it "returns second page's records" do
          expect(records.all).to eq_records([last_book])
        end
      end

      context "when last_seen_id is the last element and direction is DESC" do
        let(:last_seen_id) { last_book.id }
        let(:direction) { "desc" }

        it "returns two books from the end" do
          expect(records.all).to eq_records([second_book, last_book])
        end
      end

      context "when last_seen_id is the last book and direction is DESC" do
        let(:last_seen_id) { second_book.id }
        let(:direction) { "DESC" }

        it "returns first page's records" do
          expect(records.all).to eq_records(first_page_books)
        end
      end
    end
  end
end
module Library
  describe PaginatableQuery do
    describe "#all" do
      let(:direction) { "asc" }
      let(:last_seen_id) { nil }

      let!(:first_book) { create(:book, id: 1) }
      let!(:second_book) { create(:book, id: 2) }
      let!(:last_book) { create(:book, id: 3) }

      let(:first_page_books) { [first_book, second_book] }
      let(:all_books) { first_page_books << last_book }

      subject(:records) do
        described_class.new(
          Book.all, "last_seen_id" => last_seen_id
        )
      end

      before do
        stub_const("Library::PaginatableQuery::PER_PAGE", 2)
      end

      context "when it is no last seen id" do
        let(:last_seen_id) { nil }

        it "returns records having id bigger then 0" do
          expect(records.all).to eq_records(first_page_books)
        end
      end

      context "when last_seen_id is the last element from the first page" do
        let(:last_seen_id) { second_book.id }

        it "returns second page's records" do
          expect(records.all).to eq_records([last_book])
        end
      end
    end
  end
end

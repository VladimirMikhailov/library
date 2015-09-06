module Library
  class PaginatableQuery
    describe ASCPaginated do
      let(:per_page) { 2 }
      let(:last_seen_id) { 0 }
      let(:collection) { Book.all }

      let(:paginated) do
        described_class.new(
          collection,
          per_page: per_page,
          last_seen_id: last_seen_id
        )
      end

      describe "#next?" do
        let(:collection) { 3.times.map { |i| double(id: i + 1) } }

        before do
          allow(paginated).to receive(:all).and_return(collection)
        end

        context "when it is first page" do
          it "has next elements" do
            expect(paginated).to be_next
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has not next elements" do
            expect(paginated).not_to be_next
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has not next elements" do
            expect(paginated).not_to be_next
          end
        end
      end

      describe "#previous?" do
        let(:collection) { 3.times.map { |i| double(id: i + 1) } }

        before do
          allow(paginated).to receive(:all).and_return(collection)
        end

        context "when it is first page" do
          it "has no previous elements" do
            expect(paginated).not_to be_previous
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has previous elements" do
            expect(paginated).to be_previous
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has no previous elements" do
            expect(paginated).not_to be_previous
          end
        end
      end

      describe "#all" do
        context "when it is next element" do
          let!(:collection_with_preloaded) { 3.times.map { |i| create(:book, id: i + 1) } }

          before { create(:book) }

          it "returns records with preloaded next" do
            expect(paginated.all).to eq_records(collection_with_preloaded)
          end
        end

        context "when it is both next and previous elements" do
          let!(:collection_with_preloaded) { (2..5).map { |i| create(:book, id: i) } }
          let(:last_seen_id) { 2 }

          before do
            create(:book, id: 1)
            create(:book, id: 6)
          end

          it "returns records with preloaded next and prev" do
            expect(paginated.all).to eq_records(collection_with_preloaded)
          end
        end
      end
    end
  end
end

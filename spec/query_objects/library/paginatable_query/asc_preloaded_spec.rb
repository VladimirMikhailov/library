module Library
  class PaginatableQuery
    describe AscPreloaded do
      let(:per_page) { 2 }
      let(:last_seen_id) { 0 }
      let(:collection) { 3.times.map { |i| double(id: i + 1) } }

      let(:asc_preloaded) do
        described_class.new(
          collection,
          per_page: per_page,
          last_seen_id: last_seen_id
        )
      end

      describe "#all" do
        let(:collection) { Book.all }

        context "when it is next element" do
          let!(:collection_with_preloaded) { create_list(:book, 3) }

          before { create(:book) }

          it "returns records with preloaded next" do
            expect(asc_preloaded.all).to eq_records(collection_with_preloaded)
          end
        end

        context "when it is both next and previous elements" do
          let(:collection) { Book.where("id > ?", last_seen_id).limit(per_page) }
          let!(:collection_with_preloaded) { (2..5).map { |i| create(:book, id: i) } }
          let(:last_seen_id) { 2 }

          before do
            create(:book, id: 1)
            create(:book, id: 6)
          end

          it "returns records with preloaded next and prev" do
            expect(asc_preloaded.all).to eq_records(collection_with_preloaded)
          end
        end
      end

      describe "#next?" do
        before do
          allow(asc_preloaded).to receive(:all).and_return(collection)
        end

        context "when it is first page" do
          it "has next elements" do
            expect(asc_preloaded).to be_next
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has not next elements" do
            expect(asc_preloaded).not_to be_next
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has not next elements" do
            expect(asc_preloaded).not_to be_next
          end
        end
      end

      describe "#previous?" do
        before do
          allow(asc_preloaded).to receive(:all).and_return(collection)
        end

        context "when it is first page" do
          it "has no previous elements" do
            expect(asc_preloaded).not_to be_previous
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has previous elements" do
            expect(asc_preloaded).to be_previous
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has no previous elements" do
            expect(asc_preloaded).not_to be_previous
          end
        end
      end
    end
  end
end

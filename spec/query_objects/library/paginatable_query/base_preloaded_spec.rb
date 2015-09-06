module Library
  class PaginatableQuery
    describe BasePreloaded do
      let(:per_page) { 2 }
      let(:last_seen_id) { 0 }
      let(:collection) { 3.times.map { |i| double(id: i + 1) } }

      let(:preloaded) do
        described_class.new(
          collection,
          per_page: per_page,
          last_seen_id: last_seen_id
        )
      end

      before do
        allow(preloaded).to receive(:all).and_return(collection)
      end

      describe "#next?" do
        context "when it is first page" do
          it "has next elements" do
            expect(preloaded).to be_next
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has not next elements" do
            expect(preloaded).not_to be_next
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has not next elements" do
            expect(preloaded).not_to be_next
          end
        end
      end

      describe "#previous?" do
        before do
          allow(preloaded).to receive(:all).and_return(collection)
        end

        context "when it is first page" do
          it "has no previous elements" do
            expect(preloaded).not_to be_previous
          end
        end

        context "when it is last page" do
          let(:last_seen_id) { 2 }

          it "has previous elements" do
            expect(preloaded).to be_previous
          end
        end

        context "when it is empty collection" do
          let(:collection) { [] }

          it "has no previous elements" do
            expect(preloaded).not_to be_previous
          end
        end
      end
    end
  end
end

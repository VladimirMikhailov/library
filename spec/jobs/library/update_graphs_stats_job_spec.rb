module Library
  describe UpdateGraphsStatsJob do
    describe "#run" do
      let(:action) { "increment" }
      let(:book) { create(:book, published_at: 1940) }
      let!(:books_publishment_year) { create(:books_publishment_year, id: 1940, count: 0) }

      before do
        allow(UpdateGraphsStats).to receive(:call).and_call_original
      end

      subject(:update_graphs_stats) { described_class.enqueue(book.id, action) }

      it "calls UpdateGraphsStats with book and action" do
        update_graphs_stats

        expect(UpdateGraphsStats).to have_received(:call).with(
          book: book,
          action: action
        )
      end

      it "updates caches" do
        update_graphs_stats

        expect(books_publishment_year.reload.count).to eq(1)
      end

      context "when any step raises error" do
        let(:fake_error) { Class.new(RuntimeError) }

        before do
          allow_any_instance_of(UpdateAuthorsPublishmentsCounts)
            .to receive(:call)
            .and_raise(fake_error)
        end

        it "rollbacks updates" do
          expect { update_graphs_stats }.to raise_error(fake_error)

          expect(books_publishment_year.reload.count).to eq(0)
        end
      end
    end
  end
end

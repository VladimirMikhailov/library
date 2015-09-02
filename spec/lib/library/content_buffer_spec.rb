module Library
  describe ContentBuffer do
    let(:limit) { 3 }
    let(:bulk_save) { instance_double("BulkSave") }

    subject(:buffer) { described_class.new(bulk_save: bulk_save) }

    before do
      allow(bulk_save).to receive(:save)
    end

    describe "#save" do
      it "saves generated content through bulk save" do
        buffer.save(times: limit) { "name" }

        expect(bulk_save).to have_received(:save).with("name\nname\nname\n")
      end

      it "calls a passed block 3 times" do
        expect { |block| buffer.save(times: limit, &block) }.to yield_control.exactly(limit).times
      end

      context "when block hasn't been passed" do
        it "saves nothing" do
          buffer.save(times: limit)

          expect(bulk_save).not_to have_received(:save)
        end
      end
    end
  end
end

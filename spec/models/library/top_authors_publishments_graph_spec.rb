module Library
  describe TopAuthorsPublishmentsGraph do
    let(:top_authors_publishments) { [{ name: "Author 1" }, { name: "Author 2" }] }

    before do
      allow_any_instance_of(TopAuthorsPublishments).to receive(:all)
        .and_return(top_authors_publishments)
    end

    describe ".fetch" do
      subject(:fetch) { described_class.fetch }

      it { is_expected.to eq(top_authors_publishments) }
    end

    describe ".update!" do
      subject(:update) { described_class.update! }

      it "writes top authors publishments to cache" do
        expect(redis_store.read(described_class::KEY)).to eq(top_authors_publishments)
      end
    end
  end
end

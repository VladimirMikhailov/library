module Library
  describe TopAuthorsPublishmentsGraph do
    let(:top_authors_publishments) { [{ name: "Author 1" }, { name: "Author 2" }] }

    before do
      stub_const("Library::TopAuthorsPublishments::KEY", "spec_example_top_authors")
      redis_store.delete(described_class::KEY)
      allow_any_instance_of(TopAuthorsPublishments).to receive(:all)
        .and_return(top_authors_publishments)
    end

    after do
      redis_store.delete(described_class::KEY)
    end

    describe ".fetch" do
      subject(:fetch) { described_class.fetch }

      it { is_expected.to eq(top_authors_publishments) }
    end

    describe ".update!" do
      subject(:update) { described_class.update! }

      it "writes top authors publishments to cache" do
        update
        expect(redis_store.read(described_class::KEY)).to eq(top_authors_publishments)
      end
    end
  end
end

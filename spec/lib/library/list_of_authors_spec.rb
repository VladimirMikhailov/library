module Library
  describe ListOfAuthors do
    let(:limit) { 3 }

    subject(:generate) { ListOfAuthors.new(limit: limit).generate! }

    describe "#generate!" do
      it "creates list of authors with random names" do
        expect { generate }.to change { Author.count }.to(limit)
      end
    end
  end
end

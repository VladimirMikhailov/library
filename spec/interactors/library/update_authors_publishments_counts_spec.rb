module Library
  describe UpdateAuthorsPublishmentsCounts do
    describe "#call" do
      let!(:author) { create(:author, book: book) }

      it_behaves_like "incrementable and decrementable" do
        let(:book) { build(:book, id: 1) }
        let(:checking_block) { -> { author.reload.publishments_count } }
      end

      context "when action is decrement" do
        let(:action) { "decrement" }
        let(:book) { build(:book, id: 1) }
        let!(:author) { create(:author, book: book, publishments_count: 1) }

        subject(:update) { described_class.call(book: book, action: action) }

        it "decrements the number of author's publishments count" do
          expect { update }.to change { author.reload.publishments_count }.to(0)
        end
      end
    end
  end
end

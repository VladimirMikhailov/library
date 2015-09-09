module Library
  describe UpdateBooksPublishmentYears do
    describe "#call" do
      let!(:books_publishment_year) { create(:books_publishment_year, id: 1940) }

      it_behaves_like "incrementable and decrementable" do
        let(:book) { build(:book, published_at: 1940) }
        let(:checking_block) { -> { books_publishment_year.reload.count } }
      end

      context "when action is decrement" do
        let(:action) { "decrement" }
        let(:book) { build(:book, published_at: 1940) }
        let!(:books_publishment_year) { create(:books_publishment_year, id: 1940, count: 1) }

        subject(:update) { described_class.call(book: book, action: action) }

        it "decrements the number of books publishments" do
          expect { update }.to change { books_publishment_year.reload.count }.to(0)
        end
      end
    end
  end
end

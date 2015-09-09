module Library
  describe UpdateBooksFirstLetters do
    describe "#call" do
      let!(:books_first_letter) { create(:books_first_letter, id: "A") }

      it_behaves_like "incrementable and decrementable" do
        let(:book) { build(:book, name: "Adblock") }
        let(:checking_block) { -> { books_first_letter.reload.count } }
      end

      context "when action is decrement" do
        let(:action) { "decrement" }
        let(:book) { build(:book, name: "Adblock") }
        let!(:books_first_letter) { create(:books_first_letter, id: "A", count: 1) }

        subject(:update) { described_class.call(book: book, action: action) }

        it "decrements the number of books publishments" do
          expect { update }.to change { books_first_letter.reload.count }.to(0)
        end
      end
    end
  end
end

module Library
  describe UpdateBooksFirstLetters do
    describe "#call" do
      let!(:books_first_letter) { create(:books_first_letter, id: "A") }
      let(:action) { "increment" }

      subject(:update) { described_class.call(book: book, action: action) }

      it_behaves_like "incrementable and decrementable" do
        let(:book) { build(:book, name: "Adblock") }
        let(:checking_block) { -> { books_first_letter.reload.count } }
      end

      context "when action is decrement" do
        let(:action) { "decrement" }
        let(:book) { build(:book, name: "Adblock") }
        let!(:books_first_letter) { create(:books_first_letter, id: "A", count: 1) }

        it "decrements the number of books publishments" do
          expect { update }.to change { books_first_letter.reload.count }.to(0)
        end
      end

      context "when book's name starts with downcase letter" do
        let(:book) { build(:book, name: "adblock") }

        it "decrements the number of books first letters" do
          expect { update }.to change { books_first_letter.reload.count }.to(1)
        end
      end
    end
  end
end

shared_examples "incrementable and decrementable" do
  let(:checking_block) { -> {} }
  let(:book) { build(:book) }

  subject(:update) { described_class.call(book: book, action: action) }

  context "when action is increment" do
    let(:action) { "increment" }

    it "increments the number of books publishments" do
      expect { update }.to change(&checking_block).to(1)
    end
  end

  context "when action is not increment or decrement" do
    let(:action) { "incrementfadf" }

    it "increments the number of books publishments" do
      expect { update }.to change(&checking_block).to(1)
    end
  end

  context "when action is decrement and count is zero" do
    let(:action) { "decrement" }

    before { update }

    it "decrements the number of books publishments up to zero" do
      expect(checking_block.call).to eq 0
    end
  end
end

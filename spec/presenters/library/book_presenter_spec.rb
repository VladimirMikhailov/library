module Library
  describe BookPresenter do
    let(:book) { build_stubbed(:book) }

    before { book.valid? }

    describe "#valid_class" do
      let(:attribute) { :name }
      subject { described_class.new(book).valid_class(attribute) }

      context "when name is valid" do
        it { is_expected.to eq "" }
      end

      context "when name is invalid" do
        let(:book) { build_stubbed(:book, name: "") }

        it { is_expected.to eq "invalid" }
      end

      context "when published_at is invalid and checking for published_at" do
        let(:attribute) { :published_at }
        let(:book) { build_stubbed(:book, published_at: 1) }

        it { is_expected.to eq "invalid" }
      end

      context "when name is invalid and checking for published_at" do
        let(:attribute) { :published_at }

        it { is_expected.to eq "" }
      end
    end

    describe "#name_label" do
      subject { described_class.new(book).name_label }

      context "when it is no validation errors on name" do
        it { is_expected.to eq "Name" }
      end

      context "when it is any validation error on name" do
        let(:book) { build_stubbed(:book, name: "") }

        it "returns the validation error" do
          expect(subject).to eq("can't be blank")
        end
      end
    end

    describe "#published_at_label" do
      subject { described_class.new(book).published_at_label }

      context "when it is no validation errors on published_at" do
        it { is_expected.to eq "Published at" }
      end

      context "when it is any validation error on name" do
        let(:book) { build_stubbed(:book, published_at: -1231) }

        it "returns the validation error" do
          expect(subject).to eq("is not included in the list")
        end
      end
    end
  end
end

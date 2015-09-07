module Library
  describe BooksHelpers do
    describe "books_path" do
      let(:params) { {} }
      let(:book) { nil }

      subject { described_class.books_path(book, params) }

      context "when it is no params" do
        it { is_expected.to eq "/books" }
      end

      context "when is no params and book is provided" do
        let(:book) { double(:book, id: 1) }

        it { is_expected.to eq "/books/1" }
      end

      context "when it is params with blank or nils" do
        let(:params) { { my_params: nil, another_param: "" } }

        it { is_expected.to eq "/books" }
      end

      context "when it is any param" do
        let(:params) { { my_params: "value", another_param: "" } }

        it { is_expected.to eq "/books?my_params=value" }
      end

      context "when it is any params and book is provided" do
        let(:book) { double(:book, id: 1) }
        let(:params) { { one: "one", two: "two" } }

        it { is_expected.to eq "/books/1?one=one&two=two" }
      end
    end
  end
end

module Library
  describe BooksController do
    describe "GET /books" do
      it "responds with OK status" do
        get "/books"

        expect(last_response).to be_ok
      end
    end

    describe "POST /books" do
      let(:book) { double(:book) }
      let(:save_result) { false }

      before do
        allow(Book).to receive(:new).and_return(book)
        allow(book).to receive(:save).and_return(save_result)
      end

      it "initializes Book with whitelisted params" do
        post("/books", book: { name: "My book", another_param: "test" })

        expect(Book).to have_received(:new).with("name" => "My book")
      end

      context "when saved successfully" do
        let(:save_result) { true }

        it "redirects to the books page" do
          post("/books")

          expect(last_response).to be_redirect
          expect(last_response.location).to end_with("/books")
        end
      end
    end
  end
end

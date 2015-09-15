module Library
  describe BooksController do
    describe "GET /books" do
      it "responds with OK status" do
        get "/books"

        expect(last_response).to be_ok
      end

      context "when request is XHR" do
        it "responds only with collection block" do
          get("/books", {}, "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest")

          expect(last_response.body).to eq("<ul class=\"collection\" data-path=\"/books\"></ul>")
        end
      end
    end

    describe "POST /books" do
      let(:book) { double(:book, id: 1) }
      let(:save_result) { false }

      before do
        allow(Book).to receive(:new).and_return(book)
        allow(book).to receive(:save).and_return(save_result)
        allow(UpdateGraphsStatsJob).to receive(:enqueue)
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

        it "runs update graphs stats job" do
          post("/books")

          expect(UpdateGraphsStatsJob).to have_received(:enqueue).with(book.id, "increment")
        end
      end
    end
  end
end

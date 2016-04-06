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
  end
end

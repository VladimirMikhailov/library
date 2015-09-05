module Library
  describe BooksController do
    describe "GET /books" do
      it "responds with OK status" do
        get "/books"

        expect(last_response).to be_ok
      end
    end
  end
end

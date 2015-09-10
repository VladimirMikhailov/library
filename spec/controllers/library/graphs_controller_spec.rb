module Library
  describe GraphsController do
    let(:publishments_by_years) { [12, 20] }
    let(:books_by_first_letters) { [10, 30] }
    let(:top_authors_publishments) { build_list(:top_author_publishments, 2) }

    before do
      stub_method(:publishments_by_years, publishments_by_years)
      stub_method(:books_by_first_letters, books_by_first_letters)
      stub_method(:top_authors_publishments, top_authors_publishments)
    end

    describe "GET /graphs" do
      context "with application/json content" do
        it "responds with graphs data" do
          get("/graphs", "Content-Type" => "application/json")

          expect(JSON.parse(last_response.body)).to have_graph_representation(
            publishments_by_years,
            books_by_first_letters,
            top_authors_publishments
          )
        end
      end

      it "responds with OK status" do
        get "/graphs"

        expect(last_response).to be_ok
      end
    end

    def stub_method(method, value)
      allow_any_instance_of(described_class).to receive(method).and_return(value)
    end
  end
end

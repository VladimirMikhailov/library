module Library
  class GraphsController < ApplicationController
    register Sinatra::RespondWith

    assets do
      serve "/js", from: "assets/javascripts"
      js :application, %w(/js/*.js)
      js_compression :jsmin
    end

    get "/graphs" do
      respond_to do |format|
        format.json { json(graphs_serializer) }
        format.html do
          slim(
            :"graphs/index",
            locals: { graphs: graphs_serializer }
          )
        end
      end
    end

    private

    def graphs_serializer
      GraphsSerializer.new(
        publishments_by_years: publishments_by_years,
        top_authors_publishments: top_authors_publishments,
        books_by_first_letters: books_by_first_letters
      )
    end

    def publishments_by_years
      BooksFirstLetter.order("id").pluck(:count)
    end

    def top_authors_publishments
      TopAuthorsPublishmentsGraph.fetch
    end

    def books_by_first_letters
      BooksFirstLetter.order("id").pluck(:count)
    end
  end
end

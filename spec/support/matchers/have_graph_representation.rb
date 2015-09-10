RSpec::Matchers.define :have_graph_representation do |*values|
  match do |actual|
    expect(actual).to eq(
      "graphs" => {
        "publishments_by_years" => values[0],
        "books_by_first_letters" => values[1],
        "top_authors_publishments" => values[2]
      }
    )
  end
end

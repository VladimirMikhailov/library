RSpec::Matchers.define :change_graphs_stats do |**values|
  match do |change_block|
    first_letter_stats = count_first_letter_stats(values[:name])
    years_stats = count_years_stats(values[:published_at])

    change_block.call

    expect(count_first_letter_stats(values[:name])).to eq(first_letter_stats + @change_by)
    expect(count_years_stats(values[:published_at])).to eq(years_stats + @change_by)
  end

  chain :by do |expected_delta|
    @change_by = expected_delta
  end

  def failure_message
    "expected graphs stats to have changed, but didn't"
  end

  def supports_block_expectations?
    true
  end

  def count_first_letter_stats(name)
    Library::BooksFirstLetter.where(id: name.first.upcase).first.count
  end

  def count_years_stats(published_at)
    Library::BooksPublishmentYear.where(id: published_at).first.count
  end
end

RSpec::Matchers.define :eq_records do |expected|
  match do |actual|
    expect(actual.map(&:id)).to eq(expected.map(&:id))
  end
end

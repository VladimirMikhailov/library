desc "Generate the list of authors containing 40kk records"
task :generate_books do
  progressbar = ProgressBar.create(title: "Generate Books", total: 40)
  bulk_save = Library::BulkSave.new(table: :books, columns: %i(name published_at))
  buffer = Library::ContentBuffer.new(bulk_save: bulk_save)

  40.times do
    buffer.save(times: 1_000_000) do
      "#{FFaker::Name.name},#{rand(Library::Book::PUBLISHMENTS)}"
    end

    progressbar.increment
  end
end

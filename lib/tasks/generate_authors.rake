desc "Generate the list of authors containing 5kk records"
task :generate_authors do
  progressbar = ProgressBar.create(title: "Generate Authors", total: 10)
  buffer = Library::ContentBuffer.new(bulk_save: Library::BulkSave.new(table: :authors))

  10.times do
    buffer.save(times: 500_000) { FFaker::Name.name }

    progressbar.increment
  end
end

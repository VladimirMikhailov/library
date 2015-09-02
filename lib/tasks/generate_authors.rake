desc "Generate the list of authors containing 5kk records"
task :generate_authors do
  progressbar = ProgressBar.create(title: "Generate Authors", total: 10)

  10.times do
    Library::ListOfAuthors.new(limit: 500_000).generate!
    progressbar.increment
  end
end

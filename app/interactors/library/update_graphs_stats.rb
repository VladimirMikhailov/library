module Library
  class UpdateGraphsStats
    include Interactor::Organizer

    organize UpdateBooksPublishmentYears,
      UpdateBooksFirstLetters,
      UpdateAuthorsPublishmentsCounts
  end
end

module Library
  class Book < ActiveRecord::Base
    PUBLISHMENTS = (1940..2015)

    validates :name, presence: true
    validates :published_at, presence: true, inclusion: PUBLISHMENTS

    has_many :books_authors
    has_many :authors, through: :books_authors

    scope :active, -> { where(deleted_at: nil) }
  end
end

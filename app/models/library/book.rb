module Library
  class Book < ActiveRecord::Base
    PUBLISHMENTS = (1940..2015)

    validates :name, presence: true
    validates :published_at, presence: true, inclusion: PUBLISHMENTS
  end
end

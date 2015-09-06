module Capybara
  class Session
    def has_first_page_controls?
      has_no_link?("Previous") && has_link?("Next")
    end
  end
end

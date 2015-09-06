module Capybara
  class Session
    def has_last_page_controls?
      has_link?("Previous") && has_no_link?("Next")
    end
  end
end

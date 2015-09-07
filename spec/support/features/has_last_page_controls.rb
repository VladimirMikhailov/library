module Capybara
  class Session
    def has_last_page_controls?
      has_selector?(:previous_page_link) && has_selector?(:next_page_link_disabled)
    end
  end
end

module Capybara
  class Session
    def has_first_page_controls?
      has_selector?(:previous_page_link_disabled) && has_selector?(:next_page_link)
    end
  end
end

module Capybara
  class Session
    def has_label_text?(input, text)
      find(:input_label, input).text == text
    end
  end
end

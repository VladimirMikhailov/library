module Library
  module IncrementableDecrementable
    DECREMENT = "decrement"
    CHANGE_BY = 1

    def increment_or_decrement_sign
      context.action == DECREMENT ? "-" : "+"
    end
    module_function :increment_or_decrement_sign
  end
end

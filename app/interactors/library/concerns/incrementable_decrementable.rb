module Library
  module IncrementableDecrementable
    DECREMENT = "decrement"
    CHANGE_BY = 1

    module_function def increment_or_decrement_sign
      context.action == DECREMENT ? "-" : "+"
    end
  end
end

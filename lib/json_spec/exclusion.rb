module JsonSpec
  module Exclusion
    def excluded_keys
      @excluded_keys ||= Set.new(JsonSpec.excluded_keys)
    end
  end
end

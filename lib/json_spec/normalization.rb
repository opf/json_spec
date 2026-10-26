require "json"

module JsonSpec
  module Normalization
    extend self

    def normalize(ruby, excluded_keys: [])
      generate(scrub(ruby, excluded_keys))
    end

    private
      def scrub(ruby, excluded_keys)
        case ruby
        when Hash
          ruby.sort_by { |key, _| key.to_s }.each_with_object({}) do |(key, value), hash|
            hash[key] = scrub(value, excluded_keys) unless excluded_keys.include?(key)
          end
        when Array
          ruby.map { |value| scrub(value, excluded_keys) }
        else ruby
        end
      end

      def generate(ruby)
        case ruby
        # JSON.parse reads numbers too large for a float as Infinity.
        when Hash, Array then JSON.pretty_generate(ruby, allow_nan: true)
        else JSON.generate(ruby, allow_nan: true)
        end
      end
  end
end

class Numeric
  @@currencies = {
    "dollar" => 1.0,
    "euro" => 1.292,
    "rupee" => 0.019,
    "yen" => 0.013
  }

  def method_missing(method_id, *args, &block)
    singular_currency = method_id.to_s.gsub(/s$/, "")

    if args.empty? && @@currencies.key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def respond_to_missing?(method_id, include_private = false)
    @@currencies.key?(method_id.to_s.gsub(/s$/, "")) || super
  end

  def in(currency)
    singular_currency = currency.to_s.gsub(/s$/, "")
    raise NoMethodError, "unknown currency: #{currency}" unless @@currencies.key?(singular_currency)

    self / @@currencies[singular_currency]
  end
end

class String
  def palindrome?
    normalized = downcase.gsub(/\W/, "")
    normalized == normalized.reverse
  end
end

module Enumerable
  def palindrome?
    to_a == to_a.reverse
  end
end

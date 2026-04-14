def palindrome?(string)
  normalized = string.downcase.gsub(/\W/, "")
  normalized == normalized.reverse
end
